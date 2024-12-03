//
//  CustomImageView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI
import Kingfisher

struct CustomImageView: View {
    var imageURL: String
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        KFImage(URL(string: imageURL))
            .placeholder {
                Image("placeholdermovie")
                    .resizable()
                    .scaledToFit()
            }
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}
