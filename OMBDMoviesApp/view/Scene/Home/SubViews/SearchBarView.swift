//
//  SearchBarView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField(Localizable.searchMoviePlaceHolder, text: $text)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
        }
        .frame(height: 40)
    }
}
