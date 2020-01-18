//
//  HXMovieListTableViewCell.swift
//  HexadAssignment
//
//  Created by rao on 17/01/20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import UIKit

class HXMovieListTableViewCell: UITableViewCell {
    
    var movieViewModel: HXMovieCellViewModel! {
        didSet {
            setupView()
        }
    }
    
    @IBOutlet var movieImg : UIImageView!
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var lblRating : UILabel!
    @IBOutlet var ratingView : StarRatingView!

    //    - Description: Sets up tableview cell with all the data from the view model
    //    - Parameters: None
    //    - Returns: Void
    func setupView() {
        lblTitle.text = movieViewModel.movieData.title
        lblRating.text = "\(movieViewModel.movieData.rating)"
        ratingView.current = CGFloat(movieViewModel.movieData.rating)
        movieImg.image = UIImage(named: movieViewModel.movieData.image)
    }
}
