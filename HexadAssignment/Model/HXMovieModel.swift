//
//  HXMovieModel.swift
//  HexadAssignment
//
//  Created by rao on 16/01/20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import Foundation

struct HXMovieModel: Decodable {
    let title       : String
    let image       : String
    let description       : String
    let releaseDate       : String
    let genre       : String
    var rating      : Double
    
    init(title: String, rating: Double, image: String, description: String, releaseDate: String, genre: String) {
        self.title = title
        self.rating = rating
        self.image = image
        self.description = description
        self.releaseDate = releaseDate
        self.genre = genre
    }
}

