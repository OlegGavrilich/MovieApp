//
//  MovieDetails.swift
//  MyCinema
//
//  Created by Oleg Gavrilich on 19.11.2019.
//  Copyright © 2019 Oleg Gavrilich. All rights reserved.
//

import UIKit

struct MovieDetails: Decodable {
    
    enum CodingKeys: String, CodingKey {
      case overview
      case releaseDate = "release_date"
      case id
      case title
      case voteCount = "vote_count"
      case video
      case voteAverage = "vote_average"
    }
    
    let overview: String?
    let releaseDate: String?
    let id: Int
    let title: String?
    let voteCount: Int?
    let video: Bool
    let voteAverage: Double?
    
}
