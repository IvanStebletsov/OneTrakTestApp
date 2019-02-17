//
//  UIViewExtension.swift
//  TestOneTrak
//
//  Created by Ivan Stebletsov on 13/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

// This function help to set corner radius only for certain corners of UIView
extension UIView {
    func roundCorners(corners:  CACornerMask, radius: CGFloat) {
        layer.maskedCorners = corners
        layer.cornerRadius = radius
    }
}
