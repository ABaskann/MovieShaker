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
                    ProgressView()
                        .foregroundStyle(.color1)
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
    MovieCardView(movie: Movie(
        id: 1,
        title: "Spiderman No Way Home Spiderman No Way Home",
        overview: "A great superhero movie",
        posterPath: "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg",
        backdropPath: "/op3qmNhvwEvyT7UFyPbIfQmKriB.jpg",
        voteAverage: 4.8,
        genreIDs: [28, 12],
        genres: [Genre(id: 28, name: "Action"), Genre(id: 12, name: "Adventure")],
        releaseDate: "2020-11-12",
        runTime: 132,
        tagline: "No way back!",
        belongsToCollection: nil
    ), index: 1)
}
