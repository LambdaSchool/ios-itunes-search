//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Simon Elhoej Steinmejer on 07/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import Foundation

struct SearchResult: Codable
{
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey
    {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable
{
    var results: [SearchResult]
}
