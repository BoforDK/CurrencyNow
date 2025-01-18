//
//  RootFlowDelegate.swift
//  App
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import SwiftUI
import AppCore
import ComposableArchitecture
import CurrencyList
import ExchangeRateDetail

struct RootFlowDelegate: View {
    typealias Action = RootFlowDelegateFeature.Action

    @Bindable var store: StoreOf<RootFlowDelegateFeature>

    var body: some View {
        NavigationStack(path: $store.screens) {
            CurrencyListView(
                store: store.scope(
                    state: \.currencyList,
                    action: \.currencyListAction
                )
            )
            .navigationDestination(for: RootFlowDelegateScreen.self) { screen in
                switch screen {
                case let .detail(exchangeRate, currencyCode):
                    ExchangeRateDetailView(
                        store: .init(
                            initialState: .init(
                                exchangeRate: exchangeRate,
                                referenceCurrency: currencyCode
                            ),
                            reducer: ExchangeRateDetailFeature.init
                        )
                    )
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    RootFlowDelegate(
        store: .init(
            initialState: .init(),
            reducer: EmptyReducer.init
        )
    )
}
#endif
