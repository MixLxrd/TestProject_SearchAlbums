import Foundation

struct SearchResponse: Decodable {
    let resultCount: Int?
    let results: [Album]
}

struct Album: Decodable {
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let collectionViewUrl: String
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case collectionName
        case artworkUrl100
        case collectionViewUrl
    }
}
