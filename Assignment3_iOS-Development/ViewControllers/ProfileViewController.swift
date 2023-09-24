//
//  ProfileViewController.swift
//  Assignment3_iOS-Development
//
//  Created by Eric Tran on 06/09/2023.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = user {
            usernameTextField.text = user.username
            emailTextField.text = user.email
        } else {
            let users = DataManager.shared.loadUsers()
            if let user = users.first {
                self.user = user
                usernameTextField.text = user.username
                emailTextField.text = user.email
            }
        }
    }

    @IBAction func updateProfileButtonTapped(_ sender: UIButton) {
        let newUsername = usernameTextField.text ?? ""
        let newEmail = emailTextField.text ?? ""

        if newUsername.isEmpty || newEmail.isEmpty {
            // Handle empty fields error
            return
        }

        if let user = user {
            let updatedUser = User(id: user.id, username: newUsername, email: newEmail, password: user.password)
            DataManager.shared.updateUserProfile(user: updatedUser)

            // Handle successful profile update
        }
    }
}
