//
//  DescriptionVStackModifier.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI

struct DescriptionVStackModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical, 24)
            .frame(maxWidth: .infinity)
            .background(
                Color.backgroundView
                    .cornerRadius(30, corners: [.topLeft, .topRight])
            )
            .offset(y: -30)
    }
}

extension View {
    
    func customVStackStyle() -> some View {
        self.modifier(DescriptionVStackModifier())
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}


