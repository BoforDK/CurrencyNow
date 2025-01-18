//
//  RootFlowDelegateFeature.swift
//  App
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import SwiftUI
import ComposableArchitecture
import AppCore
import ExchangeRateList

@Reducer
struct RootFlowDelegateFeature {

    @ObservableState
    struct State: Equatable {
        var screens: NavigationPath = .init()

        var exchangeRateList: ExchangeRateListFeature.State = .init()
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)

        case exchangeRateListAction(ExchangeRateListFeature.Action)

        case goToDetail(ExchangeRate, CurrencyCode)
    }

    var body: some Reducer<State, Action> {
        BindingReducer()

        Reduce(mainReducer)

        Scope(
            state: \.exchangeRateList,
            action: \.exchangeRateListAction,
            child: ExchangeRateListFeature.init
        )
    }

    private func mainReducer( _ state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .binding:
            return .none

        case let .exchangeRateListAction(action):
            switch action {
            case let .delegate(delegateAction):
                switch delegateAction{
                case let .goToDetail(exchangeRate, selectedCurrency):
                    return .send(.goToDetail(exchangeRate, selectedCurrency))
                }
            default:
                return .none
            }

        case let .goToDetail(exchangeRate, selectedCurrency):
            state.screens.append(
                RootFlowDelegateScreen.detail(exchangeRate, selectedCurrency)
            )

            return .none
        }
    }
}

