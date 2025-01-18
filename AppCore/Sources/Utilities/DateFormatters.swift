//
//  DateFormatters.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import Foundation

public struct DateFormatters {
    public static let apiDateWithTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()

    public static let apiDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    public static let mediumDate: DateFormatter = {
        let formatter = DateFormatter()

        formatter.locale = Locale.current
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium

        return formatter
    }()
}
