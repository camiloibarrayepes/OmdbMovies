//
//  ImageButtonModifier.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI

struct ImageButtonModifier: ViewModifier {
    var isFavorite: Bool
    var heartButtonColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .padding()
            .background(Color.black.opacity(0.6))
            .foregroundColor(isFavorite ? heartButtonColor : .white)
            .clipShape(Circle())
            .padding(.top, 50)
            .padding(.horizontal, 10)
    }
}
