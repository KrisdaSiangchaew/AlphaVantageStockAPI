//
//  File.swift
//  
//
//  Created by Krisda Siangchaew on 29/6/23.
//

import Foundation

public struct Symbol: Decodable {
    public var symbol: String?
    public var name: String?
    public var type: String?
    public var region: String?
    public var marketOpen: String?
    public var marketClose: String?
    public var timeZone: String?
    public var currency: String?
    public var matchScore: String?
    public var information: String?
    public var errorMessage: String?
    
    public init(symbol: String? = nil, name: String? = nil, type: String? = nil, region: String? = nil, marketOpen: String? = nil, marketClose: String? = nil, timeZone: String? = nil, currency: String? = nil, matchScore: String? = nil, errorMessage: String? = nil, information: String?) {
        self.symbol = symbol
        self.name = name
        self.type = type
        self.region = region
        self.marketOpen = marketOpen
        self.marketClose = marketClose
        self.timeZone = timeZone
        self.currency = currency
        self.matchScore = matchScore
        self.errorMessage = errorMessage
        self.information = information
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.symbol = try container.decodeIfPresent(String.self, forKey: .symbol)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.region = try container.decodeIfPresent(String.self, forKey: .region)
        self.marketOpen = try container.decodeIfPresent(String.self, forKey: .marketOpen)
        self.marketClose = try container.decodeIfPresent(String.self, forKey: .marketClose)
        self.timeZone = try container.decodeIfPresent(String.self, forKey: .timeZone)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.matchScore = try container.decodeIfPresent(String.self, forKey: .matchScore)
        self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
        self.information = try container.decodeIfPresent(String.self, forKey: .information)
    }
}

extension Symbol {
    public enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case region = "4. region"
        case marketOpen = "5. marketOpen"
        case marketClose = "6. marketClose"
        case timeZone = "7. timezone"
        case currency = "8. currency"
        case matchScore = "9. matchScore"
        case information = "Information"
        case errorMessage = "Error Message"
    }
}
