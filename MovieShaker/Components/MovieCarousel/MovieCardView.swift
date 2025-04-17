//
//  MovieCardView.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 16.04.2025.
//

import SwiftUI


struct MovieCardView: View {
        let movie: Movie
        let index: Int

        var body: some View {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 144, height: 210)
                .clipped()
                .cornerRadius(12)

                // Sıra numarası
                Text("\(index)")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 4)
                    .padding(8)
                    .overlay(
                        Text("\(index)")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.black.opacity(0.2))
                            .offset(x: 2, y: 2)
                    )
            }
        }
    }

#Preview {
    MovieCardView(movie: Movie(id: 1, title: "Title", overview: "", posterPath: "/dDlfjR7gllmr8HTeN6rfrYhTdwX.jpg", backdropPath: "", voteAverage: 2.0, genreIDs: [12], releaseDate: ""), index: 1)
}
