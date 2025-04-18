//
//  MovieDetailView.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 17.04.2025.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel = MovieDetailViewModel()
    @State private var selectedCategory = "Similar Movies"
    
    let categories = ["About Movie", "Credits", "Similar Movies"]
    let movieId: Int
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            if let movie = viewModel.movie {
               
                    VStack(alignment: .center, spacing: 16) {
                        
                        // BACKDROP
                        ZStack(alignment: .bottomLeading) {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath ?? "")")) { image in
                                image.resizable().scaledToFill()
                            } placeholder: {
                                Rectangle().fill(Color.gray.opacity(0.2))
                            }
                            .frame(height: 200)
                            .opacity(0.7)
                            
                            HStack {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                                    image.resizable().scaledToFill()
                                } placeholder: {
                                    Rectangle().fill(Color.gray.opacity(0.2))
                                }
                                .cornerRadius(8)
                                .frame(width: 95, height: 120)
                                
                                Text(movie.title)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .multilineTextAlignment(.leading)
                                    .offset(y: 20)
                            }
                            .offset(x: 25, y: 80)
                        }
                        
                        // INFO CAPSULES
                        InfoCapsulesView(movie: movie)
                            .offset(y: 120)
                        
                        // CATEGORY PICKER
                        CategoryPickerView(categories: categories, selectedCategory: $selectedCategory)
                            .padding(.top, 140)
                        
                        // CATEGORY CONTENT
                        ScrollView {
                            Group{
                                if selectedCategory == "About Movie" {
                                    Text(movie.overview ?? "There is no overview available")
                                        .font(.subheadline)
                                        .foregroundStyle(.white)
                                        .padding()
                                } else if selectedCategory == "Credits" {
                                    CreditsGrid(cast: $viewModel.cast)
                                } else if selectedCategory == "Similar Movies" {
                                    SimilarMoviesGrid(movies: viewModel.similar)
                                }
                            }
                        }
                           
                        
                    }
                
            } else {
                ProgressView("Yükleniyor...")
            }
        }
        .onAppear {
            viewModel.getMovieDetail(id: movieId)
            viewModel.getCredit(id: movieId)
            viewModel.getSimilarMovies(id: movieId)
        }
    }
}

struct InfoCapsulesView: View {
    let movie: Movie
    
    var body: some View {
        HStack(alignment:.center) {
            CapsuleItem(icon: "calendar", text: movie.releaseDate?.split(separator: "-").first.map(String.init) ?? "Süre yok")
            CapsuleItem(icon: "clock", text: movie.runTime.map { "\($0) min" } ?? "Süre yok")
            CapsuleItem(icon: "ticket", text: movie.genres?.first?.name ?? "Tür yok")
        }
        .padding(.horizontal)
    }
}

struct CapsuleItem: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: icon)
            Text(text)
        }
        .foregroundStyle(.white)
        .padding(.vertical, 4)
        .padding(.horizontal,8)
        .background(Color.color1.opacity(0.5))
        .clipShape(Capsule())
        .font(.headline.bold())
    }
}

struct CategoryPickerView: View {
    let categories: [String]
    @Binding var selectedCategory: String
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(categories, id: \.self) { category in
                Text(category)
                
                    .fontWeight(selectedCategory == category ? .bold : .regular)
                    .foregroundColor(selectedCategory == category ? .color1 : .gray)
                    .padding(.vertical, 8)
                    .onTapGesture {
                        selectedCategory = category
                    }
            }
        }
        .padding(.horizontal)
    }
}

struct CreditsGrid: View {
    @Binding var cast: [CastMember]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
            ForEach(cast.prefix(9), id: \.self) { cast in
                VStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(cast.profilePath ?? "")")) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(height: 144)
                    .clipped()
                    .cornerRadius(12)
                    
                    Text(cast.name)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                    
                    Text("(\(cast.character))")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
            }
        }
        .padding()
    }
}

struct SimilarMoviesGrid: View {
    let movies: [Movie]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
            ForEach(movies.prefix(9), id: \.self) { movie in
                MovieItem(movie: movie)
            }
        }
        .padding()
    }
}
#Preview {
    MovieDetailView(viewModel: MovieDetailViewModel(), movieId: 278)
}
