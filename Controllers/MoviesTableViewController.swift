//
//  MoviesTableViewController.swift
//  MyCinema
//
//  Created by Oleg Gavrilich on 7/13/19.
//  Copyright © 2019 Oleg Gavrilich. All rights reserved.
//
import UIKit

class MoviesTableViewController: UITableViewController {
    
    private enum Constants {
        static let movieCellIdentifier = "movie"
        static let lastFilmForNextPage = 5
    }
    
    private var loadingData: Bool = false
    private var valueToPass: Movie?
    private var movieDetails: MovieDetails?
    private var sortOptions: [MovieSortOption] = [.popularity, .voteCount, .revenue, .releaseDate]
    private var currentLoadedPage = 0
    private var movieService: MoviesServiceProtocol = MoviesDBService()
    private var moviesData = [Movie]() {
        didSet {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    private var activeSortOption: MovieSortOption = .popularity {
        didSet {
            moviesData = []
            currentLoadedPage = 0
            loadNextPage()
        }
    }
    
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSortValues()
        loadNextPage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if (segue.identifier == "mySegue") {
               let viewController = segue.destination as! MovieDetailsViewController
               viewController.movie = valueToPass
               viewController.movieService = movieService
           }
       }
    
    // MARK: - IBAction
    @IBAction func sortDidChange(_ sender: UISegmentedControl) {
        activeSortOption = sortOptions[sender.selectedSegmentIndex]
    }
    
    // MARK: - Private
    private func setupSortValues() {
        sortSegmentedControl.removeAllSegments()
        sortSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        for index in 0..<sortOptions.count {
            sortSegmentedControl.insertSegment(withTitle: sortOptions[index].title, at: index, animated: false)
        }
        sortSegmentedControl.selectedSegmentIndex = sortOptions.firstIndex { $0.rawValue == activeSortOption.rawValue } ?? 0
    }
    
    private func loadNextPage() {
        if loadingData {
            return
        }
        
        loadingData = true
        movieService.getFilms(page: currentLoadedPage + 1, sortOption: activeSortOption) { (films, error) in
            self.loadingData = false
            if let error = error {
                print(error.localizedDescription)
            } else if let films = films {
                self.currentLoadedPage += 1
                self.moviesData = self.moviesData + films
            }
        }
    }
    
}

    
// MARK: - UITableViewDataSource
extension MoviesTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieCellIdentifier) as! MoviesTableViewCell
        let movie = moviesData[indexPath.row]
        
        movieService.getImage(for: movie) { (image, error) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                if let cell1 = tableView.cellForRow(at: indexPath) as? MoviesTableViewCell {
                    cell1.setImage(image)
                }
            }
        }
        cell.movieTitleLabel.text = movie.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > moviesData.count - Constants.lastFilmForNextPage {
            loadNextPage()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        valueToPass = moviesData[indexPath.row]
        performSegue(withIdentifier: "mySegue", sender: self)
    }
    
}
