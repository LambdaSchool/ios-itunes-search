//
//  ResultType.swift
//  iTunes Search
//
//  Created by Dillon McElhinney on 9/11/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

/// Enumerates the types of results to return from the iTunes API, referred to there as "Entities"
enum ResultType: String {
    case software
    case musicTrack
    case movie
}
