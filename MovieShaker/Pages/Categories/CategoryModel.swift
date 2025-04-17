//
//  CategoryModel.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 15.04.2025.
//

import Foundation

struct Genre: Codable, Identifiable,Hashable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [Genre]
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let genreIDs: [Int]
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case genreIDs = "genre_ids"
        case releaseDate = "release_date"
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}

struct GenreWithPoster: Identifiable {
    let id: Int
    let name: String
    let posterPath: String? // o kategoriye ait filmin posteri
}
