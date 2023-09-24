import SwiftUI

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                HomeScreen()
            } else {
                LogIn()
            }
        }
    }
}

// The rest of your views and components (LogIn, Profile, etc.) remain the same as your original code.


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of AuthViewModel
        let authViewModel = AuthViewModel()

        return ContentView()
            .environmentObject(authViewModel) // Inject the AuthViewModel here
    }
}
