//
//  DetailedView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI

struct DetailedView: View {
    
    @State private var loadFailed = false
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: DetailViewModel
    @State private var isFavorite: Bool = false

    var moviePassObject: Movie
    var database: DataBase
    
    var body: some View {
        VStack {
            if let movie = viewModel.movie {
                ScrollView {
                    VStack {
                        ZStack(alignment: .top) {
                            MoviePosterView(posterURL: moviePassObject.poster)
                            HeaderDetailView(
                                isFavorite: $isFavorite,
                                movieID: moviePassObject.id ?? "",
                                database: database,
                                presentationMode: presentationMode
                            )
                        }
                        DescriptionView(
                            title: movie.title,
                            runtime: movie.runtime,
                            year: movie.year,
                            type: movie.type,
                            plot: movie.plot,
                            rating: movie.imdbRating
                        )
                    }
                }
                .edgesIgnoringSafeArea(.top)
                .navigationBarHidden(true)
                .background(Color.backgroundView)
            } else if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            viewModel.fetchMovieByID(id: moviePassObject.id ?? "")
            let favorites = database.load()
            isFavorite = favorites.contains(moviePassObject.id ?? "")
        }
    }
}
