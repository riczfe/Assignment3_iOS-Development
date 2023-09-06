import UIKit

struct User {
    let id: String
    let username: String
    let email: String
    var password: String
    var profileImage: UIImage?
    // Add any additional properties as needed
    
    init(id: String, username: String, email: String, password: String) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
    }
}
