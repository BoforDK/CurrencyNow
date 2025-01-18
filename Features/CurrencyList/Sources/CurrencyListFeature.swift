//
//  CurrencyListFeature.swift
//  CurrencyList
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import SwiftUI
import ComposableArchitecture
import AppCore
import AppDependencies

@Reducer
public struct CurrencyListFeature {
    @Dependency(\.exchangeRateClient) var exchangeRateClient
    
    public init() {}

    @ObservableState
    public struct State: Equatable {
        @Shared(.appStorage("sharedCurrencyCode")) var sharedCurrencyCode: String? = nil
        
        var screenState: ScreenState
        
        var currencies: [Currency]
        var exchangeRates: [ExchangeRate]
        
        var isCurrenciesSheetPresented: Bool
        var selectedCurrencyCode: CurrencyCode?
        
        public init(
            screenState: ScreenState = .loading,
            currencies: [Currency] = [],
            exchangeRates: [ExchangeRate] = [],
            isCurrenciesSheetPresented: Bool = false,
            selectedCurrency: CurrencyCode? = nil
        ) {
            self.screenState = screenState
            self.currencies = currencies
            self.exchangeRates = exchangeRates
            self.isCurrenciesSheetPresented = isCurrenciesSheetPresented
            self.selectedCurrencyCode = selectedCurrencyCode
        }
        
        var interactiveCurrencySheetDismissDisabled: Bool {
            selectedCurrencyCode == nil
        }
        
        var navigationTitle: String {
            if let selectedCurrencyCode {
                "Exchange Rate: \(selectedCurrencyCode.value)"
            } else {
                "Exchange Rate"
            }
        }
    }

    public enum Action: ViewAction {
        case onAppear
        
        case fetchCurrencies
        case fetchCurrenciesResult(Result<[Currency], Error>)
        
        case fetchExchangeRates(CurrencyCode)
        case fetchExchangeRatesResult(Result<[ExchangeRate], Error>)
        
        case selectCurrency(CurrencyCode)
        
        case view(View)

        public enum Alert: Equatable, Sendable {}

        @CasePathable
        public enum View: BindableAction {
            case binding(BindingAction<State>)
            case goToDetail(ExchangeRate)
        }
        
        case delegate(Delegate)
        public enum Delegate {
            case goToDetail(ExchangeRate, CurrencyCode)
        }
    }

    public var body: some Reducer<State, Action> {
        BindingReducer(action: \.view)
        
        Reduce(mainReducer)
    }
    
    private func mainReducer( _ state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .send(.fetchCurrencies)
            
        case .fetchCurrencies:
            return .run { send in
                do {
                    let allCurrencies = try await exchangeRateClient.allCurrencies()
                    
                    await send(.fetchCurrenciesResult(.success(allCurrencies)))
                } catch {
                    await send(.fetchCurrenciesResult(.failure(error)))
                }
            }
            
        case let .fetchCurrenciesResult(result):
            switch result {
            case let .success(data):
                state.currencies = data
                
                if
                    let code = state.sharedCurrencyCode,
                    let currency = state.currencies.first(
                        where: {
                            $0.currencyCode.value == code
                        }
                    )
                {
                    return .send(.selectCurrency(currency.currencyCode))
                } else {
                    state.isCurrenciesSheetPresented = true
                    
                    return .none
                }
                
            case .failure:
                state.screenState = .error
                
                return .none
            }
            
        case let .fetchExchangeRates(currencyCode):
            return .run { send in
                do {
                    let exchangeRates = try await exchangeRateClient.exchangeRates(
                        fromDate: .now.subtractDays(count: 1),
                        toDate: .now,
                        currencyCode: currencyCode
                    )
                    
                    await send(.fetchExchangeRatesResult(.success(exchangeRates)))
                } catch {
                    await send(.fetchExchangeRatesResult(.failure(error)))
                }
            }
            
        case let .fetchExchangeRatesResult(result):
            switch result {
            case let .success(data):
                state.screenState = .loaded
                state.exchangeRates = data
                
                return .none
            case .failure:
                state.screenState = .error
                
                return .none
            }
            
        case let .selectCurrency(code):
            state.isCurrenciesSheetPresented = false
            state.selectedCurrencyCode = code
            state.$sharedCurrencyCode.withLock{
                $0 = code.value
            }
            state.screenState = .loading
            
            return .send(.fetchExchangeRates(code))
            
        case let .view(viewAction):
            switch viewAction {
            case .binding:
                return .none
                
            case let .goToDetail(exchangeRate):
                guard let selectedCurrencyCode = state.selectedCurrencyCode else {
                    return .none
                }
                
                return .send(
                    .delegate(
                        .goToDetail(exchangeRate, selectedCurrencyCode)
                    )
                )
            }
            
        case .delegate:
            return .none
        }
    }
}
