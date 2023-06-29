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
        let url = try! URL(string: "https://www.alphavantage.co/query?function=OVERVIEW&symbol=IBM&apikey=\(apiKey)")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        let ticker = try! JSONDecoder().decode(Overview.self, from: data)
        print(ticker.symbol)
        print(ticker.name)
        print(ticker.fiftyTwoWeekLow)
        print(ticker.errorMessage)
    }
}
