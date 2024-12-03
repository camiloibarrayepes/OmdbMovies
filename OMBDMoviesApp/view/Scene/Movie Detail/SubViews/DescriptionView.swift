//
//  DescriptionView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import SwiftUI

struct DescriptionView: View {
    var title: String?
    var runtime: String?
    var year: String?
    var type: TypeEnum?
    var plot: String?
    var rating: String?
       
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title ?? "")
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                Spacer()
                Text(runtime ?? "")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            Text("\(Localizable.year): \(year ?? "")")
                .font(.headline)
                .foregroundColor(.secondary)
            ContentTypeView(type: type)
            Spacer()
            Text(plot ?? Localizable.noDescription)
                .font(.body)
                .foregroundColor(.primary)
            Spacer()
            Text("\(Localizable.rating): \(rating ?? "")")
                .font(.headline)
                .foregroundColor(.primary)
        }
        .customVStackStyle()
    }
}

