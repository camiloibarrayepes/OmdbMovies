//
//  DetailViewModel.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import Foundation
import Combine

/*
    Debugging print statements are currently commented out.
    Feel free to uncomment them to inspect the process.
*/

class DetailViewModel: ObservableObject {
    @Published var movie: DetailMovie?
    @Published var isLoading: Bool = false
    @Published var error: APIClientError?
    
    private let movieAPI = MovieAPI()
    private var cancellables = Set<AnyCancellable>()
    
    private let cacheManager = CacheManager()
    
    func fetchMovieByID(id: String) {
        // Check first if exists in Cache
        if let cachedMovie = self.cacheManager.getCachedMovie(for: id) {
            self.movie = cachedMovie
             //print("Movide loaded from cache \(cachedMovie.title ?? "")")
        } else {
            // Make the request
            isLoading = true
            movieAPI.searchMovieByID(id: id)
                .sink(receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    self.isLoading = false
                    if case .failure(let error) = completion {
                        self.error = error
                        print("Error loading the movie: \(error.localizedDescription)") // Debug
                    }
                }, receiveValue: { [weak self] movieResponse in
                    guard let self else { return }
                    self.movie = movieResponse
                    //print("Movie loaded from API \(movieResponse.title ?? "")")
                    self.cacheManager.cacheMovie(movieResponse, for: id)
                })
                .store(in: &cancellables)
        }
    }
}

