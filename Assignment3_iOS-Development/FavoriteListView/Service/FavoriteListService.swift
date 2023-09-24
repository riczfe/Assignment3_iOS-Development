//
//  FavoriteListService.swift
//  Assignment3_iOS-Development
//
//  Created by Minh Trinh Quang on 24.09.2023.
//

import Foundation

final class FavoriteListService {
    
    func getFavorites() async throws -> [FavoriteItem] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        let count = Int.random(in: Range(uncheckedBounds: (0, 30)))
        var items = [FavoriteItem]()
        for index in 0...count {
            items.append(
                FavoriteItem(
                    id: UUID().uuidString,
                    imageLink: "https://source.unsplash.com/user/c_v_r/100x100",
                    name: "name\(index)", address: "address\(index)", rating: String(format: "%.1f", Float.random(in: Range(uncheckedBounds: (0, 5))))
                )
            )
        }
        
        return items
    }
}
