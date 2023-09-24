//
//  FavoriteListViewModel.swift
//  Assignment3_iOS-Development
//
//  Created by Minh Trinh Quang on 24.09.2023.
//

import Foundation

final class FavoriteListViewModel: ObservableObject {
    enum ViewState {
        case start
        case loading
        case success
        case failure(error: String)
    }
    
    private let service = FavoriteListService()
    @Published var currentState: ViewState = .start
    @Published var items = [FavoriteItem]()
    
    func prepareItems() {
        currentState = .loading
        Task { @MainActor in
            do {
                let items = try await service.getFavorites()
                self.items = items
                currentState = .success
            } catch {
                currentState = .failure(error: error.localizedDescription)
            }
        }
    }
    
    func deleteRows(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
