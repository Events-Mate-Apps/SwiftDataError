//
//  WeddingService.swift
//  WeddMate
//
//  Created by Robin Kment on 11/24/21.
//

import Foundation

extension JSONDecoder {
    static var weddMate: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}

actor WeddingService {
    enum Errors: Error {
        case notValidIdentityToken
    }
    
    init() { }
    
    var myWeddings: [Wedding] {
        get async throws {
            let baseURL = "https://api.weddmate.com/api/users/myWeddings"
            
            guard let url = URL(string: baseURL) else {
                throw APIError.urlError
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("Bearer +gco+88lI3PWeNvuQiOUZDU49yS9np1C+ffj/3IGtAZbrwL64y/0m73us2AxPo12xAvYKMWzJA3xFlnIK2ZyNw==", forHTTPHeaderField: "Authorization")
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                print(response)
                return try JSONDecoder.weddMate.decode([Wedding].self, from: data)
            } catch let decodingError as DecodingError {
                throw APIError.decodingError(decodingError)
            } catch {
                throw APIError.networkError(error)
            }
        }
    }
}

enum APIError: Error {
    case urlError
    case decodingError(Error)
    case networkError(Error)
}
