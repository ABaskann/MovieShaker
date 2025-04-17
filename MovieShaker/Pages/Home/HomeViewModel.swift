import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var nowPlaying: [Movie] = []
    @Published var topRated: [Movie] = []
    @Published var popular: [Movie] = []
    @Published var upcoming: [Movie] = []

    func getTopRatedMovies() {
        Task {
            do {
                // 1. API'den veriyi al
                let response = try await RequestManager.getTopRatedMovie()
                
                // 2. posteri olmayan filmleri çıkar
                self.movies = response.results.filter { movie in
                    guard let path = movie.posterPath else { return false }
                    return !path.isEmpty
                }
                //print("Yüklenen film sayısı: \(movies.count)")
            } catch let error as APIError {
                print("Hata: \(error.localizedDescription)")
            } catch {
                print("Bilinmeyen hata: \(error.localizedDescription)")
            }
        }
    }
    func getNowPlaying() {
        Task {
            do {
                // 1. API'den veriyi al
                let response = try await RequestManager.nowPlayingMovie()
                
                // 2. posteri olmayan filmleri çıkar
                self.nowPlaying = response.results.filter { movie in
                    guard let path = movie.posterPath else { return false }
                    return !path.isEmpty
                }
                //print("Yüklenen film sayısı: \(movies.count)")
            } catch let error as APIError {
                print("Hata: \(error.localizedDescription)")
            } catch {
                print("Bilinmeyen hata: \(error.localizedDescription)")
            }
        }
    }
    func getPopular() {
        Task {
            do {
                // 1. API'den veriyi al
                let response = try await RequestManager.popularMovie()
                
                // 2. posteri olmayan filmleri çıkar
                self.popular = response.results.filter { movie in
                    guard let path = movie.posterPath else { return false }
                    return !path.isEmpty
                }
                //print("Yüklenen film sayısı: \(movies.count)")
            } catch let error as APIError {
                print("Hata: \(error.localizedDescription)")
            } catch {
                print("Bilinmeyen hata: \(error.localizedDescription)")
            }
        }
    }
    func topRatedMovies() {
        Task {
            do {
                // 1. API'den veriyi al
                let response = try await RequestManager.topRatedMovie()
                
                // 2. posteri olmayan filmleri çıkar
                self.topRated = response.results.filter { movie in
                    guard let path = movie.posterPath else { return false }
                    return !path.isEmpty
                }
                //print("Yüklenen film sayısı: \(movies.count)")
            } catch let error as APIError {
                print("Hata: \(error.localizedDescription)")
            } catch {
                print("Bilinmeyen hata: \(error.localizedDescription)")
            }
        }
    }
    func upComings() {
        Task {
            do {
                // 1. API'den veriyi al
                let response = try await RequestManager.upcomingMovie()
                
                // 2. posteri olmayan filmleri çıkar
                self.upcoming = response.results.filter { movie in
                    guard let path = movie.posterPath else { return false }
                    return !path.isEmpty
                }
                //print("Yüklenen film sayısı: \(movies.count)")
            } catch let error as APIError {
                print("Hata: \(error.localizedDescription)")
            } catch {
                print("Bilinmeyen hata: \(error.localizedDescription)")
            }
        }
    }
}
