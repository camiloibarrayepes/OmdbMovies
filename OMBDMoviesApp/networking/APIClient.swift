//
//  NetworkClient.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 2/12/24.
//

import Combine
import Foundation

enum APIClientError: Error {
    case badURL
    case decodingError
    case unknown
}

struct APIClient {
    private let apiKey = "6d431f35"
    private let baseURL = "http://www.omdbapi.com/"
    
    func search<T: Decodable>(query: String, page: Int, responseType: T.Type) -> AnyPublisher<T, APIClientError> {
        guard let url = URL(string: "\(baseURL)?apikey=\(apiKey)&s=\(query)&page=\(page)") else {
            return Fail(error: APIClientError.badURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in APIClientError.decodingError }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func searchByID<T: Decodable>(id: String, responseType: T.Type) -> AnyPublisher<T, APIClientError> {
        guard let url = URL(string: "\(baseURL)?apikey=\(apiKey)&i=\(id)&plot=full") else {
            return Fail(error: APIClientError.badURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in APIClientError.decodingError }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
