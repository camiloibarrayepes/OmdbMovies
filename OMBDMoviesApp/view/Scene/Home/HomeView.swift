//
//  HomeView.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 2/12/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: MovieViewModel
    @State private var selectedOption = "All"
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @State private var isGridView = false

    var body: some View {
        NavigationView {
            ScrollView {
                // Search Bar View
                SearchBarView(text: $viewModel.searchText)
                    .padding()
                    .onChange(of: viewModel.searchText) { _, _ in
                        selectedOption = "All"
                    }
                
                // Show Loading
                if viewModel.isLoading {
                    LoadingView()
                }
                
                // Error message View
                errorMessageView
                
                // Show picker only if Items has different types
                if !viewModel.movies.isEmpty && viewModel.hasGameOrSeries {
                    PickerHeader(selectedOption: $selectedOption)
                }

                if viewModel.searchText.isEmpty {
                    emptyView
                } else {
                    // Select Grid of List View
                    if isGridView {
                        MovieGridView(
                            movies: viewModel.movies,
                            selectedOption: $selectedOption,
                            viewModel: viewModel
                        )
                    } else {
                        MovieListView(
                            movies: viewModel.movies,
                            selectedOption: $selectedOption,
                            viewModel: viewModel
                        )
                    }
                }
            }
            .navigationTitle(Localizable.movieTitle)
            .navigationBarItems(trailing: HStack {
                Button(action: toggleDarkMode) {
                    Image(systemName: colorScheme == .dark ? "sun.max.fill" : "moon.fill")
                        .imageScale(.large)
                        .foregroundColor(colorScheme == .dark ? .yellow : .black)
                }
                Button(action: toggleGridView) {
                    Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2.fill")
                        .imageScale(.large)
                        .foregroundColor(colorScheme == .dark ? .yellow : .black)
                }
            })
        }
    }
    
    private func toggleGridView() {
        isGridView.toggle()
    }
    
    private func toggleDarkMode() {
        setAppColorScheme(to: colorScheme == .dark ? .light : .dark)
    }
    
    private func setAppColorScheme(to mode: ColorScheme) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        window.overrideUserInterfaceStyle = mode == .dark ? .dark : .light
    }

}

extension HomeView {
    var errorMessageView: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                    .padding()
                    .transition(.move(edge: .bottom))
            }
        }
        .animation(.easeIn, value: viewModel.errorMessage)
    }
    
    var emptyView: some View {
        VStack {
            Text(Localizable.searchMovieByName)
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
        }
    }
}


