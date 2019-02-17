//
//  IntExtension.swift
//  TestOneTrak
//
//  Created by Ivan Stebletsov on 17/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import Foundation

// This function convert date from UNIX format and  return formatted date like string
extension Int {
    func converTimeFromUnixFormat() -> String {
        let unixDate = self / 1000
        let date = Date(timeIntervalSince1970: TimeInterval(unixDate))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}
