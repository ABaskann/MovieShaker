//
//  CategoryModel.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 15.04.2025.
//


import Foundation

struct Genre: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [Genre]
}

struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double?
    let genreIDs: [Int]?           // → liste API'sinde geliyor
    let genres: [Genre]?           // → detay API'sinde geliyor
    let releaseDate: String?
    let runTime: Int?              // → sadece detayda geliyor
    let tagline: String?           // → sadece detayda var
    let belongsToCollection: CollectionInfo? // → sadece detayda var

    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres, tagline
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case genreIDs = "genre_ids"
        case releaseDate = "release_date"
        case runTime = "runtime"
        case belongsToCollection = "belongs_to_collection"
    }
}
struct CastMember: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let originalName: String
    let character: String
    let profilePath: String?
    let order: Int

    enum CodingKeys: String, CodingKey {
        case id, name, character, order
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}
struct MovieCastResponse: Codable {
    let id: Int
    let cast: [CastMember]
}

struct CollectionInfo: Codable, Hashable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}

struct GenreWithPoster: Identifiable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?
}
