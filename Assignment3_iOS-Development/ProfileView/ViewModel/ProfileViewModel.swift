//
//  ProfileViewModel.swift
//  Assignment3_iOS-Development
//
//  Created by Minh Trinh Quang on 23.09.2023.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    
    enum ViewState {
        case start
        case loading
        case success(profileInfo: ProfileInfo)
        case failure(error: String)
    }
    
    @Published var currentState: ViewState = .start
    private let service = ProfileViewService()
    
    func getProfile() {
        currentState = .loading
        Task {
            do {
                let profileInfo = try await service.getProfile()
                currentState = .success(profileInfo: profileInfo)
            } catch {
                currentState = .failure(error: error.localizedDescription)
            }
        }
    }
}
