//
//  Favorite.swift
//  Assignment3_iOS-Development
//
//  Created by Minh Trinh Quang on 23.09.2023.
//

import SwiftUI

struct FavoriteListView: View {
    @StateObject var viewModel: FavoriteListViewModel
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.currentState {
                case .start:
                    EmptyView()
                case .loading:
                    ProgressView()
                        .scaleEffect(1, anchor: .center)
                        .progressViewStyle(.circular)
                case .success:
                    if viewModel.items.isEmpty {
                        Text("Favorites not found")
                    } else {
                        listView(items: viewModel.items)
                    }
                case .failure(let error):
                    Text(error)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
                .navigationTitle("Favorite list")
        }
        .onAppear {
            viewModel.prepareItems()
        }
    }
    
    @ViewBuilder
    private func listView(items: [FavoriteItem]) -> some View {
        List {
            ForEach(items, id: \.id) { item in
                FavoriteItemView(item: item)
            }
            .onDelete(perform: viewModel.deleteRows(at:))
        }
        .listStyle(.plain)
    }
}

struct FavoriteList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListView(viewModel: FavoriteListViewModel())
    }
}
