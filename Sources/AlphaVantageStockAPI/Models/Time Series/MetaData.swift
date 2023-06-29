//
//  MetaData.swift
//  AlphaVanguard
//
//  Created by Kris on 23/6/2566 BE.
//

import Foundation

public struct MetaData: Decodable {
    public var information: String?
    public var symbol: String?
    public var lastRefreshed: String?
    
    public enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
    }
    
    public init(information: String? = nil, symbol: String? = nil, lastRefreshed: String? = nil, outputSize: String? = nil, timeZone: String? = nil) {
        self.information = information
        self.symbol = symbol
        self.lastRefreshed = lastRefreshed
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.information = try container.decodeIfPresent(String.self, forKey: .information)
        self.symbol = try container.decodeIfPresent(String.self, forKey: .symbol)
        self.lastRefreshed = try container.decodeIfPresent(String.self, forKey: .lastRefreshed)
    }
}

extension MetaData: Identifiable {
    public var id: UUID { UUID() }
}
