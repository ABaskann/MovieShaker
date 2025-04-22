//
//  ShakeViewModel.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 21.04.2025.
//

import Foundation
@MainActor
class ShakeViewModel:ObservableObject{
    @Published var movie:[Movie] = []
    @Published var randomMovieNumber = 0
    
    
    func getRandomMovie(){
        Task {
            do {
                let randomPage = Int.random(in: 1...500)
                randomMovieNumber = Int.random(in: 0...20)
               
                let response = try await RequestManager.getRandom(page: randomPage)
                DispatchQueue.main.async {
                    self.movie = response
                }
                
            }
            catch let error as APIError {
                print("Hata: \(error.localizedDescription)")
            } catch {
                print("Bilinmeyen hata: \(error.localizedDescription)")
            }
        }
    }
}
