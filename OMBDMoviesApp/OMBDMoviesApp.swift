//
//  OMBDMoviesAppApp.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 2/12/24.
//

import SwiftUI

@main
struct OMBDMoviesApp: App {
    @StateObject private var viewModel = MovieViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: viewModel)
        }
    }
}
