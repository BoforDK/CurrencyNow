//
//  ExchangeRateClient.swift
//  CurrencyNow
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import Foundation

public protocol ExchangeRateClientProtocol {
    func allCurrencies() async throws -> [Currency]

    func exchangeRates(
        fromDate: Date,
        toDate: Date,
        currencyCode: CurrencyCode
    ) async throws -> [ExchangeRate]
}

// MARK: - APIHandler

public class ExchangeRateClient: ExchangeRateClientProtocol {

    private let network: Networking
    private let language: ApiLanguage

    public init(
        network: Networking,
        language: ApiLanguage = .en
    ) {
        self.network = network
        self.language = language
    }

    public func allCurrencies() async throws -> [Currency] {
        let link = Environment.apiURL + "/exchangerates/currencies?lang=\(language)"

        guard let url = URL(string: link) else {
            throw RequestError.incorrectURL
        }

        let apiCurrencies = try await network.sendGetRequest(
            type: [ApiCurrency].self,
            url: url
        )

        return ApiCurrenciesMapper().map(apiCurrencies: apiCurrencies)
    }

    public func exchangeRates(
        fromDate: Date,
        toDate: Date,
        currencyCode: CurrencyCode
    ) async throws -> [ExchangeRate] {
        let fromDate = DateFormatters.apiDay.string(from: fromDate)
        let toDate = DateFormatters.apiDay.string(from: toDate)
        let query = [
            "fromDate=\(fromDate)",
            "toDate=\(toDate)",
            "curr=\(currencyCode.value)",
            "lang=\(language)",
        ].joined(separator: "&")
        let link = Environment.apiURL + "/exchangerates/?" + query

        guard let url = URL(string: link) else {
            throw RequestError.incorrectURL
        }

        let apiExchangeRates = try await network.sendGetRequest(
            type: [ApiExchangeRate].self,
            url: url
        )

        return ApiExchangeRateMapper().map(apiExchangeRates: apiExchangeRates)
    }
}
