//
//  NumberFormatterExtensions.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import Foundation

extension NumberFormatter {
    public func string(from: Double) -> String? {
        string(from: NSNumber(value: from))
    }
}
