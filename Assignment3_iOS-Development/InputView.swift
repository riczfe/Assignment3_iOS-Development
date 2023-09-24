//
//  InputView.swift
//  Assignment3_iOS-Development
//
//  Created by Nguyễn Tuân on 23/09/2023.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let title: String
    let textField: String
    var secureField = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text(title)
                .foregroundColor(Color(.systemGray2))
                .fontWeight(.semibold)
            if secureField {
                SecureField(textField, text: $text)
                    .font(.system(size: 20))
            } else {
                TextField(textField, text: $text)
                    .font(.system(size: 20))
            }
            
            Divider()
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Email Address", textField: "name@example.com")
    }
}
