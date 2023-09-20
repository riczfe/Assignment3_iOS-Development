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
    
    @StateObject var viewModel = AuthViewModel()
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    @State var signUpSuccess = false
    @State private var navigationTo = false
    

    var body: some View {
        NavigationView {
            NavigationStack{
                ScrollView {
                    VStack(spacing: 20) {
                        
                        
                        Picker(selection: $isLoginMode, label: Text("Picker here")) {
                            Text("Login").tag(true)
                            Text("Create Account").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        
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
                                Task{
                                    try await viewModel.signIn(withEmail: email, password: password)
                                }
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
                        
                        
                        Spacer()
                        
                        
                                
                        
                        if signUpSuccess {
                            Text("Sign Up Successful")
                                .foregroundColor(.pink)
                        } else {
                            Text("Not Successful!!")
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
    }

    /*private func handleAction() {
        if isLoginMode {
            print("Log into Firebase")
        } else {
            print("Register New Account")
        }
    }*/

}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}
