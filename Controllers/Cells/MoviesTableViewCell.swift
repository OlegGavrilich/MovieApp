//
//  MoviesTableViewCell.swift
//  MyCinema
//
//  Created by Oleg Gavrilich on 8/14/19.
//  Copyright © 2019 Oleg Gavrilich. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    // MARK: - UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.makeRounded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = UIImage(systemName: "photo")
        movieImage.contentMode = .center
    }
    
    // MARK: - Public
    func setImage(_ image: UIImage) {
        movieImage.image = image
        movieImage.contentMode = .scaleAspectFit
    }
    
}

extension UIImageView {
    
    func makeRounded() {
        layer.cornerRadius = 7
    }
    
}
