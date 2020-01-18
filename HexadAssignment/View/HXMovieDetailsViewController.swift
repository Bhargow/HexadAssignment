//
//  HXMovieDetailsViewController.swift
//  HexadAssignment
//
//  Created by rao on 18/01/20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import UIKit

class HXMovieDetailsViewController: UIViewController {
    
    @IBOutlet var movieImg : UIImageView!
    @IBOutlet var lblGenre : UILabel!
    @IBOutlet var lblReleaseDate : UILabel!
    @IBOutlet var lblRating : UILabel!
    @IBOutlet var lblDescription : UILabel!
    @IBOutlet var ratingView : StarRatingView!
    
    var movieDetailsViewModel: HXMovieDetailsViewModel!
    
    override func viewDidLoad() {
        let setButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.btnBackPressedPressed(_:)))
        navigationItem.leftBarButtonItem = setButton
        ratingView.delegate = self
        setUpMovieDetails()
    }
    
    @objc func btnBackPressedPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpMovieDetails() {
        self.navigationItem.title = movieDetailsViewModel.movieData.title
        lblRating.text = "\(movieDetailsViewModel.movieData.rating)"
        lblDescription.text = "\(movieDetailsViewModel.movieData.description)"
        lblReleaseDate.text = "\(movieDetailsViewModel.movieData.releaseDate)"
        lblGenre.text = "\(movieDetailsViewModel.movieData.genre)"
        ratingView.current = CGFloat(movieDetailsViewModel.movieData.rating)
        movieImg.image = UIImage(named: movieDetailsViewModel.movieData.image)
    }
}

// MARK: StarRating Delegate Methods
extension HXMovieDetailsViewController: StarRatingDelegate {
    //    - Description: Star rating delegate that updates the rating in the movie list
    //    - Parameters: view: StarRatingView, value: CGFloat
    //    - Returns: Void
    func StarRatingValueChanged(view: StarRatingView, value: CGFloat, isFinalValue: Bool) {
        lblRating.text = "\(Double(value).roundedToDecimals(1))"
        if isFinalValue {
            self.movieDetailsViewModel.updateRating(for: movieDetailsViewModel.movieData, with: Double(value).roundedToDecimals(1))
        }
    }
}
