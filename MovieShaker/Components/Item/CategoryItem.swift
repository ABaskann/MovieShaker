//
//  CategoryItem.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 16.04.2025.
//
import SwiftUI

struct MovieItem: View {
        let movie: Movie

        var body: some View {
           
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                        .foregroundStyle(.color1)
                }
                .frame(height: 144)
                .clipped()
                .cornerRadius(12)
            
        }
    }
