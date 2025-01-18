//
//  ExchangeRateDetailFeature.swift
//  ExchangeRateDetail
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import SwiftUI
import ComposableArchitecture
import AppCore
import AppDependencies

@Reducer
public struct ExchangeRateDetailFeature {
    @Dependency(\.exchangeRateClient) var exchangeRateClient
    
    public init() {}

    @ObservableState
    public struct State: Equatable {
        var exchangeRate: ExchangeRate
        var referenceCurrency: CurrencyCode
        
        public init(
            exchangeRate: ExchangeRate,
            referenceCurrency: CurrencyCode
        ) {
            self.exchangeRate = exchangeRate
            self.referenceCurrency = referenceCurrency
        }
        
        var navigationTitle: String {
            [
                exchangeRate.currencyCode.flag,
                exchangeRate.name
            ].joined(separator: " ")
        }
    }

    public enum Action {
    }

    public var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
