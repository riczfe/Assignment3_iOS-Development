//
//  Assignment3_iOS-Development
//
//  Created by Minh Trinh Quang on 15/09/2023.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            List{
                Section{
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                        .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 40){
                            Text(user.email)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                            
                        }
                    }
                    
                }
                
                Section("App Version"){
                    HStack{
                        RowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray2))
                        
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Account"){
                    Button {
                        viewModel.signOut()
                    } label: {
                        RowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color(.red))
                    }

                }
            }
        }
    }
}

   
struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AuthViewModel() // Create an instance of your AuthViewModel

        // Set the current user in the view model for the preview
        viewModel.currentUser = User(id: "123", email: "test@example.com")

        // Inject the view model into the Profile view using .environmentObject
        return Profile()
            .environmentObject(viewModel)
    }
}

