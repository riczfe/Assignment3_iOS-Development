//
//  MusicDiscoveryManager.swift
//  Assignment3_iOS-Development
//
//  Created by Eric Tran on 06/09/2023.
//

import Foundation

class MusicDiscoveryManager {
    static let shared = MusicDiscoveryManager()
    private init() {}
    
    func searchMusic(query: String) -> [Music] {
        // Implementation for music search
        // Retrieve matching music from DataManager or database based on query
        let music = DataManager.shared.searchMusic(query: query)
        return music
    }
    
    func filterMusic(genre: String) -> [Music] {
        // Implementation for music filtering
        // Retrieve music from DataManager or database based on genre
        let music = DataManager.shared.filterMusic(genre: genre)
        return music
    }
    
    // Add any additional methods as needed
}
