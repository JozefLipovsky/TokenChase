//
//  GridTests.swift
//  TokenChaseTests
//
//  Created by Jozef Lipovsky on 2019-08-26.
//  Copyright © 2019 JoLi. All rights reserved.
//

import XCTest
@testable import TokenChase

class GridTests: XCTestCase {
    var sut: Grid<MockItem>!
   

    override func setUp() {
        sut = Grid(items: [[MockItem(id: 0), MockItem(id: 1)]])
    }

    override func tearDown() {
        sut = nil
    }

    func testAppeningItem_atYetNonExistingRow_shouldCreateEmptyRowAndAppendItem() {
        XCTAssertEqual(sut.items.count, 1)
        
        sut.append(item: MockItem(id: 123), toRow: 1)
        XCTAssertEqual(sut.items.count, 2)
        XCTAssertEqual(sut.item(at: GridCoordinate(x: 1, y: 0))?.id, 123)
    }
    
    func testAppeningItem_toExistingRow_shouldAppendItem() {
        XCTAssertEqual(sut.items.count, 1)
        
        sut.append(item: MockItem(id: 3), toRow: 0)
        XCTAssertEqual(sut.items.count, 1)
        XCTAssertEqual(sut.item(at: GridCoordinate(x: 0, y: 2))?.id, 3)
    }
    
    func testItem_atNonExistingCoordinate_shouldReturnNil() {
        XCTAssertEqual(sut.items.count, 1)
        XCTAssertNil(sut.item(at: GridCoordinate(x: 0, y: 2)))
        XCTAssertNil(sut.item(at: GridCoordinate(x: 1, y: 0)))
    }
    
    func testItem_atExistingCoordinate_shouldReturnItem() {
        XCTAssertEqual(sut.items.count, 1)
        XCTAssertNotNil(sut.item(at: GridCoordinate(x: 0, y: 1)))
        
        sut.append(item: MockItem(id: 456), toRow: 1)
        XCTAssertNotNil(sut.item(at: GridCoordinate(x: 1, y: 0)))
        XCTAssertEqual(sut.item(at: GridCoordinate(x: 1, y: 0))?.id, 456)
    }
    
    func testItemsReset_shouldResetAllItems() {
        XCTAssertEqual(sut.item(at: GridCoordinate(x: 0, y: 0))?.id, 0)
        XCTAssertEqual(sut.item(at: GridCoordinate(x: 0, y: 1))?.id, 1)
        
        sut.resetItemsToDefaultState()
        XCTAssertNil(sut.item(at: GridCoordinate(x: 0, y: 0))?.id)
        XCTAssertNil(sut.item(at: GridCoordinate(x: 0, y: 1))?.id)
    }
}

extension GridTests {
    class MockItem: GridItemProtocol {
        var id: Int?
        
        init(id: Int) {
            self.id = id
        }
    
        func resetStateToDefault() {
            id = nil
        }
    }
}
