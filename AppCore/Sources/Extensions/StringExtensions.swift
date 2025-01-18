//
//  StringExtensions.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

extension String {
    public var flag: String {
        let currencyCode = self
        let countryCode = String(currencyCode.prefix(2))

        return countryCode
            .unicodeScalars
            .map { 127397 + $0.value }
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
}
