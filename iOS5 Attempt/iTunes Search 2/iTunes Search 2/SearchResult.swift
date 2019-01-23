import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    let artwork: String

    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case artwork = "artworkUrl60"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
