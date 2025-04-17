//
//  CategoryView.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 15.04.2025.
//

import SwiftUI

struct CategoryView: View {
    @StateObject var viewModel = CategoryViewModel()
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    var body: some View {
           ScrollView {
               LazyVGrid(columns: columns, spacing: 16) {
                   ForEach(viewModel.genreItems) { genre in
                       CategoryItem(category: genre)
                   }
               }
               .padding()
           }
           .background(.color2)
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
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(category.posterPath ?? "")")) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
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
