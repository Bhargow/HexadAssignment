//
//  HXMovieDetailViewModel.swift
//  HexadAssignment
//
//  Created by rao on 18/01/20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import Foundation

class HXMovieDetailsViewModel: NSObject {
    
    var movieData: HXMovieModel
    var delegate: HXMovieListViewModelDelegate?

    init(movieData: HXMovieModel, delegate: HXMovieListViewModelDelegate? = nil) {
        self.movieData = movieData
        self.delegate = delegate
    }
    
    //    - Description: Updates rating and replaces a model in the movie list
    //    - Parameters: movie: HXMovieModel, value: Double
    //    - Returns: Void
    func updateRating(for movie: HXMovieModel, with value: Double) {
        movieData.rating = value
        delegate?.shouldUpdateRatingForMovieModel(movie, with: value)
    }
}
