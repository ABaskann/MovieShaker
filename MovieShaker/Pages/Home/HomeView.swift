//
//  HomeView.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 15.04.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var selectedCategory = "Now Playing"
    let categories = ["Now Playing", "Upcoming", "Top Rated", "Popular"]
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack{
                MovieCarouselView()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(categories, id: \.self) { category in
                            VStack(spacing: 0) {
                                Text(category)
                                    .fontWeight(selectedCategory == category ? .bold : .regular)
                                    .foregroundColor(selectedCategory == category ? .white : .gray)
                                    .padding(.vertical, 8)
                                
                                
                                // Alt çizgi
                                Rectangle()
                                    .fill(Color.color1)
                                    .frame(height: selectedCategory == category ? 4 : 0)
                                    .animation(.easeInOut, value: selectedCategory)
                            }
                            .fontWeight(selectedCategory == category ? .bold : .regular)
                            .foregroundColor(selectedCategory == category ? .white : .gray)
                            .onTapGesture {
                                selectedCategory = category
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                }
                if selectedCategory == "Now Playing" {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.nowPlaying.prefix(9)) { movie in
                                MovieItem(movie:movie )
                            }
                        }
                        .padding()
                    }
                    
                }else if selectedCategory == "Upcoming" {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.upcoming.prefix(9)) { movie in
                                MovieItem(movie:movie )
                            }
                        }
                        .padding()
                    }
                    
                }else if selectedCategory == "Top Rated" {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.topRated.prefix(9)) { movie in
                                MovieItem(movie:movie )
                            }
                        }
                        .padding()
                    }
                    
                }else{
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.popular.prefix(9)) { movie in
                                MovieItem(movie:movie )
                            }
                        }
                        .padding()
                    }
                    
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
    
    
}
#Preview {
    HomeView()
}
