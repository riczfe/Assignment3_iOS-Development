//
//  RegistrationViewController.swift
//  Assignment3_iOS-Development
//
//  Created by Eric Tran on 06/09/2023.
//

import Foundation
import UIKit

class RegistrationViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if username.isEmpty || email.isEmpty || password.isEmpty {
            // Handle empty fields error
            return
        }
        
        let user = DataManager.shared.registerUser(username: username, email: email, password: password)
        
        if user != nil {
            // Handle successful registration
        } else {
            // Handle registration error
        }
    }
}
