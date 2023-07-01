import Foundation

public struct AlphaVantageStockAPI {
    private let apiKey: String
    
    private let session = URLSession.shared
    
    private let decoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    private let baseURL = "https://www.alphavantage.co/query"

    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func fetchTimeSeries(symbol: String, range: SeriesRange) async throws -> (MetaData, [Quote]) {
        
        switch range {
        case .daily:
            let url = try url(endpoint: .timeSeriesDaily(symbol: symbol))
            let (response, statusCode): (TimeSeriesDaily, Int) = try await fetch(url: url)
            try validateResponse(decodeError: response.error, statusCode: statusCode)
            guard let metaData = response.metaData else {
                throw APIError.invalidResponseType
            }
            return (metaData, response.quotes)
        case .weekly:
            let url = try url(endpoint: .timeSeriesWeekly(symbol: symbol))
            let (response, statusCode): (TimeSeriesWeekly, Int) = try await fetch(url: url)
            try validateResponse(decodeError: response.error, statusCode: statusCode)
            guard let metaData = response.metaData else {
                throw APIError.invalidResponseType
            }
            return (metaData, response.quotes)
        case .monthly:
            let url = try url(endpoint: .timeSeriesMonthly(symbol: symbol))
            let (response, statusCode): (TimeSeriesMontly, Int) = try await fetch(url: url)
            try validateResponse(decodeError: response.error, statusCode: statusCode)
            guard let metaData = response.metaData else {
                throw APIError.invalidResponseType
            }
            return (metaData, response.quotes)
        }
    }
    
    public func tickerSearch(keywords: String) async throws -> [Ticker] {
        let url = try url(endpoint: .symbolSearch(keyword: keywords))
        let (response, statusCode): (TickerSearch, Int) = try await fetch(url: url)
        try validateResponse(decodeError: response.error, statusCode: statusCode)
        return response.bestMatches ?? []
    }
    
    public func fetchGlobalQuote(symbol: String) async throws -> GlobalQuote {
        let url = try url(endpoint: .globalQuote(symbol: symbol))
        let (response, statusCode): (GlobalQuote, Int) = try await fetch(url: url)
        try validateResponse(decodeError: response.error, statusCode: statusCode)
        return response
    }
    
    public func fetchOverview(symbol: String) async throws -> Overview {
        let url = try url(endpoint: .overview(symbol: symbol))
        let (response, statusCode): (Overview, Int) = try await fetch(url: url)
        try validateResponse(decodeError: response.error, statusCode: statusCode)
        return response
    }
    
    private func validateResponse(decodeError: DecodeError?, statusCode: Int) throws {
        if let error = decodeError {
            var errorString = ""
            switch error {
            case .error(let string):
                errorString = string
            case .information(let string):
                errorString = string
            }
            throw APIError.httpStatusCodeFailed(statusCode: statusCode, error: errorString)
        }
    }
    
    private func fetch<D: Decodable>(url: URL) async throws -> (D, Int) {
        let (data, response) = try await session.data(from: url)
        let statusCode = try validHTTPResponse(response)
        return (try decoder.decode(D.self, from: data), statusCode)
    }
    
    private func url(endpoint: Endpoint) throws -> URL {
        let function = endpoint.rawValue
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw APIError.invalidURL
        }
        urlComponents.queryItems = [
            .init(name: "apikey", value: apiKey),
            .init(name: "function", value: function)
        ]
        
        switch endpoint {
        case .globalQuote(let symbol):
            urlComponents.queryItems?.append(.init(name: "symbol", value: symbol))
        case .overview(let symbol):
            urlComponents.queryItems?.append(.init(name: "symbol", value: symbol))
            
        case .symbolSearch(let keywords):
            urlComponents.queryItems?.append(.init(name: "keywords", value: keywords))
            
        case .timeSeriesDaily(let symbol):
            urlComponents.queryItems?.append(.init(name: "symbol", value: symbol))
            
        case .timeSeriesWeekly(let symbol):
            urlComponents.queryItems?.append(.init(name: "symbol", value: symbol))
            
        case .timeSeriesMonthly(let symbol):
            urlComponents.queryItems?.append(.init(name: "symbol", value: symbol))
        }
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        return url
    }
    
    private func validHTTPResponse(_ response: URLResponse) throws -> Int {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponseType
        }
        
        guard 200...299 ~= httpResponse.statusCode ||
                400...499 ~= httpResponse.statusCode else {
            throw APIError.httpStatusCodeFailed(statusCode: httpResponse.statusCode, error: nil)
                }
        
        return httpResponse.statusCode
    }
}
