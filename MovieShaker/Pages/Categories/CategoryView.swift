//
//  CategoryView.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 15.04.2025.
//

import SwiftUI

struct CategoryView: View {
    @StateObject var viewModel = CategoryViewModel()
    @EnvironmentObject var navModel: NavigationModel
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    init() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(named: "background") ?? .black
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    var body: some View {
           ScrollView {
               LazyVGrid(columns: columns, spacing: 16) {
                   ForEach(viewModel.genreItems) { genre in
                       CategoryItem(category: genre)
                           .onTapGesture {
                               navModel.navigateTo(.MovieList(genre.id, genre.name), in: .category)
                           }
                   }
               }
               .padding()
           }
           .background(Color.background)
           .onAppear {
               viewModel.loadCategoriesWithPosters()
           }
           .navigationTitle("Category")
        .navigationBarTitleDisplayMode(.inline)
           
    }
    
    struct CategoryItem: View {
        let category: GenreWithPoster

        var body: some View {
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(category.backdropPath ?? "")")) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                        .foregroundStyle(.color1)
                }
                .frame(height: 80)
                .clipped()
                .cornerRadius(12)

                Text(category.name)
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.background.opacity(0.5))
                    .cornerRadius(8)
                    .padding(.bottom, 8)
            }
        }
    }
}

#Preview {
    CategoryView()
}
