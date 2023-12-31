//
//  File.swift
//  
//
//  Created by Krisda Siangchaew on 29/6/23.
//

import Foundation
import AlphaVantageStockAPI

@main
struct APIExec {
    static func main() async {
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? "demo"
        let api = AlphaVantageStockAPI(apiKey: apiKey)
//        try! await getTimeSeries(apiKey: apiKey, duration: .daily)
//        try! await getOverview(apiKey: apiKey)
        do {
//            let overview = try await AlphaVantageStockAPI(apiKey: apiKey).fetchOverview(symbol: "IBM")
//            print(overview.symbol)
//            let tickers = try await AlphaVantageStockAPI(apiKey: apiKey).tickerSearch(keywords: "osaka")
//            for ticker in tickers {
//                print(ticker.symbol)
//            let (metaData, quotes) = try await AlphaVantageStockAPI(apiKey: apiKey).fetchTimeSeries(symbol: "bkk", range: .monthly)
//
//            print(metaData.symbol)
//            for quote in quotes {
//                print("\(quote.date): \(quote.quoteData?.open)")
//            }
            let searchSymbols = try await api.tickerSearch(keywords: "bkk")
            print("Search===")
            for symbol in searchSymbols {
                print("\(symbol.symbol): \(symbol.name)")
            }
            let firstSymbol = searchSymbols.last?.symbol ?? ""
            let global = try await api.fetchGlobalQuote(symbol: firstSymbol)
            print("Global===")
            print(global.data?.symbol)
            print(global.data?.latestTradingDay)
            print(global.data?.open)
            let overview = try await api.fetchOverview(symbol: firstSymbol)
            print("Overview===")
            print(overview.symbol)
            print(overview.name)
            print(overview.country)
            print(overview.error?.rawValue)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    static func getTimeSeries(apiKey: String, duration: SeriesRange) async throws {
        let url = URL(string: "https://www.alphavantage.co/query?function=\(duration.rawValue)&symbol=IBM&apikey=\(apiKey)")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            switch duration {
            case .daily:
                let result = try JSONDecoder().decode(TimeSeriesDaily.self, from: data)
                printValue(result: result)
            case .weekly:
                let result = try JSONDecoder().decode(TimeSeriesWeekly.self, from: data)
                printValue(result: result)
            case .monthly:
                let result = try JSONDecoder().decode(TimeSeriesMontly.self, from: data)
                printValue(result: result)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func printValue<T: TimeSeries>(result: T) {
        print(result.metaData?.symbol)
        print(result.quotes.first?.date)
        print(result.quotes.first?.quoteData?.open)
        print(result.error?.rawValue)
    }
    
    static func getOverview(apiKey: String) async throws {
        let url = URL(string: "https://www.alphavantage.co/query?function=OVERVIEW&symbol=IBM&apikey=\(apiKey)")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(Overview.self, from: data)
            print(result.symbol)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func getGlobalQuote(apiKey: String) async throws {
        let url = URL(string: "https://www.alphavantage.co/query?function=GLOBAL_QUOTExxx&symbol=IBM&apikey=\(apiKey)")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let globalQuote = try JSONDecoder().decode(GlobalQuote.self, from: data)
            print(globalQuote.data?.symbol)
            print(globalQuote.error?.rawValue)
        } catch {
            print(error.localizedDescription)
        }
    }
}
