//
//  MoviesServiceProtocol.swift
//  MyCinema
//
//  Created by Oleksiy Bilyi on 7/30/19.
//  Copyright © 2019 Oleg Gavrilich. All rights reserved.
//

import UIKit
import AVKit

protocol MoviesServiceProtocol {
    
    func getFilms(page: Int, sortOption: MovieSortOption, completion: @escaping ([Movie]?, Error?) -> Void)
    func getFilmDetails(for film: Movie, completion: @escaping (MovieDetails?, Error?) -> Void)
    func getImage(for film: Movie, completion: @escaping (UIImage?, Error?) -> Void)
    func getBackdrop(for film: Movie, completion: @escaping (UIImage?, Error?) -> Void)
    func getVideo(for film: Movie, completion: @escaping (MovieTrailer?, Error?) -> Void)
    
}
