import Foundation

struct Music {
    let id: String
    let title: String
    let artist: String
    let genre: String
    let album: String // Add the 'album' property
    let releaseDate: Date
    var isFavorite: Bool
    
    // Add any additional properties as needed
    
    init(id: String, title: String, artist: String, genre: String, album: String, releaseDate: Date, isFavorite: Bool) {
        self.id = id
        self.title = title
        self.artist = artist
        self.genre = genre
        self.album = album // Initialize the 'album' property
        self.releaseDate = releaseDate
        self.isFavorite = isFavorite
    }
}
