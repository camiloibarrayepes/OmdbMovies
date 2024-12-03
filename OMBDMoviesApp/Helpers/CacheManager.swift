//
//  CacheMovies.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import Foundation

class CacheManager {
    private let cacheKeyPrefix = "movieCache_"
    
    // Store the movie object in cache
    func cacheMovie(_ movie: DetailMovie, for id: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(movie) {
            UserDefaults.standard.set(encoded, forKey: cacheKeyPrefix + id)
        }
    }
    
    // Get the movie object from cache
    func getCachedMovie(for id: String) -> DetailMovie? {
        if let data = UserDefaults.standard.data(forKey: cacheKeyPrefix + id) {
            let decoder = JSONDecoder()
            if let decodedMovie = try? decoder.decode(DetailMovie.self, from: data) {
                return decodedMovie
            }
        }
        return nil
    }
}
