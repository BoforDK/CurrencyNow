//
//  Untitled.swift
//  App
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import ComposableArchitecture
import AppCore

private let network: Networking = Network(apiKey: Environment.apiKey)

enum ExchangeRateClientKey: DependencyKey {
    static let liveValue: ExchangeRateClientProtocol = ExchangeRateClient(
        network: network
    )
}

public extension DependencyValues {
    var exchangeRateClient: ExchangeRateClientProtocol {
        get { self[ExchangeRateClientKey.self] }
        set { self[ExchangeRateClientKey.self] = newValue }
    }
}
