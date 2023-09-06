import Foundation
struct Music {
    let id: String
    let title: String
    let artist: String
    let genre: String
    let releaseDate: Date
    var isFavorite: Bool
    // Add any additional properties as needed
    
    init(id: String, title: String, artist: String, genre: String, releaseDate: Date, isFavorite: Bool) {
        self.id = id
        self.title = title
        self.artist = artist
        self.genre = genre
        self.releaseDate = releaseDate
        self.isFavorite = isFavorite
    }
}
