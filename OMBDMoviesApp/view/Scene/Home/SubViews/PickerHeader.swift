//
//  PickerHeader.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI

struct PickerHeader: View {
    @Binding var selectedOption: String

    var body: some View {
        VStack {
            Picker("Filter by", selection: $selectedOption) {
                Text("All").tag("All")
                Text(TypeEnum.movie.rawValue).tag(TypeEnum.movie.rawValue)
                Text(TypeEnum.series.rawValue).tag(TypeEnum.series.rawValue)
                Text(TypeEnum.game.rawValue).tag(TypeEnum.game.rawValue)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.pickerBackground)
            )
            .zIndex(1)
            .frame(maxWidth: .infinity)
        }
        .transition(.move(edge: .top))
    }
}
