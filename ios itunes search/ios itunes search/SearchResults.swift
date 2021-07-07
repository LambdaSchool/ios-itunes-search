//
//  SearchResults.swift
//  ios itunes search
//
//  Created by Moin Uddin on 9/11/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
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
    let results: [SearchResult]
}
