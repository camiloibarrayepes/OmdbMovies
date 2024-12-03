//
//  AsyncImageView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 2/12/24.
//

import SwiftUI

struct AsyncImageView: View {
    @State private var image: UIImage? = nil
    let url: String?
    private static let imageCache = NSCache<NSString, UIImage>()
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else {
            Image("placeholdermovie")
                .resizable()
                .scaledToFit()
                .onAppear {
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        if let cachedImage = Self.imageCache.object(forKey: url as NSString? ?? "") {
            self.image = cachedImage
            return
        }
        // use the placeholder if the URLImage is not valid or is not possible to load the image
        guard let urlString = url, let url = URL(string: urlString) else {
            self.image = UIImage(named: "placeholdermovie")
            return
        }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let uiImage = UIImage(data: data) {
                    // Save image in cache
                    Self.imageCache.setObject(uiImage, forKey: urlString as NSString)
                    image = uiImage
                }
            } catch {
                print("Error loading image: \(error)")
                self.image = UIImage(named: "placeholdermovie")
            }
        }
    }
}
