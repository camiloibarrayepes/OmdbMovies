//
//  DataBase.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import Foundation

final class DataBase: ObservableObject {
    
    @Published var favorites: Set<String> = []
    
    init() {
        self.favorites = load()
    }
    
    private let FAVORITE_KEY = "fk"
    
    func save(item: String) {
        favorites.insert(item)
        UserDefaults.standard.set(Array(favorites), forKey: FAVORITE_KEY)
    }
    
    func remove(item: String) {
        favorites.remove(item)
        UserDefaults.standard.set(Array(favorites), forKey: FAVORITE_KEY)
    }
    
    func load() -> Set<String> {
        if let savedFavorites = UserDefaults.standard.array(forKey: FAVORITE_KEY) as? [String] {
            return Set(savedFavorites)
        }
        return Set<String>()
    }
}
