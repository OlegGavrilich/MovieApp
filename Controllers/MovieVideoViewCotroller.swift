//
//  MovieVideoViewCotroller.swift
//  MyCinema
//
//  Created by Oleksiy Bilyi on 23.11.2019.
//  Copyright © 2019 Oleg Gavrilich. All rights reserved.
//

import UIKit
import WebKit

class MovieVideoViewController: UIViewController {
    
    var videoUrl: URL?
    
    // MARK: - IBOutlets
    @IBOutlet weak var videoWebView: WKWebView!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVideo()
    }
    
    // MARK: - Private
    private func loadVideo() {
        guard let url = videoUrl else { return }
        
        videoWebView.load(URLRequest(url: url))
    }
    
}
