//
//  Ticker.swift
//  
//
//  Created by Krisda Siangchaew on 29/6/23.
//
//  https://www.alphavantage.co/query?function=OVERVIEW&symbol=IBM&apikey=apiKey
//

import Foundation

public struct Overview {
    public var symbol: String?
    public var assetType: String?
    public var name: String?
    public var description: String?
    public var exchange: String?
    public var currency: String?
    public var country: String?
    public var sector: String?
    public var industry: String?
    public var latestQuarter: String?
    public var marketCapitalization: String?
    public var ebitda: String?
    public var peRatio: String?
    public var pegRatio: String?
    public var dividendPerShare: String?
    public var eps: String?
    public var beta: String?
    public var fiftyTwoWeekHigh: String?
    public var fiftyTwoWeekLow: String?
    public var fiftyDayMovingAverage: String?
    public var twoHundredDayMovingAverage: String?
    public var dividendDate: String?
    public var exDividendDate: String?
    public var error: DecodeError?
    
    public init(symbol: String? = nil, assetType: String? = nil, name: String? = nil, description: String? = nil, exchange: String? = nil, currency: String? = nil, country: String? = nil, sector: String? = nil, industry: String? = nil, latestQuarter: String? = nil, marketCapitalization: String? = nil, ebitda: String? = nil, peRatio: String? = nil, pegRatio: String? = nil, dividendPerShare: String? = nil, eps: String? = nil, beta: String? = nil, fiftyTwoWeekHigh: String? = nil, fiftyTwoWeekLow: String? = nil, fiftyDayMovingAverage: String? = nil, twoHundredDayMovingAverage: String? = nil, dividendDate: String? = nil, exDividendDate: String? = nil, error: DecodeError? = nil) {
        self.symbol = symbol
        self.assetType = assetType
        self.name = name
        self.description = description
        self.exchange = exchange
        self.currency = currency
        self.country = country
        self.sector = sector
        self.industry = industry
        self.latestQuarter = latestQuarter
        self.marketCapitalization = marketCapitalization
        self.ebitda = ebitda
        self.peRatio = peRatio
        self.pegRatio = pegRatio
        self.dividendPerShare = dividendPerShare
        self.eps = eps
        self.beta = beta
        self.fiftyTwoWeekHigh = fiftyTwoWeekHigh
        self.fiftyTwoWeekLow = fiftyTwoWeekLow
        self.fiftyDayMovingAverage = fiftyDayMovingAverage
        self.twoHundredDayMovingAverage = twoHundredDayMovingAverage
        self.dividendDate = dividendDate
        self.exDividendDate = exDividendDate
        self.error = error
    }
}

extension Overview {
    public enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case assetType = "AssetType"
        case name = "Name"
        case description = "Description"
        case exchange = "Exchange"
        case currency = "Currency"
        case country = "Country"
        case sector = "Sector"
        case industry = "Industry"
        case latestQuarter = "LatestQuarter"
        case marketCapitalization = "MarketCapitalization"
        case ebitda = "EBITDA"
        case peRatio = "PERatio"
        case pegRatio = "PEGRatio"
        case dividendPerShare = "DividendPerShare"
        case eps = "EPS"
        case beta = "Beta"
        case fiftyTwoWeekHigh = "52WeekHigh"
        case fiftyTwoWeekLow = "52WeekLow"
        case fiftyDayMovingAverage = "50DayMovingAverage"
        case twoHundredDayMovingAverage = "200DayMovingAverage"
        case dividendDate = "DividendDate"
        case exDividendDate = "ExDividendDate"
        case errorMessage = "Error Message"
        case information = "Information"
    }
}

extension Overview: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.symbol = try container.decodeIfPresent(String.self, forKey: .symbol)
        self.assetType = try container.decodeIfPresent(String.self, forKey: .assetType)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.exchange = try container.decodeIfPresent(String.self, forKey: .exchange)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.sector = try container.decodeIfPresent(String.self, forKey: .sector)
        self.industry = try container.decodeIfPresent(String.self, forKey: .industry)
        self.latestQuarter = try container.decodeIfPresent(String.self, forKey: .latestQuarter)
        self.marketCapitalization = try container.decodeIfPresent(String.self, forKey: .marketCapitalization)
        self.ebitda = try container.decodeIfPresent(String.self, forKey: .ebitda)
        self.peRatio = try container.decodeIfPresent(String.self, forKey: .peRatio)
        self.pegRatio = try container.decodeIfPresent(String.self, forKey: .pegRatio)
        self.dividendPerShare = try container.decodeIfPresent(String.self, forKey: .dividendPerShare)
        self.eps = try container.decodeIfPresent(String.self, forKey: .eps)
        self.beta = try container.decodeIfPresent(String.self, forKey: .beta)
        self.fiftyTwoWeekHigh = try container.decodeIfPresent(String.self, forKey: .fiftyTwoWeekHigh)
        self.fiftyTwoWeekLow = try container.decodeIfPresent(String.self, forKey: .fiftyTwoWeekLow)
        self.fiftyDayMovingAverage = try container.decodeIfPresent(String.self, forKey: .fiftyDayMovingAverage)
        self.twoHundredDayMovingAverage = try container.decodeIfPresent(String.self, forKey: .twoHundredDayMovingAverage)
        self.dividendDate = try container.decodeIfPresent(String.self, forKey: .dividendDate)
        self.exDividendDate = try container.decodeIfPresent(String.self, forKey: .exDividendDate)
        let errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
        let information = try container.decodeIfPresent(String.self, forKey: .information)
        
        if let errorMessage = errorMessage {
            self.error = .error(errorMessage)
        }
        
        if let information = information {
            self.error = .information(information)
        }
    }
}

extension Overview: Identifiable {
    public var id: UUID { UUID() }
}
