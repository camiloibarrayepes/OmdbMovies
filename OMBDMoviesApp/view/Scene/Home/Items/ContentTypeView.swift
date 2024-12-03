//
//  ContentTypeView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI

struct ContentTypeView: View {
    var type: TypeEnum?

    private let typeMappings: [TypeEnum: String] = [
        .movie: "🎥 Movie",
        .series: "📺 Series",
        .game: "🎮 Game"
    ]

    var body: some View {
        HStack {
            Text(typeMappings[type ?? .none] ?? "")
                .font(.footnote)
            Spacer()
        }
    }
}
