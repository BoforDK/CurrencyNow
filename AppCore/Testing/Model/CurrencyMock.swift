//
//  CurrencyMock.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

extension Currency {
    static func mock(
        country: String = "EU",
        name: String = "euro",
        currencyCode: String = "EUR",
        longName: String = "euro"
    ) -> Currency {
        Currency(
            country: country,
            name: name,
            currencyCode: .init(value: currencyCode),
            longName: longName
        )
    }
}

extension [Currency] {
    static var mock: [Currency] {
        [
            .mock(),
            .mock(
                country: "USA",
                name: "dollar",
                currencyCode: "USD",
                longName: "americký dolar"
            ),
            .mock(
                country: "Czechia",
                name: "koruna",
                currencyCode: "CZK",
                longName: "česká koruna"
            ),
        ]
    }
}
