//
//  UserManager.swift
//  Assignment3_iOS-Development
//
//  Created by Eric Tran on 06/09/2023.
//

import Foundation
import UIKit

class UserManager {
    static let shared = UserManager()
    private init() {}
    
    func registerUser(username: String, email: String, password: String) -> User? {
        // Implementation for user registration
        let id = UUID().uuidString
        let user = User(id: id, username: username, email: email, password: password)
        // Save user to DataManager or database
        DataManager.shared.registerUser(username: username, email: email, password: password)
        return user
    }
    
    func loginUser(username: String, password: String) -> User? {
        // Implementation for user login
        // Retrieve user from DataManager or database based on username and password
        let user = DataManager.shared.loginUser(username: username, password: password)
        return user
    }
    
    func updateUserProfile(user: User) {
        // Implementation for updating user profile
        // Update user in DataManager or database
        DataManager.shared.updateUserProfile(user: user)
    }
    
    // Add any additional methods as needed
}
