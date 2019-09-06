//
//  TokenChaseGameGridItemTests.swift
//  TokenChaseTests
//
//  Created by Jozef Lipovsky on 2019-08-26.
//  Copyright © 2019 JoLi. All rights reserved.
//

import XCTest
@testable import TokenChase

class TokenChaseGameGridItemTests: XCTestCase {
    
    func testGridItemProtocolConformance_shouldResetTokenAndVisitedProperties() {
        let item = TokenChaseGameGridItem(coordinate: GridCoordinate(x: 0, y: 0), gridSize: .four)
        XCTAssertFalse(item.isToken)
        XCTAssertFalse(item.alreadyVisited)
        
        item.updateIsTokenState(to: true)
        item.updateIsTokenState(to: false)
        
        item.resetStateToDefault()
        XCTAssertFalse(item.isToken)
        XCTAssertFalse(item.alreadyVisited)
    }

    func testTokenChaseGameGridItemProtocolConformance_shouldUpdateTokenAndVisitedStateProperties() {
        let item = TokenChaseGameGridItem(coordinate: GridCoordinate(x: 0, y: 0), gridSize: .four)
        XCTAssertFalse(item.isToken)
        XCTAssertFalse(item.alreadyVisited)
        
        item.updateIsTokenState(to: true)
        XCTAssertTrue(item.isToken)
        item.updateIsTokenState(to: false)
        XCTAssertFalse(item.isToken)
        item.updateAlreadyVisitedState(to: true)
        XCTAssertTrue(item.alreadyVisited)
        item.updateAlreadyVisitedState(to: false)
        XCTAssertFalse(item.alreadyVisited)
    }
}
