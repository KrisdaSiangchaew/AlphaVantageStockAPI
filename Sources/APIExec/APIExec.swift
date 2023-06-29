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
    enum TimeScale: String {
        case daily = "TIME_SERIES_DAILY_ADJUSTED"
        case weekly = "TIME_SERIES_WEEKLY_ADJUSTED"
        case monthly = "TIME_SERIES_MONTHLY_ADJUSTED"
    }
    
    static func main() async {
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? "demo"
        try! await getTimeSeries(apiKey: apiKey, duration: .daily)
        try! await getOverview(apiKey: apiKey)
    }
    
    static func getTimeSeries(apiKey: String, duration: TimeScale) async throws {
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
