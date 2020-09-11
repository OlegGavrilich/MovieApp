//
//  MovieTrailer.swift
//  MyCinema
//
//  Created by Oleg Gavrilich on 20.11.2019.
//  Copyright © 2019 Oleg Gavrilich. All rights reserved.
//

import UIKit

struct MovieTrailer: Decodable {
    
    let id: Int
    let results: [MovieTrailerResult]
    
}

struct MovieTrailerResult: Decodable {
    
    let key: String
    let name: String
    
}
