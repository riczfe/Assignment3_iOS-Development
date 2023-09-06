//
//  DataManager.swift
//  Assignment3_iOS-Development
//
//  Created by Eric Tran on 06/09/2023.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private var users: [User] = []
    private var music: [Music] = []
    private var genres: [String] = []
    
    private init() {
        users = loadUsers()
        music = loadMusic()
        genres = loadGenres()
    }
    
    func registerUser(username: String, email: String, password: String) -> User? {
        if users.contains(where: { $0.username == username }) {
            return nil
        }
        
        if users.contains(where: { $0.email == email }) {
            return nil
        }
        
        let user = User(id: UUID().uuidString, username: username, email: email, password: password)
        
        users.append(user)
        
        saveUsers()
        
        return user
    }
    
    func loginUser(username: String, password: String) -> User? {
        if let user = users.first(where: { $0.username == username }) {
            if user.password == password {
                return user
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func updateUserProfile(user: User) {
        if let index = users.firstIndex(where: { $0.username == user.username }) {
            users[index] = user
            
            saveUsers()
        }
    }
    
    private func saveUsers() {
        // Save the users array to storage or database
    }
    
    internal func loadUsers() -> [User] {
        // Load the users array from storage or database
        return []
    }
    
    func searchMusic(query: String) -> [Music] {
        return music.filter { $0.title.lowercased().contains(query.lowercased()) }
    }
    
    func filterMusic(genre: String) -> [Music] {
        return music.filter { $0.genre == genre }
    }
    
    func updateMusic(_ musicItem: Music) {
        if let index = music.firstIndex(where: { $0.id == musicItem.id }) {
            music[index] = musicItem
            
            saveMusic()
        }
    }
    
    internal func saveMusic() {
        // Save the music array to storage or database
    }
    
    internal func loadMusic() -> [Music] {
        // Load the music array from storage or database
        return []
    }
    
    internal func loadGenres() -> [String] {
        // Load the genres array from storage or database
        return []
    }
}
