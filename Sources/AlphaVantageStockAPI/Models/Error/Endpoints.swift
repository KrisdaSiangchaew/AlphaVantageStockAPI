//
//  File.swift
//  
//
//  Created by Krisda Siangchaew on 30/6/23.
//

import Foundation

public enum Endpoint {
    case globalQuote(symbol: String)
    case overview(symbol: String)
    case symbolSearch(keyword: String)
    case timeSeriesDaily(symbol: String)
    case timeSeriesWeekly(symbol: String)
    case timeSeriesMonthly(symbol: String)
    
    public var rawValue: String {
        switch self {
        case .globalQuote: return "GLOBAL_QUOTE"
        case .overview: return "OVERVIEW"
        case .symbolSearch: return "SYMBOL_SEARCH"
        case .timeSeriesDaily: return "TIME_SERIES_DAILY_ADJUSTED"
        case .timeSeriesWeekly: return "TIME_SERIES_WEEKLY"
        case .timeSeriesMonthly: return "TIME_SERIES_MONTHLY"
        }
    }
}
