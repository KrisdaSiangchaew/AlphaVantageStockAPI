//
//  File.swift
//  
//
//  Created by Krisda Siangchaew on 29/6/23.
//
// https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=IBM&apikey=demo
//

import Foundation

public struct GlobalQuoteData: Decodable {
    public var symbol: String?
    public var open: String?
    public var high: String?
    public var low: String?
    public var price: String?
    public var volume: String?
    public var latestTradingDay: String?
    public var previousClose: String?
    public var change: String?
    public var changePercent: String?
    
    public init(symbol: String? = nil, open: String? = nil, high: String? = nil, low: String? = nil, price: String? = nil, volume: String? = nil, latestTradingDay: String? = nil, previousClose: String? = nil, change: String? = nil, changePercent: String? = nil) {
        self.symbol = symbol
        self.open = open
        self.high = high
        self.low = low
        self.price = price
        self.volume = volume
        self.latestTradingDay = latestTradingDay
        self.previousClose = previousClose
        self.change = change
        self.changePercent = changePercent
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.symbol = try container.decodeIfPresent(String.self, forKey: .symbol)
        self.open = try container.decodeIfPresent(String.self, forKey: .open)
        self.high = try container.decodeIfPresent(String.self, forKey: .high)
        self.low = try container.decodeIfPresent(String.self, forKey: .low)
        self.volume = try container.decodeIfPresent(String.self, forKey: .volume)
        self.price = try container.decodeIfPresent(String.self, forKey: .price)
        self.latestTradingDay = try container.decodeIfPresent(String.self, forKey: .latestTradingDay)
        self.previousClose = try container.decodeIfPresent(String.self, forKey: .previousClose)
        self.change = try container.decodeIfPresent(String.self, forKey: .change)
        self.changePercent = try container.decodeIfPresent(String.self, forKey: .changePercent)
    }
}

extension GlobalQuoteData {
    public enum CodingKeys: String, CodingKey {
        case symbol = "01. symbol"
        case open = "02. open"
        case high = "03. high"
        case low = "04. low"
        case price = "05. price"
        case volume = "06. volume"
        case latestTradingDay = "07. latest trading day"
        case previousClose = "08. previous close"
        case change = "09. change"
        case changePercent = "10. change percent"
    }
}

extension GlobalQuote: Identifiable {
    public var id: UUID { UUID() }
}
