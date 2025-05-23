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
    var genre: String
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    var body: some View {
        
        ZStack {
            Color.background.ignoresSafeArea()
            VStack{
                HStack{
                    Text(genre)
                        .foregroundStyle(.white)
                        .font(.title3.bold())
                }.background(
                    Rectangle().frame(height: 2).foregroundColor(.color1)
                        .offset(y:16)
                )
                
               
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
            }
            
            .onAppear {
                viewModel.reset()
                viewModel.getMovies(genreId: genreId)
            }
        }
    }
}

#Preview {
    MovieListView(genreId:28,genre:"Action")
}
