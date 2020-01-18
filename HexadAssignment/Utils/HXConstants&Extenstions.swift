//
//  File.swift
//  WunderMobility
//
//  Created by rao on 15/01/20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import Foundation
import UIKit
import MapKit

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

extension Array where Element == HXMovieModel {
    
    //    - Description: Sorts array of type HXMovieModel
    //    - Parameters: None
    //    - Returns: [HXMovieModel]
    func sorted() -> [HXMovieModel] {
        return self.sorted { (movie1, movie2) -> Bool in
            return movie1.rating > movie2.rating
        }
    }
}

extension Double {
    
    //    - Description: Rounds float to number of decimals we pass ex: if numberOfDecimals = 2, this method will return 1.233456 as 1.23
    //    - Parameters: numberOfDecimals: Int
    //    - Returns: Double
    public func roundedToDecimals(_ numberOfDecimals: Int) -> Double {
        let powerValue = Double(10^^numberOfDecimals)
        return (self*powerValue).rounded() / powerValue
    }
}

extension UIViewController {
    
    //    - Description: Presents alert view controller 
    //    - Parameters: message: String, btnTitleOne: String, btnTitleTwo: String (Can be nil), completionOk: Action Block (Can be nil), cancel: Action Block (Can be nil), title: String? = nil)
    //    - Returns: Void
    func showAlertViewWithBlock(message: String,btnTitleOne: String, btnTitleTwo: String? = "", completionOk: (() -> Void)? = nil, cancel:(() -> Void)? = nil, title: String? = nil) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: btnTitleOne, style: .default, handler: { (alertAction) -> Void in
            if let completionBlock = completionOk {
                completionBlock()
            }
        }))
        
        if !"\(btnTitleTwo ?? "")".isEmpty {
            alertView.addAction(UIAlertAction(title: btnTitleTwo, style: .cancel, handler: { (alertAction) -> Void in
                if let cancelBlock = cancel {
                    cancelBlock()
                }
            }))
            
        }
        self.present(alertView, animated: true, completion: nil)
    }
}
