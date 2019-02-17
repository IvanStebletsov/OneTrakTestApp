//
//  TrackedDay.swift
//  TestOneTrak
//
//  Created by Ivan Stebletsov on 11/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import Foundation

struct TrackedDay: Codable {
    var aerobic: Int
    var date: Int
    var run: Int
    var walk: Int
    
    init(aerobic: Int, date: Int, run: Int, walk: Int) {
        self.aerobic = aerobic
        self.date = date
        self.run = run
        self.walk = walk
    }
}
