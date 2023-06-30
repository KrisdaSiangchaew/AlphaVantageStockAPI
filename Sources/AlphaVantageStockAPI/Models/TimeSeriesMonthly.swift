//
//  File.swift
//  
//
//  Created by Kris on 30/6/2566 BE.
//

import Foundation

public struct TimeSeriesMontly: Decodable, TimeSeries {
    public var metaData: MetaData?
    public var quotes: [Quote] = []
    public var error: DecodeError?
    
    public enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDaily = "Monthly Time Series"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.metaData = try container.decode(MetaData.self, forKey: .metaData)
            let datedQuotes = try container.decode([String : QuoteData].self, forKey: .timeSeriesDaily)
            for quote in datedQuotes {
                let newQuote = Quote(date: quote.key, quote: quote.value)
                self.quotes.append(newQuote)
            }
        } catch {
            let errorContainer = try decoder.singleValueContainer()
            let errorContent = try errorContainer.decode([String : String].self)
            self.error = .error(errorContent.values.first!)
        }
    }
    
    public init(metaData: MetaData? = nil, quotes: [Quote] = [], error: DecodeError? = nil) {
        self.metaData = metaData
        self.quotes = quotes
        self.error = error
    }
}
