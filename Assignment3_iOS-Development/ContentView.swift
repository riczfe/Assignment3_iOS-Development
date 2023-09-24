//
//  ContentView.swift
//  Assignment3_iOS-Development
//
//  Created by Nguyễn Tuân on 20/09/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
   
    var body: some View {
        Group {
            if viewModel.userSession != nil{
                Profile()
            } else {
                LogIn()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
