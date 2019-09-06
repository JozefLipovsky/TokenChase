//
//  GridCoordinateTests.swift
//  TokenChaseTests
//
//  Created by Jozef Lipovsky on 2019-08-26.
//  Copyright © 2019 JoLi. All rights reserved.
//

import XCTest
@testable import TokenChase

class GridCoordinateTests: XCTestCase {

    func testEquatableProtocolConformance() {
        let coordinateA = GridCoordinate(x: 0, y: 0)
        let coordinateB = GridCoordinate(x: 0, y: 1)
        
        XCTAssertFalse(coordinateA == coordinateB)
        
        let coordinateC = GridCoordinate(x: 1, y: 1)
        let coordinateD = GridCoordinate(x: 1, y: 1)

        XCTAssertTrue(coordinateC == coordinateD)
    }
}
