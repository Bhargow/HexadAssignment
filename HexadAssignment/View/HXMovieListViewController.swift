//
//  ViewController.swift
//  HexadAssignment
//
//  Created by rao on 16/01/20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import UIKit

class HXMovieListViewController: UIViewController {
    
    @IBOutlet var tblViewMovieList: UITableView!
    
    var movieListViewModel: HXMovieListViewModel! {
        didSet {
            tblViewMovieList.reloadData()
        }
    }
    
// MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let setButton = UIBarButtonItem(title: "Start Random Rating", style: .plain, target: self, action: #selector(self.btnRandomPressed(_:)))
        navigationItem.rightBarButtonItem = setButton

        tblViewMovieList.rowHeight = UITableView.automaticDimension
        tblViewMovieList.estimatedRowHeight = 160
        
        movieListViewModel = HXMovieListViewModel(delegate: self)
        movieListViewModel.getMovieList()
    }

// MARK: Action Handler Methods
    
    //    - Description: Triggers random rating to start
    //    - Parameters: object: UIBarButtonItem
    //    - Returns: Void
    @objc func btnRandomPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Start Random Rating" {
            sender.title = "Stop Random Rating"
            movieListViewModel.startRandomRating()
        } else {
            sender.title = "Start Random Rating"
            movieListViewModel.stopRandomRating()
        }
    }
}

// MARK: TableView DataSource Methods
extension HXMovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:
            "HXMovieListTableViewCell", for: indexPath) as? HXMovieListTableViewCell {
            let cellData = movieListViewModel.movies[indexPath.row]
            cell.movieViewModel = HXMovieCellViewModel(movieData: cellData)
            cell.ratingView.tag = indexPath.row
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: TableView Delegate Methods
extension HXMovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = movieListViewModel.movies[indexPath.row]
        let movieDetailsViewController = mainStoryBoard.instantiateViewController(withIdentifier: "HXMovieDetailsViewController") as! HXMovieDetailsViewController
        movieDetailsViewController.movieDetailsViewModel = HXMovieDetailsViewModel(movieData: cellData, delegate: self)
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}

// MARK: MovieList ViewModel Delegate Methods
extension HXMovieListViewController: HXMovieListViewModelDelegate {
    func shouldUpdateRatingForMovieModel(_ model: HXMovieModel, with value: Double) {
        self.movieListViewModel.updateRating(for: model, with: value.roundedToDecimals(1))
    }

    func shouldRefreshTableViews() {
        self.tblViewMovieList.reloadData()
    }
    
    func shouldShowError(error: String) {
        showAlertViewWithBlock(message: error, btnTitleOne: "Ok")
    }
}
