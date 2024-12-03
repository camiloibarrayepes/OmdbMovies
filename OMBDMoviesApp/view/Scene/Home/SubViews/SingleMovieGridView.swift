//
//  SingleMovieGridView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI
import Kingfisher

struct SingleMovieGridView: View {
    
    var singleMovie: Movie
    @State private var isFavorite: Bool = false
    @EnvironmentObject var database: DataBase

    var body: some View {
        VStack {
            CustomImageView(
                imageURL: singleMovie.poster ?? "",
                width: 150,
                height: 225
            )
            VStack(alignment: .leading, spacing: 5) {
                Text(singleMovie.title ?? "")
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(singleMovie.year ?? "")
                    .fontWeight(.light)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 4)

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
            .padding(.top, 5)
        }
        .padding(16)
        .foregroundColor(Color.primary)
        .background(Color.lightGrayBackground)
        .cornerRadius(8)
        .onAppear {
            let favorites = database.load()
            isFavorite = favorites.contains(singleMovie.id ?? "")
        }
    }
}
