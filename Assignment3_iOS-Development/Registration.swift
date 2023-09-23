//
//  Registration.swift
//  Assignment3_iOS-Development
//
//  Created by Nguyễn Tuân on 23/09/2023.
//

import SwiftUI

struct Registration: View {
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        VStack {
            
            VStack(spacing: 14){
                InputView(text: $email, title: "Email Address", textField: "name@example.com")
                    .autocapitalization(.none)
                
                InputView(text: $password, title: "Password", textField: "******", secureField: true)
                
                InputView(text: $confirmPassword, title: "Confirm Password", textField: "******", secureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            
            Button {
                Task{
                    try await viewModel.createUser(withEmail: email,password: password)
                }
            } label: {
                HStack {
                    Text("Sign up")
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)

            }
            .background(Color(.systemCyan))
            .cornerRadius(10)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Sign In!!")
                        .fontWeight(.bold)
                }
                .font(.system(size: 15))
            }

        }
    }
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        Registration()
    }
}
