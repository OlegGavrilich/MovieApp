//
//  MovieSortOption.swift
//  MyCinema
//
//  Created by Oleksiy Bilyi on 23.11.2019.
//  Copyright © 2019 Oleg Gavrilich. All rights reserved.
//

import Foundation

enum MovieSortOption: String {
    
    case popularity = "popularity.desc"
    case releaseDate = "release_date.desc"
    case revenue = "revenue.desc"
    case voteCount = "vote_count.desc"
    
    var title: String {
        switch self {
        case .popularity:
            return "Popularity"
        case .releaseDate:
            return "Release date"
        case .revenue:
            return "Revenue"
        case .voteCount:
            return "Vote count"
        }
    }
    
}
