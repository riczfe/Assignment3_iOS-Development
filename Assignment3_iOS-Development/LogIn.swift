//
//  LogIn.swift
//  Assignment3_iOS-Development
//
//  Created by Minh Trinh Quang on 15/09/2023.
//

import SwiftUI
import Firebase

struct LogIn: View {
    @Environment(\.dismiss) var dismiss
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    @State var signUpSuccess = false
    

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login").tag(true)
                        Text("Create Account").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    if !isLoginMode {
                        Button {
                            // Handle button tap in Create Account mode
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 65))
                                .padding()
                        }
                    }

                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .foregroundColor(.primary) // Set text color

                        SecureField("Password", text: $password)
                            .foregroundColor(.primary) // Set text color
                    }
                    .padding(12)
                    .background(Color.white)

                    Button {
                        signUp()
                    }
                    label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Login" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }
                        .background(Color.blue)
                    }
                    if signUpSuccess {
                        Text("Sign Up Successful")
                            .foregroundColor(.pink)
                    } else {
                        Text("Unsuccessful @@")
                            .foregroundColor(.red)
                    }
                    
                    Spacer()
                    
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Return")
                    }
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Login" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05)))
            .ignoresSafeArea(.keyboard)
        }
    }

    /*private func handleAction() {
        if isLoginMode {
            print("Log into Firebase")
        } else {
            print("Register New Account")
        }
    }*/
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                isLoginMode = false
            } else {
                print("Login Successful!!")
                isLoginMode = true
            }
        }
    }
    
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                signUpSuccess = false
            } else {
                print("Successful!! Log in by your new account")
                signUpSuccess = true
            }
        }
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}
