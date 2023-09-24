//
//  LoginViewController.swift
//  Assignment3_iOS-Development
//
//  Created by Eric Tran on 06/09/2023.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if username.isEmpty || password.isEmpty {
            // Handle empty fields error
            return
        }
        
        if let user = DataManager.shared.loginUser(username: username, password: password) {
            // Handle successful login
        } else {
            // Handle invalid credentials
        }
    }
}
