//
//  MovieList.swift
//  MyCinema
//
//  Created by Oleg Gavrilich on 7/13/19.
//  Copyright © 2019 Oleg Gavrilich. All rights reserved.
//

import UIKit

struct MovieList: Decodable {
    
    let page: Int
    let results: [Movie]
    
}

struct Movie: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case id
        case title
    }
    
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    
}
