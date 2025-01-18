//
//  DependencyMocks.swift
//  CurrencyNow
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import ComposableArchitecture
import AppCore

extension ExchangeRateClientKey: TestDependencyKey {
    static let testValue: ExchangeRateClientProtocol = ExchangeRateClientMock()
}
