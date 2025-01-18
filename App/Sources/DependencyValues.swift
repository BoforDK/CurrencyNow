//
//  Untitled.swift
//  App
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import ComposableArchitecture
import AppCore

private let network: Networking = Network(apiKey: Environment.apiKey)

enum CurrencyApiHandlerKey: DependencyKey {
    static let liveValue: CurrencyApiHandlerProtocol = CurrencyApiHandler(
        network: network
    )
}

public extension DependencyValues {
    var currencyApiHandler: CurrencyApiHandlerProtocol {
        get { self[CurrencyApiHandlerKey.self] }
        set { self[CurrencyApiHandlerKey.self] = newValue }
    }
}
