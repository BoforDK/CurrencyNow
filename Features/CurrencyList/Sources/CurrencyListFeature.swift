//
//  CurrencyListFeature.swift
//  CurrencyList
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import SwiftUI
import ComposableArchitecture
import AppCore

@Reducer
public struct CurrencyListFeature {
    public init() {}

    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case goToDetail
        
        case delegate(Delegate)
        public enum Delegate {
            case goToDetail
        }
    }

    public var body: some Reducer<State, Action> {
        Reduce(mainReducer)
    }
    
    private func mainReducer( _ state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .goToDetail:
            return .send(.delegate(.goToDetail))
            
        case .delegate:
            return .none
        }
    }
}

