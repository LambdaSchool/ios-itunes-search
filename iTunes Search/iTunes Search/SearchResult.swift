//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Sameera Leola on 12/11/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
}

//Customize the results we want
struct SearchResults: Codable {
    let results: [SearchResults]
}

enum CodingKeys: String, CodingKey {
    case title = "trackName"
    case artist = "artistName"
}



