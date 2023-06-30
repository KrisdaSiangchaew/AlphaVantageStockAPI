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
    
    public func fetchOverview(symbol: String) async throws -> Overview {
        let function = "function=OVERView"
        let symbol = "symbol=\(symbol)"
        let apiKey = "apikey=\(self.apiKey)"
        guard let url = URL(string: "\(baseURL)?\(function)&\(symbol)&\(apiKey)") else {
            throw APIError.invalidURL
        }
        let (response, statusCode): (Overview, Int) = try await fetch(url: url)
        if let error = response.error {
            throw APIError.httpStatusCodeFailed(statusCode: statusCode, error: error.rawValue)
        }
        return response
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
    
    private func fetch<D: Decodable>(url: URL) async throws -> (D, Int) {
        let (data, response) = try await session.data(from: url)
        let statusCode = try validHTTPResponse(response)
        return (try decoder.decode(D.self, from: data), statusCode)
    }
}
