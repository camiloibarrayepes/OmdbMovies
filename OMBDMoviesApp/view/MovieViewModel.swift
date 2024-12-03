//
//  SearchViewModel.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 2/12/24.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    
    // MARK: - Published Variables
    @Published var movies = [Movie]()
    @Published var searchText = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @Published var hasGameOrSeries: Bool = false
    
    // MARK: - Private Variables
    private var page = 1
    private(set) var totalPages: Int?
    private var cancellables = Set<AnyCancellable>()
    private let api = MovieAPI()
    
    var currentQuery = ""
    
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .sink { [weak self] query in
                self?.currentQuery = query
                self?.searchMovies(query: query)
            }
            .store(in: &cancellables)
    }
    
    func hasReachedEnd(of movie: Movie) -> Bool {
        movies.last?.id == movie.id
    }
    
    @MainActor
    func fetchNextSetOfMovies() async {

        guard page != totalPages else { return }
        isLoading = true
        page += 1
        
        api.searchMovies(query: self.currentQuery, page: page)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case .failure(let error) = completion {
                    self.handleError(error)
                }
                isLoading = false
            }, receiveValue: { [weak self] movieResponse in
                guard let self = self else { return }
                if movieResponse.response == "False" {
                    self.errorMessage = movieResponse.error ?? "No results found."
                    self.movies = []
                } else {
                    self.movies += movieResponse.search ?? []
                    self.totalPages = movieResponse.totalPages
                    self.hasGameOrSeries = checkIfHasGameOrSeries(self.movies)
                }
            })
            .store(in: &cancellables)
    }
    
    private func searchMovies(query: String) {
        resetSearchState()
        
        guard !query.isEmpty, query.count >= 4 else {
            self.movies = []
            return
        }
        
        isLoading = true
        self.errorMessage = nil
        
        api.searchMovies(query: query, page: page)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case .failure(let error) = completion {
                    self.handleError(error)
                }
                isLoading = false
            }, receiveValue: { [weak self] movieResponse in
                guard let self = self else { return }
                if movieResponse.response == "False" {
                    self.errorMessage = movieResponse.error ?? "No results found."
                    self.movies = []
                } else {
                    self.movies = movieResponse.search ?? []
                    self.totalPages = movieResponse.totalPages
                    self.hasGameOrSeries = checkIfHasGameOrSeries(self.movies)
                }
            })
            .store(in: &cancellables)
    }
    
    private func handleError(_ error: Error) {
        self.errorMessage = error.localizedDescription
        isLoading = false
    }
    
    private func resetSearchState() {
        if !isLoading {
            movies.removeAll()
            page = 1
            totalPages = nil
        }
    }

}

extension MovieViewModel {
    
    /// Checks if the provided array of movies contains a movie of type `.game` or `.series`.
    /// The function sorts the movies based on their `type` and performs a binary search to find if any movie matches either of these types.
    ///
    /// - Parameter movies: An array of `Movie` objects to search through.
    /// - Returns: A boolean value indicating whether there is at least one movie of type `.game` or `.series`.
    private func checkIfHasGameOrSeries(_ movies: [Movie]) -> Bool {
        let sortedMovies = movies.sorted { $0.type?.rawValue ?? "" < $1.type?.rawValue ?? "" }
        
        var left = 0
        var right = sortedMovies.count - 1
        
        while left <= right {
            let mid = (left + right) / 2
            let movie = sortedMovies[mid]
            
            if movie.type == .game || movie.type == .series {
                return true
            }
            
            if movie.type?.rawValue ?? "" < TypeEnum.game.rawValue {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        
        return false
    }
    
}
