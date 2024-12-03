//
//  MovieGridView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI

struct MovieGridView: View {
    var movies: [Movie]
    @Binding var selectedOption: String
    @ObservedObject var viewModel: MovieViewModel
    @StateObject var detailViewModel = DetailViewModel()
    @StateObject var database = DataBase()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
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
                        viewModel: detailViewModel,
                        moviePassObject: movie,
                        database: database
                    )
                } label: {
                    VStack {
                        SingleMovieGridView(
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
