//
//  ExchangeRateMock.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import Foundation

extension ExchangeRate {
    public static func mock(
        country: String = "Švýcarsko",
        name: String = "frank",
        currencyCode: String = "CHF",
        amount: Double = 1,
        // TODO: Add mock
        validFrom: Date? = nil,
        valBuy: Double = 21,
        valSell: Double = 21.5,
        valMid: Double = 21.25,
        currBuy: Double = 20,
        currSell: Double = 20.5,
        currMid: Double = 20.22,
        move: Double = -0.5,
        cnbMid: Double = 21.25,
        version: Double = 1
    ) -> ExchangeRate {
        ExchangeRate(
            country: country,
            name: name,
            currencyCode: CurrencyCode(value: currencyCode),
            amount: amount,
            validFrom: validFrom,
            valBuy: valBuy,
            valSell: valSell,
            valMid: valMid,
            currBuy: currBuy,
            currSell: currSell,
            currMid: currMid,
            move: move,
            cnbMid: cnbMid,
            version: version
        )
    }
}

extension [ExchangeRate] {
    public static var mock: [ExchangeRate] {
        [
            .mock()
        ]
    }
}
