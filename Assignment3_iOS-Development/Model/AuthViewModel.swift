//
//  AuthViewModel.swift
//  Assignment3_iOS-Development
//
//  Created by Nguyễn Anh Tuân on 20/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: Firebase.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("Fail to login with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String) async throws {
        do {
            let q1 = try await Auth.auth().createUser(withEmail:email, password: password)
            self.userSession = q1.user
            let user = User(id: q1.user.uid, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() //sign out user
            self.userSession = nil //sign out user session and back to login screen
            self.currentUser = nil // wipes out current userdata model
        } catch {
            print("Fail to Log out with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        guard let q2 = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? q2.data(as: User.self)
        //print("Current user is: \(self.currentUser)")
    }
}
