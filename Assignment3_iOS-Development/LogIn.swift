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
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    @State var signUpSuccess = false
    @State private var navigationTo = false
    
    
    var body: some View {
        NavigationView {
            NavigationStack{
                ScrollView {
                    VStack {
                        
                        
                        VStack(spacing: 14){
                            InputView(text: $email, title: "Email Address", textField: "name@example.com")
                                .autocapitalization(.none)
                            
                            InputView(text: $password, title: "Password", textField: "******", secureField: true)
                        }
                        .padding(.horizontal)
                        .padding(.top, 12)
                        
                        //Button SignIn
                        
                        Button {
                            Task {
                                try await viewModel.signIn(withEmail: email, password: password)
                            }
                        } label: {
                            HStack {
                                Text("Sign in")
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)

                        }
                        .background(Color(.systemCyan))
                        .cornerRadius(10)
                        .padding(.top, 24)
                        
                        
                        Spacer()
                        
                        NavigationLink {
                            Registration()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            HStack {
                                Text("Sign Up!!")
                                    .fontWeight(.bold)
                            }
                            .font(.system(size: 15))
                        }

                    }
                }
            }
        }
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}
