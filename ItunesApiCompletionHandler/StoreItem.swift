//
//  StoreItem.swift
//  ItunesApiAsync
//
//  Created by Peter Pan on 2022/12/1.
//

import Foundation

struct SearchResponse: Codable {
    let results: [StoreItem]
}

struct StoreItem: Codable, Identifiable {
    var id: Int { trackId }
    let trackId: Int
    let trackName: String
    let artistName: String
}
