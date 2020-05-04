//
//  SearchResult.swift
//  iTunes_Search
//
//  Created by Brian Rouse on 5/4/20.
//  Copyright © 2020 Brian Rouse. All rights reserved.
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
