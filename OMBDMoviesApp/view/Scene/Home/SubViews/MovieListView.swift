//
//  MovieListView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI

struct MovieListView: View {
    var movies: [Movie]
    @Binding var selectedOption: String
    @ObservedObject var viewModel: MovieViewModel
    @StateObject var detailViewModel = DetailViewModel()
    @StateObject var database = DataBase()

    var body: some View {
        LazyVStack {
            ForEach(movies.filter { movie in
                switch selectedOption {
                case TypeEnum.movie.rawValue:
                    return movie.type == .movie
                case TypeEnum.series.rawValue:
                    return movie.type == .series
                case TypeEnum.game.rawValue:
                    return movie.type == .game
                default:
                    return true
                }
            }, id: \.self) { movie in
                NavigationLink {
                    DetailedView(
                        idMovie: movie.id ?? "",
                        viewModel: detailViewModel,
                        database: database
                    )
                } label: {
                    VStack {
                        SingleMovieView(
                            singleMovie: movie
                        )
                        .task {
                            if viewModel.hasReachedEnd(of: movie) {
                                await viewModel.fetchNextSetOfMovies()
                            }
                        }
                    }
                }
            }
        }
        .padding(.top, 10)
        .environmentObject(database)
    }
}
