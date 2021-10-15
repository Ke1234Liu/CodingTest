//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    static func createVC() -> MovieDetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "\(MovieDetailViewController.self)") as? MovieDetailViewController
        return vc
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie?
    var network: NetworkType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = self.movie?.title
        self.releaseLabel.text = self.movie?.releaseDate?.dateFormatting()
        self.overviewLabel.text = self.movie?.overview
        self.setPosterImage()
    }
    
    private func setPosterImage() {
        guard let posterPath = self.movie?.posterImage else { return }
        if let imageData = ImageCache.shared.get(url: posterPath) {
            self.posterImageView.image = UIImage(data: imageData)
            return
        }
        
        self.network?.fetch(url: NetworkParams.image(url: posterPath).url) { [weak self] result in
            switch result {
            case .success(let data):
                ImageCache.shared.set(data: data, url: posterPath)
                DispatchQueue.main.async {
                    self?.posterImageView.image = UIImage(data: data)
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}
