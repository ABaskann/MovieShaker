//
//  MovieListViewModel.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 21.04.2025.
//

import Foundation
@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    private var currentPage = 1
    private var isLoading = false
    private var hasMorePages = true

    func getMovies(genreId: Int) {
        guard !isLoading, hasMorePages else { return }
        isLoading = true

        Task {
            do {
                let response = try await RequestManager.getMoviesCategory(genreId: genreId, page: currentPage)
                
                DispatchQueue.main.async {
                    self.movies += response.results
                    self.currentPage += 1
                    self.isLoading = false
                    self.hasMorePages = !response.results.isEmpty
                }

            } catch {
                print("Hata: \(error.localizedDescription)")
                isLoading = false
            }
        }
    }

    func reset() {
        movies = []
        currentPage = 1
        hasMorePages = true
    }
}
