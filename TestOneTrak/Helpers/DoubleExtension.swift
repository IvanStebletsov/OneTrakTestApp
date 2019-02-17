//
//  DoubleExtension.swift
//  TestOneTrak
//
//  Created by Ivan Stebletsov on 13/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

// This function round Double value to only 1 decimal after comma and convert to CGFloat
extension Double {
    func roundAndConvertToCGFloat() -> CGFloat {
        let number = String(format: "%.2f", self)
        let roundedDouble = Double(number)
        return CGFloat(roundedDouble!)
    }
}
