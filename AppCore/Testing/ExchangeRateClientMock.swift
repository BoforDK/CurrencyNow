//
//  ExchangeRateClientMock.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import Foundation

public final class ExchangeRateClientMock: ExchangeRateClientProtocol {
    public init() {}

    public func allCurrencies() async throws -> [Currency] {
        .mock
    }

    public func exchangeRates(
        fromDate: Date,
        toDate: Date,
        currencyCode: CurrencyCode
    ) async throws -> [ExchangeRate] {
        .mock
    }
}
