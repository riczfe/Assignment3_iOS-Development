import SwiftUI
import Firebase

struct Profile: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var appVersion = "Loading..."
    @State private var signOutError: Error? = nil
    @State private var userName = ""

    var body: some View {
        if let user = viewModel.user {
            List {
                Section {
                    HStack {
                        Text(userName)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 40) {
                            Text(user.email)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                        }
                    }
                }

                Section("App Version") {
                    HStack {
                        RowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray2))

                        Spacer()
                        Text(appVersion)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .onAppear {
                        getAppVersion()
                    }
                }

                Section("Account") {
                    Button {
                        Task {
                            do {
                                try await viewModel.signOut()
                            } catch {
                                signOutError = error
                            }
                        }
                    } label: {
                        RowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color(.red))
                    }
                }
            }
            .onAppear {
                fetchUserName()
            }
        }
    }

    private func getAppVersion() {
        Task {
            await Task.sleep(1)
            appVersion = "1.0.0"
        }
    }

    private func fetchUserName() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }

        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        let userDocument = usersCollection.document(currentUser.uid)

        userDocument.getDocument { document, error in
            if let error = error {
                print("Error fetching user data: \(error)")
                return
            }

            if let document = document, document.exists {
                if let userName = document.data()?["name"] as? String {
                    self.userName = userName
                }
            }
        }
    }
}
