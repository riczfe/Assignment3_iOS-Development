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
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword, title: "Confirm Password", textField: "******", secureField: true)
                    
                    //adding checkup icon (if needed)
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // Sign Up Button
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
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Back to Sign In!!")
                        .fontWeight(.bold)
                }
                .font(.system(size: 15))
            }

        }
    }
}

extension Registration: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 6
        && !confirmPassword.isEmpty
        && confirmPassword == password
    }
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        Registration()
    }
}
