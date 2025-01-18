//
//  NumberFormatters.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import Foundation

public struct NumberFormatters {
    public static let basicFormat: NumberFormatter = {
        let formatter = NumberFormatter()

        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 4

        return formatter
    }()

    public static let basicPercentFormat: NumberFormatter = {
        let formatter = NumberFormatter()

        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 4
        formatter.numberStyle = .percent

        return formatter
    }()
}
