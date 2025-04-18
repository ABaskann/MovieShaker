//
//  HomeView.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 15.04.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var navModel: NavigationModel
    @State private var selectedCategory = "Now Playing"
    let categories = ["Now Playing", "Upcoming", "Top Rated", "Popular"]

    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack {
                MovieCarouselView()
                
                categoryPicker
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(moviesForSelectedCategory.prefix(9)) { movie in
                            MovieItem(movie: movie)
                                .onTapGesture {
                                    navModel.navigateTo(.MovieDetail(movie.id), in: .home)
                                }
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.getNowPlaying()
            viewModel.upComings()
            viewModel.topRatedMovies()
            viewModel.getPopular()
        }
    }
    
    var categoryPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categories, id: \.self) { category in
                    VStack(spacing: 0) {
                        Text(category)
                            .fontWeight(selectedCategory == category ? .bold : .regular)
                            .foregroundColor(selectedCategory == category ? .white : .gray)
                            .padding(.vertical, 8)
                        
                        Rectangle()
                            .fill(Color.color1)
                            .frame(height: selectedCategory == category ? 4 : 0)
                            .animation(.easeInOut, value: selectedCategory)
                    }
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    var moviesForSelectedCategory: [Movie] {
        switch selectedCategory {
        case "Now Playing": return viewModel.nowPlaying
        case "Upcoming": return viewModel.upcoming
        case "Top Rated": return viewModel.topRated
        case "Popular": return viewModel.popular
        default: return []
        }
    }
}
#Preview {
    HomeView()
}
