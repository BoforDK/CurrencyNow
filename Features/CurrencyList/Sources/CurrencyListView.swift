//
//  CurrencyListView.swift
//  CurrencyList
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import SwiftUI
import ComposableArchitecture
import AppCore
import AppUI

@ViewAction(for: CurrencyListFeature)
public struct CurrencyListView: View {
    @Bindable private var store: StoreOf<CurrencyListFeature>
    
    @ScaledMetric(relativeTo: .body) var toolBarIconSize: CGFloat = 15
    
    public init(
        store: StoreOf<CurrencyListFeature>
    ) {
        self.store = store
    }

    public var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ForEach(store.exchangeRates, id: \.currencyCode) { exchangeRate in
                        ExchangeRateItem(
                            exchangeRate: exchangeRate,
                            comparedCurrency: store.selectedCurrencyCode
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    currencySheetButton
                }
            }
            .screenState(store.screenState)
        }
        .task {
            store.send(.onAppear)
        }
        .navigationTitle(store.navigationTitle)
        .sheet(
            isPresented: $store.isCurrenciesSheetPresented,
            content: currencySheet
        )
    }
    
    private func currencySheet() -> some View {
        ScrollView {
            VStack {
                ForEach(store.currencies, id: \.currencyCode) { currency in
                    CurrencyItem(
                        currency: currency,
                        action: {
                            store.send(.selectCurrency(currency.currencyCode))
                        }
                    )
                }
            }
        }
        .interactiveDismissDisabled(store.interactiveCurrencySheetDismissDisabled)
    }

    private var currencySheetButton: some View {
        Button {
            store.send(.view(.set(\.isCurrenciesSheetPresented, true)))
        } label: {
            Image(systemName: "arrow.left.arrow.right")
                .resizable()
                .scaledToFit()
                .frame(width: toolBarIconSize, height: toolBarIconSize)
        }
    }
}

#if DEBUG
#Preview {
    CurrencyListView(
        store: .init(
            initialState: .init(
                screenState: .loaded,
                currencies: .mock,
                exchangeRates: .mock
            ),
            reducer: EmptyReducer.init
        )
    )
}
#endif
