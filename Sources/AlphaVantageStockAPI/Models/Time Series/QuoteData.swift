//
//  File.swift
//  
//
//  Created by Krisda Siangchaew on 29/6/23.
//

import Foundation

public struct QuoteData: Decodable {
    public var open: String?
    public var high: String?
    public var low: String?
    public var close: String?
    public var adjusted: String?
    public var volume: String?
    public var dividend: String?
    
    public enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case adjusted = "5. adjusted close"
        case volume = "6. volume"
        case dividend = "7. dividend amount"
    }
    
    public init(open: String? = nil, high: String? = nil, low: String? = nil, close: String? = nil, adjusted: String? = nil, volume: String? = nil, dividend: String? = nil) {
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.adjusted = adjusted
        self.volume = volume
        self.dividend = dividend
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.open = try container.decodeIfPresent(String.self, forKey: .open)
        self.high = try container.decodeIfPresent(String.self, forKey: .high)
        self.low = try container.decodeIfPresent(String.self, forKey: .low)
        self.close = try container.decodeIfPresent(String.self, forKey: .close)
        self.adjusted = try container.decodeIfPresent(String.self, forKey: .adjusted)
        self.volume = try container.decodeIfPresent(String.self, forKey: .volume)
        self.dividend = try container.decodeIfPresent(String.self, forKey: .dividend)
    }
}
