//
//  LogIn.swift
//  Assignment3_iOS-Development
//
//  Created by Minh Trinh Quang on 15/09/2023.
//

import SwiftUI

struct LogIn: View{
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    
    var body: some View{
        NavigationView{
            ScrollView{
                VStack(spacing: 20){
                    Picker(selection: $isLoginMode, label: Text("Picker here")){
                        Text("Login").tag(true)
                        Text("Create Account").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding()
                    
                    if !isLoginMode{
                        Button{
                            
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size:65))
                                .padding()
                        }
                    }
                    
                    Group{
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                        
                    }.padding(12)
                        .background(Color.white)
                    
                    Button{
                        handleAction()
                    } label: {
                        HStack{
                            Spacer()
                            Text(isLoginMode ? "Login" : "Create Acount")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                        
                    }
                }.padding()
                
            }
            .navigationTitle(isLoginMode ? "Login" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                .ignoresSafeArea())
        }
    }
    
    private func handleAction(){
        if isLoginMode{
            print("Log into Firebase")
        } else{
            print("Register New Account")
        }
    }
}

struct LogIn_Previews: PreviewProvider{
    static var previews: some View{
        LogIn()
    }
}
