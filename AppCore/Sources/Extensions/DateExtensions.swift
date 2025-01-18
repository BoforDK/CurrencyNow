//
//  DateExtensions.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import Foundation

extension Date {
    public func subtractDays(count: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .minute, value: -count, to: self) ?? self
    }
}
