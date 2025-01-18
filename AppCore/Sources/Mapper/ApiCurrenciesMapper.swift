//
//  ApiCurrenciesMapper.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

struct ApiCurrenciesMapper {
    func map(apiCurrencies: [ApiCurrency]) -> [Currency] {
        apiCurrencies.map(map(apiCurrency:))
    }

    func map(apiCurrency: ApiCurrency) -> Currency {
        Currency(
            country: apiCurrency.country,
            name: apiCurrency.name,
            currencyCode: CurrencyCode(value: apiCurrency.shortName),
            longName: apiCurrency.longName
        )
    }
}
