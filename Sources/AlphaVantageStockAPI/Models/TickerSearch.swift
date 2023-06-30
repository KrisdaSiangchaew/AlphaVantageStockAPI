//
//  File.swift
//  
//
//  Created by Krisda Siangchaew on 29/6/23.
//

import Foundation

public struct TickerSearch: Decodable {
    public var bestMatches: [Ticker]?
    public var error: DecodeError?
    
    enum CodingKeys: String, CodingKey {
        case bestMatches = "bestMatches"
        case errorMessage = "Error Message"
        case information = "Information"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.bestMatches = try container.decodeIfPresent([Ticker].self, forKey: .bestMatches)
        } catch {
            let container = try decoder.singleValueContainer()
            let response = try container.decode([String : String].self)
            for key in response.keys {
                if key == CodingKeys.errorMessage.rawValue {
                    self.error = .error(response[key] ?? "")
                }
                if key == CodingKeys.information.rawValue {
                    self.error = .information(response[key] ?? "")
                }
            }
        }
    }
    
    public init() {
        self.bestMatches = []
        self.error = nil
    }
}
