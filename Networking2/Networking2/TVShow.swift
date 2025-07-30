import Foundation

struct TVShowResponse: Decodable {
    let results: [TVShow]
}

struct TVShow: Decodable {
    let name: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case name
        case posterPath = "poster_path"
    }
}
