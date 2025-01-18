//
//  CurrencyApiHandlerTests.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import XCTest

@testable import AppCore

final class CurrencyApiHandlerTests: XCTestCase {
    var networkMock: NetworkFake!
    var currencyApiHandler: CurrencyApiHandler!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        networkMock = nil
        currencyApiHandler = nil
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
        currencyApiHandler = CurrencyApiHandler(
            network: networkMock,
            language: .en
        )

        // When
        let _ = try await currencyApiHandler.allCurrencies()

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
        currencyApiHandler = CurrencyApiHandler(network: networkMock)

        // When
        let result = try await currencyApiHandler.allCurrencies()

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
        currencyApiHandler = CurrencyApiHandler(network: networkMock, language: .en)

        // When/Then
        do {
            let _ = try await currencyApiHandler.allCurrencies()
            XCTFail("Shouldn't be called")
        } catch RequestError.incorrectURL {
        } catch {
            XCTFail("Shouldn't be called")
        }
    }
}
