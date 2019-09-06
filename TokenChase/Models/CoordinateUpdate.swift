//
//  CoordinateUpdate.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-25.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

struct CoordinateUpdate {
    let previousCoordinate: GridCoordinate
    let nextCoordinate: GridCoordinate
}

extension CoordinateUpdate: Equatable {
    static func == (lhs: CoordinateUpdate, rhs: CoordinateUpdate) -> Bool {
        return lhs.previousCoordinate == rhs.previousCoordinate && lhs.nextCoordinate == rhs.nextCoordinate
    }
}
