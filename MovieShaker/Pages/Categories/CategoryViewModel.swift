//
//  CategoryViewModel.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 15.04.2025.
//

import Foundation
@MainActor
class CategoryViewModel: ObservableObject {
    
   @Published var categories: [Genre] = []
    @Published var genreItems: [GenreWithPoster] = []
    
    func getCategories(){
        Task{
            do{
                let response = try await RequestManager.getCategories()
                DispatchQueue.main.async {
                   // print(response)
                    self.categories = response.genres.map { category in
                        Genre(id: category.id, name: category.name)
                        
                    }
                }
                
            }catch let error as APIError {
                DispatchQueue.main.async {
                    print("Hata: \(error.localizedDescription)")
//                    self.errorMessage = error.localizedDescription
//                    self.clearError()
//                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    print("Bilinmeyen hata: \(error.localizedDescription)")
//                    self.isLoading = false
                }
            }
        }
    }
    
   

        func loadCategoriesWithPosters() {
            Task {
                do {
                    let genreResponse = try await RequestManager.getCategories()
                    var items: [GenreWithPoster] = []

                    for genre in genreResponse.genres {
                        if let movie = try? await RequestManager.getPopularbyCategory(genreId: genre.id) {
                            let item = GenreWithPoster(id: genre.id, name: genre.name, posterPath: movie.posterPath,backdropPath: movie.backdropPath)
                            items.append(item)
                        } else {
                            items.append(GenreWithPoster(id: genre.id, name: genre.name, posterPath: nil,backdropPath: nil))
                        }
                    }

                    self.genreItems = items
                } catch {
                    print("Kategori/Posteri yüklerken hata: \(error.localizedDescription)")
                }
            }
        }
}
