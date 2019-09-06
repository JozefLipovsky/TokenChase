//
//  TokenChaseGameRulesTests.swift
//  TokenChaseTests
//
//  Created by Jozef Lipovsky on 2019-09-01.
//  Copyright © 2019 JoLi. All rights reserved.
//

import XCTest
@testable import TokenChase

class TokenChaseGameRulesTests: XCTestCase {
    // TODO: Create "RandomMovesGenerator/RandomNumberGenerator" that can be injected into TokenChaseGameRules for easier nextRandomMove() and resetPrizeToken() mocking
    var mockGrid: TokenChaseGameGrid!
    var sut: TokenChaseGameRules!

    override func setUp() {
        mockGrid = TokenChaseGameGrid(gridSize: .four)
        sut = TokenChaseGameRules(grid: mockGrid)
    }

    override func tearDown() {
        mockGrid = nil
        sut = nil
    }

    func testInitializer() {
        XCTAssertNotNil(sut.prizeTokenCoordinate)
        XCTAssertEqual(sut.gridSize, UInt(mockGrid.items.count))
    }
    
    func testNextMoveForItem_whenNextMoveIsEqualToCurrentCoordiante_shouldReturnUpdateWithEqalCoordiantes() {
        mockGrid.item(at: GridCoordinate(x: 0, y: 1))?.updateAlreadyVisitedState(to: true)
        mockGrid.item(at: GridCoordinate(x: 1, y: 0))?.updateAlreadyVisitedState(to: true)
        
        let currentItemCoordinate = GridCoordinate(x: 0, y: 0)
        let itemUpdate = sut.nextMoveForItem(at: currentItemCoordinate)
        
        let expectedUpdate = CoordinateUpdate(previousCoordinate: currentItemCoordinate, nextCoordinate: currentItemCoordinate)
        
        XCTAssertEqual(itemUpdate.previousCoordinate, expectedUpdate.previousCoordinate)
        XCTAssertEqual(itemUpdate.nextCoordinate, expectedUpdate.nextCoordinate)
    }
    
    func testNextMoveForItem_whenNextMoveIsDifferentFromCurrentCoordiante_shouldReturnUpdateWithNonEqalCoordiantesAndUpdateVisitedState() {
        mockGrid.item(at: GridCoordinate(x: 0, y: 1))?.updateAlreadyVisitedState(to: true)
        
        let currentItemCoordinate = GridCoordinate(x: 0, y: 0)
        let expectedUpdate = CoordinateUpdate(previousCoordinate: currentItemCoordinate, nextCoordinate: GridCoordinate(x: 1, y: 0))
        
        XCTAssertFalse(mockGrid.item(at: expectedUpdate.nextCoordinate)!.alreadyVisited)
        
        let itemUpdate = sut.nextMoveForItem(at: currentItemCoordinate)
    
        XCTAssertEqual(itemUpdate.previousCoordinate, expectedUpdate.previousCoordinate)
        XCTAssertEqual(itemUpdate.nextCoordinate, expectedUpdate.nextCoordinate)
        XCTAssertTrue(mockGrid.item(at: expectedUpdate.nextCoordinate)!.alreadyVisited)
    }
    
    
    func testEvaluateRoundResult_shouldReturnNil() {
        let playerAMockUpdate = CoordinateUpdate(previousCoordinate: GridCoordinate(x: 1, y: 1), nextCoordinate: GridCoordinate(x: 1, y: 2))
        let playerBMockUpdate =  CoordinateUpdate(previousCoordinate: GridCoordinate(x: 3, y: 2), nextCoordinate: GridCoordinate(x: 3, y: 3))
        
        sut.prizeTokenCoordinate = GridCoordinate(x: 2, y: 2)
        
        XCTAssertNil(sut.evaluateRoundResult(firstItemUpdate: playerAMockUpdate, secondItemUpdate: playerBMockUpdate))
    }
    
    func testEvaluateRoundResult_shouldReturnWin() {
        let playerAMockUpdate = CoordinateUpdate(previousCoordinate: GridCoordinate(x: 1, y: 1), nextCoordinate: GridCoordinate(x: 1, y: 2))
        let playerBMockUpdate =  CoordinateUpdate(previousCoordinate: GridCoordinate(x: 3, y: 2), nextCoordinate: GridCoordinate(x: 3, y: 3))
        
        sut.prizeTokenCoordinate = playerAMockUpdate.nextCoordinate
        
        let roundResult = sut.evaluateRoundResult(firstItemUpdate: playerAMockUpdate, secondItemUpdate: playerBMockUpdate)
        
        XCTAssertNotNil(roundResult)
        XCTAssertEqual(roundResult, TokenChaseGameRoundResult.win(firstItemDidWin: true, secondItemDidWin: false))
    }
    
    func testEvaluateRoundResult_shouldReturnStalemate() {
        let playerAMockUpdate = CoordinateUpdate(previousCoordinate: GridCoordinate(x: 1, y: 1), nextCoordinate: GridCoordinate(x: 1, y: 1))
        let playerBMockUpdate =  CoordinateUpdate(previousCoordinate: GridCoordinate(x: 3, y: 2), nextCoordinate: GridCoordinate(x: 3, y: 2))
        
        sut.prizeTokenCoordinate = GridCoordinate(x: 2, y: 2)
        
        let roundResult = sut.evaluateRoundResult(firstItemUpdate: playerAMockUpdate, secondItemUpdate: playerBMockUpdate)
        
        XCTAssertNotNil(roundResult)
        XCTAssertEqual(roundResult, TokenChaseGameRoundResult.stalemate)
    }
    
    func testResetTokenAndPrepareNewRound_shouldResetItemsAndReturnTokenUpdate() {
        let playerAInitialCoordinate = GridCoordinate(x: 0, y: 0)
        let playerBInitialCoordinate = GridCoordinate(x: 3, y: 3)
        
        let mockPlayerFirstMove = GridCoordinate(x: 1, y: 1)
        let mockPlayerSecondMove = GridCoordinate(x: 1, y: 2)
        let mockPlayerThirdMove = GridCoordinate(x: 2, y: 2)
        
        mockGrid.item(at: mockPlayerFirstMove)?.updateAlreadyVisitedState(to: true)
        mockGrid.item(at: mockPlayerSecondMove)?.updateAlreadyVisitedState(to: true)
        mockGrid.item(at: mockPlayerThirdMove)?.updateAlreadyVisitedState(to: true)
        
        XCTAssertTrue(mockGrid.item(at: mockPlayerFirstMove)!.alreadyVisited)
        XCTAssertTrue(mockGrid.item(at: mockPlayerSecondMove)!.alreadyVisited)
        XCTAssertTrue(mockGrid.item(at: mockPlayerThirdMove)!.alreadyVisited)
        
        let tokenUpdate = sut.resetTokenAndPrepareNewRoundFor(firstItemInitialCoordinate: playerAInitialCoordinate, secondItemInitialCoordinate: playerBInitialCoordinate)
        XCTAssertFalse(mockGrid.item(at: mockPlayerFirstMove)!.alreadyVisited)
        XCTAssertFalse(mockGrid.item(at: mockPlayerSecondMove)!.alreadyVisited)
        XCTAssertFalse(mockGrid.item(at: mockPlayerThirdMove)!.alreadyVisited)
        XCTAssertNotNil(tokenUpdate)
        XCTAssertTrue(mockGrid.item(at: playerAInitialCoordinate)!.alreadyVisited)
        XCTAssertTrue(mockGrid.item(at: playerBInitialCoordinate)!.alreadyVisited)
    }
}
