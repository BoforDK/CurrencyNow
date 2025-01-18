//
//  CurrencyApiHandler.swift
//  CurrencyNow
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import Foundation

public protocol CurrencyApiHandlerProtocol {
    func allCurrencies() async throws -> [Currency]
}

// MARK: - APIHandler

public class CurrencyApiHandler: CurrencyApiHandlerProtocol {

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
}
