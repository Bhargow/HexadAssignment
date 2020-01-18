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
    var rating      : Double
    
    init(title: String, rating: Double, image: String) {
        self.title = title
        self.rating = rating
        self.image = image
    }
}

