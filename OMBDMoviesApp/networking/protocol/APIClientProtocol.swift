//
//  APIClientProtocol.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import Combine
import Foundation

protocol APIClientProtocol {
    func search<T: Decodable>(query: String, page: Int, responseType: T.Type) -> AnyPublisher<T, APIClientError>
    func searchByID<T: Decodable>(id: String, responseType: T.Type) -> AnyPublisher<T, APIClientError>
}
