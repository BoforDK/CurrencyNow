//
//  ContentFeature.swift
//  App
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import AppCore
import ComposableArchitecture

@Reducer
struct ContentFeature {

    @ObservableState
    struct State: Equatable {
    }

    enum Action {
    }

    var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
