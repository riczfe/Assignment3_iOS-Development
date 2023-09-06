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
    private var currentUser: User?
    
    func register(username: String, password: String) {
        // Implement user registration logic
    }
    
    func login(username: String, password: String) {
        // Implement user login logic
    }
    
    func logout() {
        // Implement user logout logic
    }
    
    func updateProfile(username: String, avatar: UIImage, bio: String) {
        // Implement profile update logic
    }
}
