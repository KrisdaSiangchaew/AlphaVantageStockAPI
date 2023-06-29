//
//  File.swift
//  
//
//  Created by Kris on 29/6/2566 BE.
//

import Foundation

public struct GlobalQuote: Decodable {
    public var data: GlobalQuoteData?
    public var error: DecodeError?
    
    public enum CodingKeys: String, CodingKey {
        case globalQuote = "Global Quote"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent(GlobalQuoteData.self, forKey: .globalQuote)
        if self.data == nil {
            let errorContainer = try decoder.singleValueContainer()
            let error = try errorContainer.decode([String : String].self)
            self.error = .error(error.values.first!)
        }
    }
    
    public init(data: GlobalQuoteData? = nil, error: DecodeError? = nil) {
        self.data = data
        self.error = error
    }
}
