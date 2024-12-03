//
//  HeaderDetailView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI

struct HeaderDetailView: View {
    
    @Binding var isFavorite: Bool
    var movieID: String
    var database: DataBase
    var presentationMode: Binding<PresentationMode>
    
    private var heartButtonColor: Color {
        isFavorite ? Color.red : Color.white
    }
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .modifier(
                        ImageButtonModifier(
                            isFavorite: false,
                            heartButtonColor: heartButtonColor
                        )
                    )
            }
            Spacer()
            Button(action: {
                if isFavorite {
                    database.remove(item: movieID)
                } else {
                    database.save(item: movieID)
                }
                isFavorite.toggle()
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .modifier(
                        ImageButtonModifier(
                            isFavorite: isFavorite,
                            heartButtonColor: heartButtonColor
                        )
                    )
            }
        }
    }
}

