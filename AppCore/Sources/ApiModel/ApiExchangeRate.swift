//
//  ApiExchangeRate.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

struct ApiExchangeRate: Codable {
    public let country: String
    public let name: String
    public let shortName: String
    public let amount: Double
    public let validFrom: String
    public let valBuy: Double
    public let valSell: Double
    public let valMid: Double
    public let currBuy: Double
    public let currSell: Double
    public let currMid: Double
    public let move: Double
    public let cnbMid: Double
    public let version: Double
}
