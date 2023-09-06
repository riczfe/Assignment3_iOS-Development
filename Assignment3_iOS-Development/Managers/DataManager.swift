//
//  DataManager.swift
//  Assignment3_iOS-Development
//
//  Created by Eric Tran on 06/09/2023.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    private init() {}
    
    private var users: [User] = []
    private var music: [Music] = []
    
    func saveUser(_ user: User) {
        // Implementation for saving user data
        users.append(user)
    }
    
    func updateUser(_ user: User) {
        // Implementation for updating user data
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index] = user
        }
    }
    
    func getUser(username: String, password: String) -> User? {
        // Implementation for retrieving user data
        return users.first(where: { $0.username == username && $0.password == password })
    }
    
    func saveMusic(_ music: Music) {
        // Implementation for saving music data
        self.music.append(music)
    }
    
    func searchMusic(query: String) -> [Music] {
        // Implementation for searching music data
        return music.filter { $0.title.localizedCaseInsensitiveContains(query) || $0.artist.localizedCaseInsensitiveContains(query) }
    }
    
    func filterMusic(genre: String) -> [Music] {
        // Implementation for filtering music data
        return music.filter { $0.genre == genre }
    }
    
    // Add any additional methods as needed
}
