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
            HomeScreen()
                .environmentObject(viewModel)
        }
    }
}
