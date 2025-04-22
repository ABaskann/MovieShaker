//
//  Requests.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 15.04.2025.
//

import Foundation

class RequestManager {
    
    static let shared = RequestManager()
    private init() {}
    
    //MARK: Get Categories
    
    static func getCategories() async throws -> GenreResponse {
        
        let url = Secrets.url + "/genre/movie/list?language=en"
        
        return try await APIService.performRequest(
            url: url,
            method: .GET,
            headers: ["Authorization":"Bearer \(Secrets.tmdbApiKey)"],
            responseType: GenreResponse.self
        )
    }
    
    static func getPopularbyCategory(genreId: Int) async throws -> Movie? {
        let url = Secrets.url + "/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=\(genreId)"
        
        let response = try await APIService.performRequest(
            url: url,
            method: .GET,
            headers: ["Authorization":"Bearer \(Secrets.tmdbApiKey)"],
            responseType: MovieResponse.self
        )

        return response.results.first
    }
    
    static func getMoviesCategory(genreId: Int, page: Int = 1) async throws -> MovieResponse {
        let url = Secrets.url + "/discover/movie?include_adult=false&include_video=false&language=en-US&page=\(page)&sort_by=vote_count.desc&with_genres=\(genreId)"
        
        return try await APIService.performRequest(
            url: url,
            method: .GET,
            headers: ["Authorization":"Bearer \(Secrets.tmdbApiKey)"],
            responseType: MovieResponse.self
        )
    }
    
    static func getTopRatedMovie() async throws -> MovieResponse {
        let url = Secrets.url + "/trending/movie/day?language=en-US"
        
        return try await APIService.performRequest(
            url: url,
            method: .GET,
            headers: ["Authorization":"Bearer \(Secrets.tmdbApiKey)"],
            responseType: MovieResponse.self)
    }
    
    static func nowPlayingMovie() async throws -> MovieResponse {
        let url = Secrets.url + "/movie/now_playing?language=en-US&page=1"
        
        return try await APIService.performRequest(
            url: url,
            method: .GET,
            headers: ["Authorization":"Bearer \(Secrets.tmdbApiKey)"],
            responseType: MovieResponse.self)
    }
    
    static func popularMovie() async throws -> MovieResponse {
        let url = Secrets.url + "/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_count.desc"
        
        return try await APIService.performRequest(
            url: url,
            method: .GET,
            headers: ["Authorization":"Bearer \(Secrets.tmdbApiKey)"],
            responseType: MovieResponse.self)
    }
    
    static func topRatedMovie() async throws -> MovieResponse {
        let url = Secrets.url + "/movie/top_rated?language=en-US&page=1"
        
        return try await APIService.performRequest(
            url: url,
            method: .GET,
            headers: ["Authorization":"Bearer \(Secrets.tmdbApiKey)"],
            responseType: MovieResponse.self)
    }
    
    static func upcomingMovie() async throws -> MovieResponse {
        let url = Secrets.url + "/movie/upcoming?language=en-US&page=1"
        
        return try await APIService.performRequest(
            url: url,
            method: .GET,
            headers: ["Authorization":"Bearer \(Secrets.tmdbApiKey)"],
            responseType: MovieResponse.self)
    }
    
    static func getDetail(movieId:Int) async throws -> Movie {
        let url = Secrets.url + "/movie/\(movieId)?language=en-US"
        
        return try await APIService.performRequest(
            url: url,
            method: .GET,
            headers: ["Authorization":"Bearer \(Secrets.tmdbApiKey)"],
            responseType: Movie.self)
    }
    
    static func getSimilar(movieId:Int) async throws -> [Movie] {
        let url = Secrets.url + "/movie/\(movieId)/similar?language=en-US&page=1"
        
        let response = try await APIService.performRequest(
               url: url,
               method: .GET,
               headers: ["Authorization": "Bearer \(Secrets.tmdbApiKey)"],
               responseType: MovieResponse.self
           )
        return response.results
    }
    static func getCredits(movieId:Int) async throws -> MovieCastResponse {
        let url = Secrets.url + "/movie/\(movieId)/credits?language=en-US"
        
        return try await APIService.performRequest(
            url: url,
            method: .GET,
            headers: ["Authorization":"Bearer \(Secrets.tmdbApiKey)"],
            responseType: MovieCastResponse.self)
    }
    
    static func getRandom(page:Int) async throws -> [Movie] {
        let url = Secrets.url + "/discover/movie?include_adult=false&include_video=false&language=en-US&page=\(page)&sort_by=primary_release_date.desc&vote_average.gte=5&vote_count.gte=300"
        
        let response = try await APIService.performRequest(
               url: url,
               method: .GET,
               headers: ["Authorization": "Bearer \(Secrets.tmdbApiKey)"],
               responseType: MovieResponse.self
           )
        return response.results
    }
    

}
