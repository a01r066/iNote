//
//  DateExt.swift
//  iNote
//
//  Created by Thanh Minh on 11/14/17.
//  Copyright © 2017 Thanh Minh. All rights reserved.
//

import UIKit

extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
}
