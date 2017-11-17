//
//  IndentedLabel.swift
//  iNote
//
//  Created by Thanh Minh on 11/16/17.
//  Copyright © 2017 Thanh Minh. All rights reserved.
//

import UIKit

class IndentedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        let customRect = UIEdgeInsetsInsetRect(rect, insets)
        super.drawText(in: customRect)
    }
}
