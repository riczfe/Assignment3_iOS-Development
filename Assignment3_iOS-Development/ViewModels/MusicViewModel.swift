//
//  MusicViewModel.swift
//  Assignment3_iOS-Development
//
//  Created by Eric Tran on 06/09/2023.
//

import Foundation

class MusicCellViewModel {
    private var music: Music
    
    var title: String {
        return music.title
    }
    
    var artist: String {
        return music.artist
    }
    
    var genre: String {
        return music.genre
    }
    
    var album: String {
        return music.album
    }
    
    var releaseDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: music.releaseDate)
    }
    
    var isFavorite: Bool {
        get {
            return music.isFavorite
        }
        set {
            music.isFavorite = newValue
            // Save updated music to DataManager or database
            DataManager.shared.updateMusic(music)
        }
    }
    
    init(music: Music) {
        self.music = music
    }
}
