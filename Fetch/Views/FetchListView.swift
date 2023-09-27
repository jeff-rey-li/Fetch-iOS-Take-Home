//
//  ContentView.swift
//  Fetch
//
//  Created by Jeffrey Li on 9/27/23.
//

import SwiftUI

struct FetchListView: View {
    @State private var fetchListViewModel: FetchListViewModel = FetchListViewModel()

    var body: some View {
        VStack {
            if let items = fetchListViewModel.items {
                scrollingList(items: items)
            } else {
                Text("Fetching data!")
            }
        }
        .padding(.horizontal)
        .task {
            await fetchListViewModel.fetchListItems()
            fetchListViewModel.filterInvalidNames()
            fetchListViewModel.sortEntries()
        }
    }
    
    @ViewBuilder
    func scrollingList(items: [ListItem]) -> some View {
        ScrollView {
            ForEach(items) { item in
                HStack(spacing: 10) {
                    Text("id: \(item.id) · listId: \(item.listId) · name: \(item.name ?? "")")
                }
                
                Divider()
                    .padding(.bottom, 4)
            }
        }
    }
}

#Preview {
    FetchListView()
}
