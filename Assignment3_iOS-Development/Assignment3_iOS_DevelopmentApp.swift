import SwiftUI
import Firebase

@main
struct Assignment3_iOS_DevelopmentApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
    }
}
