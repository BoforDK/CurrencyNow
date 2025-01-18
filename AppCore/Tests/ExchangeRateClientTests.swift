//
//  ExchangeRateClientTests.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import XCTest

@testable import AppCore

final class ExchangeRateClientTests: XCTestCase {
    var networkMock: NetworkFake!
    var exchangeRateClient: ExchangeRateClient!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        networkMock = nil
        exchangeRateClient = nil
        super.tearDown()
    }

    func testAllCurrenciesURL() async throws {
        // Given
        let mockCurrencies: [ApiCurrency] = []
        let mockData = try JSONEncoder().encode(mockCurrencies)
        let expectedURL = "\(Environment.apiURL)/exchangerates/currencies?lang=\(ApiLanguage.en)"
        var apiUrl: String? = nil

        networkMock = NetworkFake { _, url in
            apiUrl = url.absoluteString

            return .success(mockData)
        }
        exchangeRateClient = ExchangeRateClient(
            network: networkMock,
            language: .en
        )

        // When
        let _ = try await exchangeRateClient.allCurrencies()

        // Then
        XCTAssertEqual(expectedURL, apiUrl)
    }

    func testAllCurrenciesSuccess() async throws {
        // Given
        let mockCurrencies: [ApiCurrency] = [
            .mock()
        ]
        let mockData = try JSONEncoder().encode(mockCurrencies)

        networkMock = NetworkFake { _, url in
            return .success(mockData)
        }
        exchangeRateClient = ExchangeRateClient(network: networkMock)

        // When
        let result = try await exchangeRateClient.allCurrencies()

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].country, "EU")
        XCTAssertEqual(result[0].name, "euro")
        XCTAssertEqual(result[0].currencyCode, CurrencyCode(value: "EUR"))
        XCTAssertEqual(result[0].longName, "euro")
    }

    func testAllCurrenciesError() async {
        // Given
        networkMock = NetworkFake { _, _ in
            return .failure(RequestError.incorrectURL)
        }
        exchangeRateClient = ExchangeRateClient(network: networkMock, language: .en)

        // When/Then
        do {
            let _ = try await exchangeRateClient.allCurrencies()
            XCTFail("Shouldn't be called")
        } catch RequestError.incorrectURL {
        } catch {
            XCTFail("Shouldn't be called")
        }
    }
}
