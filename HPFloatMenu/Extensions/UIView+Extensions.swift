//
//  UIView+Extensions.swift
//  HPFloatMenu
//
//  Created by Hoang on 4/23/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit

public extension UIView {
    func applyRadius(radius: CGFloat, borderWidth: CGFloat = 1.0, borderColor: UIColor = UIColor.clear) {
        self.layer.borderColor      = borderColor.cgColor
        self.layer.borderWidth      = borderWidth
        self.layer.cornerRadius     = radius
        self.layer.masksToBounds    = true
    }

    func applyRoundedCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

    func applyRoundedCorner() {
        applyRoundedCorner(radius: self.frame.height/2)
    }

    func applyBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
