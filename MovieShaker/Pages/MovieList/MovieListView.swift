//
//  MovieListView.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 21.04.2025.
//

import SwiftUI

struct MovieListView: View {
    @EnvironmentObject var navModel: NavigationModel
    @StateObject var viewModel = MovieListViewModel()
    var genreId: Int
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    var body: some View {
        
        ZStack {
            Color.background.ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.movies.indices, id: \.self) { index in
                        let movie = viewModel.movies[index]
                        MovieItem(movie: movie)
                            .onTapGesture {
                                navModel.navigateTo(.MovieDetail(movie.id), in: .category)
                            }
                            .onAppear {
                                if index == viewModel.movies.count - 1 {
                                    viewModel.getMovies(genreId: genreId) // Son elemana gelince yeni veri çek
                                }
                            }
                    }
                }
                .padding()
            }
            .onAppear {
                viewModel.reset()
                viewModel.getMovies(genreId: genreId)
            }
        }
    }
}

#Preview {
    MovieListView(genreId:28)
}
