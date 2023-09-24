//
//  User.swift
//  Assignment3_iOS-Development
//
//  Created by Nguyễn Tuân on 20/09/2023.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let fullName: String
    let phoneNumber: String
    let age: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: email) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    static var Mock_User = User(id: NSUUID().uuidString, email: "tester1@gmail.com", fullName: "Micheal", phoneNumber: "+8412345678", age: "18")
}
