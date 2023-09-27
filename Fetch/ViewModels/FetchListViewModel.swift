//
//  FetchListViewModel.swift
//  Fetch
//
//  Created by Jeffrey Li on 9/27/23.
//

import Foundation

@Observable
class FetchListViewModel {
    var items: [ListItem]?
    
    /// Makes an API call to fetch data to populate items list.
    func fetchListItems() async {
        let url = URL(string: "https://fetch-hiring.s3.amazonaws.com/hiring.json")
        let request = URLRequest(url: url!)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            items = try JSONDecoder().decode([ListItem].self, from: data)
        } catch {
            print(error)
        }
    }
    
    /// Removes list items that have no name.
    func filterInvalidNames() {
        items = items?.filter {
            $0.name != nil && $0.name != ""
        }
    }
    
    /// Sorts list items by listId ascending, then name ascending.
    func sortEntries() {
        items = items?.sorted {
            if ($0.listId == $1.listId) {
                return $0.name! < $1.name!
            } else {
                return $0.listId < $1.listId
            }
        }
    }
}
