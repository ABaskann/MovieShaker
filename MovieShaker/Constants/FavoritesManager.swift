//
//  FavoritesManager.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 22.04.2025.
//

import SwiftUI


class FavoritesManager {
    static let shared = FavoritesManager()
    
    @AppStorage("movieList") private var movieListData: String = "[]"

    var movieList: [String] {
        get {
            guard let data = movieListData.data(using: .utf8),
                  let decoded = try? JSONDecoder().decode([String].self, from: data) else {
                return []
            }
            return decoded
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue),
               let jsonString = String(data: encoded, encoding: .utf8) {
                movieListData = jsonString
            }
        }
    }

    func toggle(_ title: String) {
        var list = movieList
        if list.contains(title) {
            list.removeAll { $0 == title }
        } else {
            list.append(title)
        }
        movieList = list
    }

    func isFavorite(_ title: String) -> Bool {
        return movieList.contains(title)
    }
}
