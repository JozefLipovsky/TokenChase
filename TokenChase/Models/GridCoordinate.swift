//
//  GridCoordinate.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-24.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

struct GridCoordinate {
    let x: UInt
    let y: UInt
    var intX: Int { return Int(x) }
    var intY: Int { return Int(y) }
}

extension GridCoordinate: Equatable {
    static func == (lhs: GridCoordinate, rhs: GridCoordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
