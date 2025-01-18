//
//  CurrencyCode.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import Foundation

public struct CurrencyCode: Equatable {
    public let value: String

    public init(value: String) {
        self.value = value
    }
}
