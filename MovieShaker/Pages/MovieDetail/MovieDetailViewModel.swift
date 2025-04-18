//
//  MovieDetailViewModel.swift
//  MovieShaker
//
//  Created by Armağan Başkan on 18.04.2025.
//

import Foundation
@MainActor
class MovieDetailViewModel:ObservableObject {
    @Published var movie:Movie?
    @Published var similar:[Movie] = []
    @Published var cast:[CastMember] = []
    
    func getMovieDetail(id:Int){
        Task{
            do{
                let response = try await RequestManager.getDetail(movieId: id)
                DispatchQueue.main.async {
                    self.movie = response
                }
            } catch let error as APIError {
                print("Hata: \(error.localizedDescription)")
            } catch {
                print("Bilinmeyen hata: \(error.localizedDescription)")
            }

        }
    }
    func getSimilarMovies(id:Int){
        Task{
            do{
                let response = try await RequestManager.getSimilar(movieId: id)
                DispatchQueue.main.async {
                    self.similar = response
                }
            } catch let error as APIError {
                print("Hata: \(error.localizedDescription)")
            } catch {
                print("Bilinmeyen hata: \(error.localizedDescription)")
            }

        }
    }
    func getCredit(id:Int){
        Task{
            do{
                let response = try await RequestManager.getCredits(movieId: id)
                DispatchQueue.main.async {
                    self.cast = response.cast
                }
            } catch let error as APIError {
                print("Hata: \(error.localizedDescription)")
            } catch {
                print("Bilinmeyen hata: \(error.localizedDescription)")
            }

        }
    }
}
