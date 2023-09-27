//
//  ListItem.swift
//  Fetch
//
//  Created by Jeffrey Li on 9/27/23.
//

import Foundation

struct ListItem: Codable, Identifiable {
    let id: Int
    let listId: Int
    let name: String?
}
