//
//  UIColor+Theme.swift
//  iNote
//
//  Created by Thanh Minh on 11/11/17.
//  Copyright © 2017 Thanh Minh. All rights reserved.
//

import UIKit

extension UIColor {
    // navigation bar color
    static let lightRed = UIColor(red: 1.0, green: 0.0, blue: 0.03, alpha: 1)
    
    // header color
    static let lightBlue = UIColor(red:0.84, green:0.92, blue:0.96, alpha:1.00)
    // tableview color
    static let darkBlue = UIColor(red:0.00, green:0.18, blue:0.25, alpha:1.00)
    
    // cell color
    static let tealColor = UIColor(red:0.00, green:0.66, blue:0.73, alpha:1.00)
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
