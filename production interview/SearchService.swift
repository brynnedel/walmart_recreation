//
//  SearchService.swift
//  production interview
//
//  Created by Brynne Delaney on 01/02/2024.
//

import Foundation

struct SearchService {
    private static let session = URLSession.shared
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
    
    public static func getProducts(searchTerm: String) async throws -> [Product] {
        let baseURL = "https://dummyjson.com/products/search"
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "q", value: "\(searchTerm)")
        ]
        
        guard let url = components?.url else { fatalError("Invalid URL")}
        print(url)

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let(data, _) = try await session.data(for: request)
            printData(data: data)
            let response = try decoder.decode(WalmartResponse.self, from: data)
            print(response)
            return response.products
        } catch {
            print("this is the error: \(error.localizedDescription)" )
            throw error
        }
    }
    
    private static func printData(data: Data) {
        let string = String(data: data, encoding: .utf8)!
        print(string)
    }
}
