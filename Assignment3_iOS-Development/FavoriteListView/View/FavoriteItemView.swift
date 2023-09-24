//
//  FavoriteItemView.swift
//  Assignment3_iOS-Development
//
//  Created by Minh Trinh Quang on 24.09.2023.
//

import SwiftUI

struct FavoriteItemView: View {
    let item: FavoriteItem
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: item.imageLink ?? ""))
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name ?? "")
                Text(item.address ?? "")
            }
            Spacer()
            Text(item.rating ?? "")
        }
    }
}

struct FavoriteItemView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteItemView(item: FavoriteItem(id: UUID().uuidString, imageLink: "https://source.unsplash.com/user/c_v_r/100x100", name: "name1", address: "address1", rating: "3.5"))
    }
}
