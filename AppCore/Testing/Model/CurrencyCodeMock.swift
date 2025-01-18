//
//  CurrencyCodeMock.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

extension CurrencyCode {
    public static func mock(
        value: String = "CZK"
    ) -> CurrencyCode {
        CurrencyCode(value: value)
    }
}
