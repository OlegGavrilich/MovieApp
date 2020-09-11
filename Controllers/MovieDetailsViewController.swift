//
//  MovieDetailsViewController.swift
//  MyCinema
//
//  Created by Oleg Gavrilich on 8/14/19.
//  Copyright © 2019 Oleg Gavrilich. All rights reserved.
//

import UIKit
import WebKit

class MovieDetailsViewController: UIViewController {
    
    private enum Constants {
        static let videoViewSegueIdentifier = "MovieVideoViewController"
    }
    
    var movieService: MoviesServiceProtocol?
    var movie: Movie?

    // MARK: - IBOutlets
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var videoWebView: WKWebView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieDetails()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Constants.videoViewSegueIdentifier),
            let url = sender as? URL {
            let viewController = segue.destination as? MovieVideoViewController
            viewController?.videoUrl = url
        }
    }
    
    // MARK: - IBActions
    @IBAction func playVideoButton(_ sender: UIButton!) {
        guard let movie = movie else { return }
        
        movieService?.getVideo(for: movie) { (video, error) in
            guard let key = video?.results.first?.key else { return }
            
            let url = "https://www.youtube.com/watch?v=\(key)"
            let videoUrl = URL(string: url)
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constants.videoViewSegueIdentifier, sender: videoUrl)
            }
        }
    }
    
    // MARK: - Private
    private func loadMovieDetails() {
        guard let movie = movie else { return }

        movieService?.getFilmDetails(for: movie) { (details, error) in
            DispatchQueue.main.async {
                self.nameLabel.text = details?.title
                self.overviewLabel.text = details?.overview
                self.releaseDateLabel.text = details?.releaseDate
            }
        }
        
        movieService?.getBackdrop(for: movie) { (backdrop, error) in
            guard let backdrop = backdrop else { return }
            DispatchQueue.main.async {
                self.backdropImage.image = backdrop
            }
        }
    }
    
}
