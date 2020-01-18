//
//  HexadAssignmentTests.swift
//  HexadAssignmentTests
//
//  Created by rao on 16/01/20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import XCTest
@testable import HexadAssignment

class HexadAssignmentTests: XCTestCase {
    
    var movieListViewController: HXMovieListViewController!
    var movieListTableViewCell: HXMovieListTableViewCell!
    var bundle: Bundle!
    var movieListProvider: HXMovieListProvider!
    
    override func setUp() {
        bundle = Bundle(for: type(of: self))
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: HXMovieListViewController = storyboard.instantiateViewController(withIdentifier: "HXMovieListViewController") as! HXMovieListViewController
        movieListViewController = vc
        _ = movieListViewController.view
        
        movieListProvider = HXMovieListProvider(bundle: bundle)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMovieListProvider() {
        //Positive
        do {
            let movielist = try movieListProvider.getMovieList(from: "HXMovieList")
            
            let filteredList = movielist.filter { (model) -> Bool in
                return model.title == "The Godfather: Part II"
            }
            XCTAssertFalse(movielist.isEmpty)
            XCTAssertFalse(filteredList.isEmpty)
        } catch {
            XCTFail()
        }
        
        //Failure
        movieListProvider = HXMovieListProvider(bundle: Bundle.main)
        do {
            let _ = try movieListProvider.getMovieList(from: "HXMovieList1")
            XCTFail()
        } catch let error {
            XCTAssertNotNil(error)
        }
    }
    
    func testMovieModel() {
        
        //Positive
        do {
            let movieDict: [String : Any] = [
                "title": "The Shawshank Redemption",
                "description": "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
                "releaseDate": "Sep 23 1994",
                "genre": "Drama",
                "rating": 9.2,
                "image" : "TheShawshankRedemption"
            ]
            let movieData = try JSONSerialization.data(withJSONObject: movieDict, options: .prettyPrinted)
            let movieModel = try JSONDecoder().decode(HXMovieModel.self, from: movieData)
            XCTAssertNotNil(movieModel)
        } catch {
            XCTFail()
        }
        
        //Failure
        do {
            let movieDict: [String : Any] = [:]
            let movieData = try JSONSerialization.data(withJSONObject: movieDict, options: .prettyPrinted)
            let movieModel = try JSONDecoder().decode(HXMovieModel.self, from: movieData)
            XCTAssertNil(movieModel)
        } catch let error {
            XCTAssertNotNil(error)
        }
    }
    
    func testMovieListViewModelUpdateRating() {
        let movieListViewModel = HXMovieListViewModel()
        movieListViewModel.getMovieList()
        XCTAssertFalse(movieListViewModel.movies.isEmpty)
        
        let firstMovieTitle = movieListViewModel.movies[0].title
        movieListViewModel.updateRating(for: movieListViewModel.movies[0], with: 4.0)
        
        let secondMovieTitle = movieListViewModel.movies[1].title
        movieListViewModel.updateRating(for: movieListViewModel.movies[1], with: 10.0)
        
        XCTAssertFalse(movieListViewModel.movies[0].title == firstMovieTitle)
        XCTAssertTrue(movieListViewModel.movies[0].title == secondMovieTitle)
    
        let filteredMovieList = movieListViewModel.movies.filter { (model) -> Bool in
            return model.title == firstMovieTitle
        }
        XCTAssertFalse(filteredMovieList.isEmpty)
        XCTAssertNotNil(filteredMovieList[0])
        XCTAssertTrue(filteredMovieList[0].rating == 4.0)
    }
    
    func testMovieListViewModelRandomRating() {
        let movieListViewModel = HXMovieListViewModel()
        movieListViewModel.getMovieList()
        XCTAssertFalse(movieListViewModel.movies.isEmpty)
        
        movieListViewModel.startRandomRating()
        XCTAssertFalse(movieListViewModel.stoppedRandomRating)
        
        movieListViewModel.stopRandomRating()
        XCTAssertTrue(movieListViewModel.stoppedRandomRating)
    }
    
    func testMovieListViewController() {
        let movieListViewModel = HXMovieListViewModel(movies: [], delegate: movieListViewController)
        movieListViewController.movieListViewModel = movieListViewModel
        let movieList: [HXMovieModel] = getMovieList()

        movieListViewModel.movies = movieList
        XCTAssertTrue(movieListViewController.tblViewMovieList.numberOfRows(inSection: 0) > 0)
        
        movieListTableViewCell = movieListViewController.tblViewMovieList.dequeueReusableCell(withIdentifier: "HXMovieListTableViewCell") as? HXMovieListTableViewCell
        _ = movieListTableViewCell.contentView
        movieListTableViewCell.movieViewModel = HXMovieCellViewModel(movieData: movieListViewModel.movies[2])
        XCTAssertTrue(movieListTableViewCell.lblRating.text == "\(movieListViewModel.movies[2].rating)")
        XCTAssertTrue(movieListTableViewCell.lblTitle.text == movieListViewModel.movies[2].title)
        XCTAssertTrue(movieListTableViewCell.ratingView.current == CGFloat(movieListViewModel.movies[2].rating))
        XCTAssertTrue(movieListTableViewCell.imageView?.image == UIImage.init(named: movieListViewModel.movies[2].image))
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func getMovieList() -> [HXMovieModel] {
        do {
            let movielistArray = try movieListProvider.getMovieList(from: "HXMovieList") as [HXMovieModel]
            XCTAssertFalse(movielistArray.isEmpty)
            return movielistArray
        } catch {
            
            XCTFail()
            return []
        }
    }
}
