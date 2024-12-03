//
//  MoviePosterView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI
import Kingfisher

struct MoviePosterView: View {
    var posterURL: String?
    
    var body: some View {
        KFImage(URL(string: posterURL ?? ""))
            .placeholder {
                Image("placeholdermovie")
                    .resizable()
                    .scaledToFit()
            }
            .resizable()
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
    }
}
