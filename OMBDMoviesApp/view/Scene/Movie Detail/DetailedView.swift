//
//  DetailedView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI

struct DetailedView: View {
    var idMovie: String
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: DetailViewModel
    @State private var isFavorite: Bool = false
    var database: DataBase
    
    private var heartButtonColor: Color {
        isFavorite ? Color.red : Color.white
    }
    
    var body: some View {
        VStack {
            if let movie = viewModel.movie {
                ScrollView {
                    VStack(spacing: 0) {
                        ZStack(alignment: .top) {
                            AsyncImageView(url: movie.poster ?? "")
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7)
                                .clipped()
                                .overlay(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                            HStack {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "chevron.left")
                                        .font(.title2)
                                        .padding()
                                        .background(Color.black.opacity(0.6))
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                        .padding(.leading)
                                        .padding(.top, 50)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    if isFavorite {
                                        database.remove(item: idMovie)
                                    } else {
                                        database.save(item: idMovie)
                                    }
                                    isFavorite.toggle()
                                }) {
                                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                                        .font(.title2)
                                        .padding()
                                        .background(Color.black.opacity(0.6))
                                        .foregroundColor(heartButtonColor)
                                        .clipShape(Circle())
                                        .padding(.trailing)
                                        .padding(.top, 50)
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(movie.title ?? "")
                                    .fontWeight(.bold)
                                    .lineLimit(2)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text(movie.runtime ?? "")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                            Text("Year: \(movie.year ?? "")")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            ContentTypeView(type: movie.type)
                            Spacer()
                            Text(movie.plot ?? "No description...")
                                .font(.body)
                                .foregroundColor(.primary)
                            Spacer()
                            Text("Rating: \(movie.imdbRating ?? "")")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .customVStackStyle()
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
            viewModel.fetchMovieByID(id: idMovie)
            let favorites = database.load()
            isFavorite = favorites.contains(idMovie)
        }
    }
}
