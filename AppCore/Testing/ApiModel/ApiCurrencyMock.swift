//
//  ApiCurrencyMock.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

extension ApiCurrency {
    static func mock(
        country: String = "EU",
        name: String = "euro",
        shortName: String = "EUR",
        longName: String = "euro"
    ) -> ApiCurrency {
        ApiCurrency(
            country: country,
            name: name,
            shortName: shortName,
            longName: longName
        )
    }
}

extension [ApiCurrency] {
    static var mock: [ApiCurrency] {
        [
            .mock(),
            .mock(
                country: "USA",
                name: "dollar",
                shortName: "USD",
                longName: "americký dolar"
            ),
            .mock(
                country: "Czechia",
                name: "koruna",
                shortName: "CZK",
                longName: "česká koruna"
            ),
        ]
    }
}
