//
//  MovieAPI.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 2/12/24.
//

import Foundation
import Combine

struct MovieAPI {
    private let apiClient = APIClient()

    func searchMovies(query: String, page: Int) -> AnyPublisher<MovieResponse, APIClientError> {
        return apiClient.search(query: query, page: page, responseType: MovieResponse.self)
    }

    func searchMovieByID(id: String) -> AnyPublisher<DetailMovie, APIClientError> {
        return apiClient.searchByID(id: id, responseType: DetailMovie.self)
    }
}
