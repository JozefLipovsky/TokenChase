//
//  CoordinateUpdateTests.swift
//  TokenChaseTests
//
//  Created by Jozef Lipovsky on 2019-09-02.
//  Copyright © 2019 JoLi. All rights reserved.
//

import XCTest
@testable import TokenChase

class CoordinateUpdateTests: XCTestCase {

    func testEquatableProtocolConformance() {
        let coordinateA = GridCoordinate(x: 0, y: 0)
        let coordinateB = GridCoordinate(x: 0, y: 1)
        let coordinateC = GridCoordinate(x: 1, y: 1)
        let coordinateD = GridCoordinate(x: 1, y: 1)
        
        let firstCoordinateUpdate = CoordinateUpdate(previousCoordinate: coordinateA, nextCoordinate: coordinateB)
        var secondCoordinateUpdate = CoordinateUpdate(previousCoordinate: coordinateC, nextCoordinate: coordinateD)
        
        XCTAssertFalse(firstCoordinateUpdate == secondCoordinateUpdate)
        
        secondCoordinateUpdate = CoordinateUpdate(previousCoordinate: coordinateA, nextCoordinate: coordinateB)
        
        XCTAssertTrue(firstCoordinateUpdate == secondCoordinateUpdate)
    }
}
