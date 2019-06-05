//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Dillon McElhinney on 9/11/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

// Struct for holding individual search results
struct SearchResult: Codable, Equatable {
    let title: String
    let creator: String
    let imageURL: String
    var imageData: Data? = nil
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case imageURL = "artworkUrl60"
    }
}

// Struct for holding the top level of the JSON results
struct SearchResults: Codable {
    let results: [SearchResult]
}
