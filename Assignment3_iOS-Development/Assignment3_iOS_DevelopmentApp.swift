import SwiftUI
import Firebase

@main
struct Assignment3_iOS_DevelopmentApp: App {
    @StateObject var viewModel = AuthViewModel()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeScreen()
                    .tabItem({
                        Text("Home")
                    })
                    .environmentObject(viewModel)
                ProfileView(viewModel: ProfileViewModel())
                    .tabItem({
                        Text("Profile")
                    })
                FavoriteListView(viewModel: FavoriteListViewModel())
                    .tabItem {
                        Text("Favorite List")
                    }
            }
        }
    }
}
