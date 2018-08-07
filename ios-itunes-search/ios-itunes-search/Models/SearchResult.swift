//
//  SearchResult.swift
//  ios-itunes-search
//
//  Created by Conner on 8/7/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    var results: [SearchResult]
}
