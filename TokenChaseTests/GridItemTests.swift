//
//  GridItemTests.swift
//  TokenChaseTests
//
//  Created by Jozef Lipovsky on 2019-08-26.
//  Copyright © 2019 JoLi. All rights reserved.
//

import XCTest
@testable import TokenChase

class GridItemTests: XCTestCase {
    
    func testTopLeftItem_withMinimumGridSize_shouldHaveRightAndBottomNeighbours() {
        let item = GridItem(coordinate: GridCoordinate(x: 0, y: 0), gridSize: .four)
        
        XCTAssertNil(item.topNeighbour)
        XCTAssertNil(item.leftNeighbour)
        
        XCTAssertNotNil(item.rightNeighbour)
        XCTAssertNotNil(item.bottomNeighbour)
        
        XCTAssertEqual(item.coordinate, GridCoordinate(x: 0, y: 0))
    }
    
    func testTopMiddleItem_withMinimumGridSize_shouldHaveRightLeftAndBottomNeighbours() {
        let item = GridItem(coordinate: GridCoordinate(x: 1, y: 0), gridSize: .four)

        XCTAssertNil(item.topNeighbour)

        XCTAssertNotNil(item.leftNeighbour)
        XCTAssertNotNil(item.rightNeighbour)
        XCTAssertNotNil(item.bottomNeighbour)

        XCTAssertEqual(item.coordinate, GridCoordinate(x: 1, y: 0))
    }

    func testTopRightItem_withMinimumGridSize_shouldHaveLeftAndBottomNeighbours() {
        let item = GridItem(coordinate: GridCoordinate(x: 3, y: 0), gridSize: .four)

        XCTAssertNil(item.topNeighbour)
        XCTAssertNil(item.rightNeighbour)

        XCTAssertNotNil(item.leftNeighbour)
        XCTAssertNotNil(item.bottomNeighbour)

        XCTAssertEqual(item.coordinate, GridCoordinate(x: 3, y: 0))
    }
    
    func testBottomLeftItem_withMinimumGridSize_shouldHaveRightAndTopNeighbours() {
        let item = GridItem(coordinate: GridCoordinate(x: 0, y: 3), gridSize: .four)
        
        XCTAssertNil(item.bottomNeighbour)
        XCTAssertNil(item.leftNeighbour)
        
        XCTAssertNotNil(item.rightNeighbour)
        XCTAssertNotNil(item.topNeighbour)
        
        XCTAssertEqual(item.coordinate, GridCoordinate(x: 0, y: 3))
    }
    
    func testBottomMiddleItem_withMinimumGridSize_shouldHaveRightLeftAndTopNeighbours() {
        let item = GridItem(coordinate: GridCoordinate(x: 2, y: 3), gridSize: .four)

        XCTAssertNil(item.bottomNeighbour)

        XCTAssertNotNil(item.leftNeighbour)
        XCTAssertNotNil(item.rightNeighbour)
        XCTAssertNotNil(item.topNeighbour)

        XCTAssertEqual(item.coordinate, GridCoordinate(x: 2, y: 3))
    }

    func testBottomRightItem_withMinimumGridSize_shouldHaveLeftAndTopNeighbours() {
        let item = GridItem(coordinate: GridCoordinate(x: 3, y: 3), gridSize: .four)

        XCTAssertNil(item.bottomNeighbour)
        XCTAssertNil(item.rightNeighbour)

        XCTAssertNotNil(item.leftNeighbour)
        XCTAssertNotNil(item.topNeighbour)

        XCTAssertEqual(item.coordinate, GridCoordinate(x: 3, y: 3))
    }
    
    func testMiddleLeftItem_withMinimumGridSize_shouldHaveRightBottomAndTopNeighbours() {
        let item = GridItem(coordinate: GridCoordinate(x: 0, y: 1), gridSize: .four)
        
        XCTAssertNil(item.leftNeighbour)
        
        XCTAssertNotNil(item.bottomNeighbour)
        XCTAssertNotNil(item.rightNeighbour)
        XCTAssertNotNil(item.topNeighbour)
        
        XCTAssertEqual(item.coordinate, GridCoordinate(x: 0, y: 1))
    }
    
    func testMiddleRightItem_withMinimumGridSize_shouldHaveLeftBottomAndTopNeighbours() {
        let item = GridItem(coordinate: GridCoordinate(x: 3, y: 1), gridSize: .four)
        
        XCTAssertNil(item.rightNeighbour)
        
        XCTAssertNotNil(item.bottomNeighbour)
        XCTAssertNotNil(item.leftNeighbour)
        XCTAssertNotNil(item.topNeighbour)
        
        XCTAssertEqual(item.coordinate, GridCoordinate(x: 3, y: 1))
    }
    
    func testMiddleMiddleItem_withMinimumGridSize_shouldHaveAllNeighbours() {
        let item = GridItem(coordinate: GridCoordinate(x: 2, y: 2), gridSize: .four)
        
        XCTAssertNotNil(item.rightNeighbour)
        XCTAssertNotNil(item.bottomNeighbour)
        XCTAssertNotNil(item.leftNeighbour)
        XCTAssertNotNil(item.topNeighbour)
        
        XCTAssertEqual(item.coordinate, GridCoordinate(x: 2, y: 2))
    }
    
    func testAvailableMoves() {
        let middleMiddleItem =  GridItem(coordinate: GridCoordinate(x: 2, y: 2), gridSize: .four)
        XCTAssertEqual(middleMiddleItem.availableMoves().count, 4)
        
        let testTopLeftItem = GridItem(coordinate: GridCoordinate(x: 0, y: 0), gridSize: .four)
        XCTAssertEqual(testTopLeftItem.availableMoves().count, 2)
        
        let middleRightItem =  GridItem(coordinate: GridCoordinate(x: 3, y: 1), gridSize: .four)
        XCTAssertEqual(middleRightItem.availableMoves().count, 3)
    }
}
