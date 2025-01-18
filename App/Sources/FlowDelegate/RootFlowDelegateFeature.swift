//
//  RootFlowDelegateFeature.swift
//  App
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import SwiftUI
import ComposableArchitecture
import AppCore
import CurrencyList

@Reducer
struct RootFlowDelegateFeature {

    @ObservableState
    struct State: Equatable {
        var screens: NavigationPath = .init()

        var currencyList: CurrencyListFeature.State = .init()
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)

        case currencyListAction(CurrencyListFeature.Action)

        case goToDetail
    }

    var body: some Reducer<State, Action> {
        BindingReducer()

        Reduce(mainReducer)

        Scope(
            state: \.currencyList,
            action: \.currencyListAction,
            child: CurrencyListFeature.init
        )
    }

    private func mainReducer( _ state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .binding:
            return .none

        case let .currencyListAction(action):
            switch action {
            case let .delegate(delegateAction):
                switch delegateAction{
                case .goToDetail:
                    return .send(.goToDetail)
                }
            default:
                return .none
            }

        case .goToDetail:
            state.screens.append(RootFlowDelegateScreen.detail)

            return .none
        }
    }
}

