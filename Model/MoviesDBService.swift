//
//  MoviesDBService.swift
//  MyCinema
//
//  Created by Oleksiy Bilyi on 7/30/19.
//  Copyright © 2019 Oleg Gavrilich. All rights reserved.
//

import UIKit

class MoviesDBService: MoviesServiceProtocol {
    
    private enum Constants {
        enum Api {
            static let key = "fef7899f9aac38745096ad5f347e48ed"
            static let baseURL = "http://api.themoviedb.org/3"
            static let imageBaseURL = "http://image.tmdb.org/t/p/w500/"
            static let backdropBaseURL = "http://image.tmdb.org/t/p/w500/"
        }
    }
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    // MARK: - MoviesServiceProtocol
    func getFilms(page: Int, sortOption: MovieSortOption, completion: @escaping ([Movie]?, Error?) -> Void) {
        let filmStringUrl = Constants.Api.baseURL + "/discover/movie?api_key=\(Constants.Api.key)&language=en-US&sort_by=\(sortOption.rawValue)&include_adult=false&include_video=false&page=\(page)"
        
        guard let filmsURL = URL(string: filmStringUrl) else { return }
        
        URLSession.shared.dataTask(with: filmsURL) { data, _, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let filmsData = try JSONDecoder().decode(MovieList.self, from: data)
                completion(filmsData.results, nil)
            } catch {
                completion(nil, error)
            }
            
        }.resume()
    }
    
    func getFilmDetails(for film: Movie, completion: @escaping (MovieDetails?, Error?) -> Void) {
        let filmDetailsStringUrl = Constants.Api.baseURL + "/movie/\(film.id)?api_key=\(Constants.Api.key)&language=en-US"
        
        guard let filmDetailsUrl = URL(string: filmDetailsStringUrl) else { return }
        
        URLSession.shared.dataTask(with: filmDetailsUrl) { (data, _, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let filmDetailsData = try JSONDecoder().decode(MovieDetails.self, from: data)
                completion(filmDetailsData, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    func getImage(for film: Movie, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let posterPath = film.backdropPath else { return }
        
        let imageStringUrl = Constants.Api.imageBaseURL + posterPath
        
        guard let imageUrl = URL(string: imageStringUrl) else { return }
        
        if let image = imageCache.object(forKey: imageUrl as AnyObject) {
            completion(image as? UIImage, nil)
        } else {
            URLSession.shared.dataTask(with: imageUrl) { (data, _, error) in
                guard let data = data else {
                    completion(nil, error)
                    return
                }
                
                completion(UIImage(data: data), nil)
                self.imageCache.setObject(UIImage(data: data)!, forKey: imageUrl as AnyObject)
                
            }.resume()
        }
        
    }
    
    func getBackdrop(for film: Movie, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let backdropPath = film.backdropPath else { return }
        
        let backdropStringUrl = Constants.Api.backdropBaseURL + backdropPath
        
        guard let backdropUrl = URL(string: backdropStringUrl) else { return }
        
        URLSession.shared.dataTask(with: backdropUrl) { (data, _, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            completion(UIImage(data: data), nil)
        }.resume()
    }
    
    func getVideo(for film: Movie, completion: @escaping (MovieTrailer?, Error?) -> Void) {
        let videoStringUrl =  Constants.Api.baseURL + "/movie/\(film.id)/videos?api_key=\(Constants.Api.key)"
        
        guard let videoUrl = URL(string: videoStringUrl) else { return }
        
        URLSession.shared.dataTask(with: videoUrl) { (data, _, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let filmDetailsData = try JSONDecoder().decode(MovieTrailer.self, from: data)
                completion(filmDetailsData, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
}
