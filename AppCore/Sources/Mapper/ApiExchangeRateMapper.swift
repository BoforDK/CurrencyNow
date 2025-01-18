//
//  ApiExchangeRateMapper.swift
//  CurrencyNow
//
//  Created by Alexander Grigorov on 18.01.2025.
//

struct ApiExchangeRateMapper {
    func map(apiExchangeRates: [ApiExchangeRate]) -> [ExchangeRate] {
        apiExchangeRates.map(map(apiExchangeRate:))
    }

    func map(apiExchangeRate: ApiExchangeRate) -> ExchangeRate {
        let validFrom = DateFormatters
            .dateWithTime
            .date(from: apiExchangeRate.validFrom)

        return ExchangeRate(
            country: apiExchangeRate.country,
            name: apiExchangeRate.name,
            currencyCode: CurrencyCode(value: apiExchangeRate.shortName),
            amount: apiExchangeRate.amount,
            validFrom: validFrom,
            valBuy: apiExchangeRate.valBuy,
            valSell: apiExchangeRate.valSell,
            valMid: apiExchangeRate.valMid,
            currBuy: apiExchangeRate.currBuy,
            currSell: apiExchangeRate.currSell,
            currMid: apiExchangeRate.currMid,
            move: apiExchangeRate.move,
            cnbMid: apiExchangeRate.cnbMid,
            version: apiExchangeRate.version
        )
    }
}
