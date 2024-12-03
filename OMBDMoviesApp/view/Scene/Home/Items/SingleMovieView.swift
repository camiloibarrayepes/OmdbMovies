//
//  SingleMovieView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 2/12/24.
//

import SwiftUI

struct SingleMovieView: View {
    
    var singleMovie: Movie
    @State private var isFavorite: Bool = false
    @EnvironmentObject var database: DataBase

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImageView(url: singleMovie.poster)
                .scaledToFill()
                .frame(width: 100, height: 150)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
            VStack(alignment: .leading){
                HStack{
                    Text(singleMovie.title ?? "")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                
                Text(singleMovie.year ?? "")
                    .fontWeight(.light)
                    .font(.footnote)
                Spacer()
                HStack {
                    ContentTypeView(type: singleMovie.type)
                    Spacer()
                    Button(action: {
                        if isFavorite {
                            database.remove(item: singleMovie.id ?? "")
                        } else {
                            database.save(item: singleMovie.id ?? "")
                        }
                        isFavorite.toggle()
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(isFavorite ? .red : .gray)
                    }
                }
            }
            .foregroundColor(Color.primary)
            
        }
        .padding()
        .background(Color.lightGrayBackground)
        .cornerRadius(5)
        .padding(.horizontal)
        .onAppear {
            let favorites = database.load()
            isFavorite = favorites.contains(singleMovie.id ?? "")
        }
    }
}
