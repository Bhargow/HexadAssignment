//
//  HXMovieListViewModel.swift
//  HexadAssignment
//
//  Created by rao on 16/01/20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import Foundation

protocol HXMovieListViewModelDelegate {
    func shouldRefreshTableViews()
    func shouldShowError(error: String)
}

class HXMovieListViewModel: NSObject {
    
    var movies: [HXMovieModel] {
        didSet {
            delegate?.shouldRefreshTableViews()
        }
    }
    var delegate: HXMovieListViewModelDelegate?

    var stoppedRandomRating: Bool = false
    
    init(movies: [HXMovieModel] = [], delegate: HXMovieListViewModelDelegate? = nil) {
        self.movies = movies
        self.delegate = delegate
    }
    
    //    - Description: Gets movie list from the HXMovieList.json file
    //    - Parameters: None
    //    - Returns: Void
    func getMovieList() {
        do {
            let movieList = try HXMovieListProvider().getMovieList(from: "HXMovieList")
            self.movies = movieList.sorted()
        } catch let error {
            print(error)
            delegate?.shouldShowError(error: error.localizedDescription)
        }
    }

    //    - Description: Updates rating and replaces a model in the movie list
    //    - Parameters: movie: HXMovieModel, value: Double
    //    - Returns: Void
    func updateRating(for movie: HXMovieModel, with value: Double) {
        var ratedMovie = movie
        ratedMovie.rating = value
        let index = self.movies.firstIndex { (iteratedMovie) -> Bool in
            return movie.title == iteratedMovie.title
        }
        if let arrayIndex = index {
            self.movies[arrayIndex] = ratedMovie
            self.movies = self.movies.sorted()
            self.delegate?.shouldRefreshTableViews()
        }
    }
    
    //    - Description: Starts radomly rating movies in the movie list untill stop button is pressed
    //    - Parameters: None
    //    - Returns: Void
    func startRandomRating() {
        let randomTiming = Double.random(in: 0...10)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + randomTiming) {
            if !self.stoppedRandomRating {
                let randomMovieIndex = Int.random(in: 0..<10)
                let randomRating = Double.random(in: 1...10)
                let ratedMovie = self.movies[randomMovieIndex]
                self.updateRating(for: ratedMovie, with: randomRating.roundedToDecimals(1))
                
                self.startRandomRating()
            }
        }
    }
    
    //    - Description: Stops radomly rating movies
    //    - Parameters: None
    //    - Returns: Void
    func stopRandomRating() {
        stoppedRandomRating = true
    }
}

