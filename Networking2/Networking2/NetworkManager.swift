import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

final class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetchTopRatedTVShows(completion: @escaping (Result<[TVShow], NetworkError>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/tv/top_rated?api_key=7481bbcf1fcb56bd957cfe9af78205f3&language=en-US&page=1"

        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL)); return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(.failure(.requestFailed)); return
            }

            guard let data = data else {
                completion(.failure(.requestFailed)); return
            }

            do {
                let decoded = try JSONDecoder().decode(TVShowResponse.self, from: data)
                completion(.success(decoded.results))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
}
