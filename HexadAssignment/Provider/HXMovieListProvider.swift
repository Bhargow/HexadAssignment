//
//  HXMovieListProfiver.swift
//  HexadAssignment
//
//  Created by rao on 16/01/20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import Foundation

enum HXMovieListProviderError: Error {
    case invalidFileName(String)
    case invalidFileURL(URL)
    case invalidDataFormat(String)
}

class HXMovieListProvider {
    let bundle: Bundle!

    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }

    //    - Description: Reads the data from .json file and returns movie list
    //    - Parameters: fileName: String
    //    - Returns: Void
    func getMovieList(from fileName: String) throws -> [HXMovieModel] {

        var movieList: [HXMovieModel] = []
        guard let url = bundle.url(forResource: fileName, withExtension: ".json") else {
            throw HXMovieListProviderError.invalidFileName(fileName)
        }
        
        do {
            let data = try Data.init(contentsOf: url)
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] {
                    for movieDict in json {
                        let movieData = try JSONSerialization.data(withJSONObject: movieDict, options: .prettyPrinted)
                        let movieModel = try JSONDecoder().decode(HXMovieModel.self, from: movieData)
                        movieList.append(movieModel)
                    }
                    return movieList
                } else {
                    throw HXMovieListProviderError.invalidDataFormat("Invalid data format.")
                }
            } catch let error {
                throw HXMovieListProviderError.invalidDataFormat(error.localizedDescription)
            }
        }
    }
    
}
