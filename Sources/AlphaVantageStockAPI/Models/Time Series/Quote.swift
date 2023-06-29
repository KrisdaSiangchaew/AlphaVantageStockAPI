//
//  Quote.swift
//  AlphaVantageStockAPI
//
//  Created by Kris on 29/6/2566 BE.
//

import Foundation

public struct Quote {
    public var date: String?
    public var quoteData: QuoteData?
    
    init(date: String? = nil, quote: QuoteData? = nil) {
        self.date = date
        self.quoteData = quote
    }
}
