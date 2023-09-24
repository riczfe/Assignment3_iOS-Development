import SwiftUI
import Firebase
import Combine

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.user = User(id: user.uid, email: user.email ?? "")
                self.isAuthenticated = true
            } else {
                self.user = nil
                self.isAuthenticated = false
            }
        }
    }

    // Sign in with email and password
    func signIn(withEmail email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    // Create a user with email and password
    func createUser(withEmail email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }

    // Sign out
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error)")
        }
    }
}
