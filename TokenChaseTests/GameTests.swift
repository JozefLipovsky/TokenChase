//
//  GameTests.swift
//  TokenChaseTests
//
//  Created by Jozef Lipovsky on 2019-08-26.
//  Copyright © 2019 JoLi. All rights reserved.
//

import XCTest
@testable import TokenChase

class GameTests: XCTestCase {
    var sut: TokenChaseGame!
    var mockGameRules: MockGameRules!
    var mockTimer: MockTimer!
    var mockplayerA: MockPlayer!
    var mockplayerB: MockPlayer!
    var mockDelegate: MockDelegate!

    override func setUp() {
        mockGameRules = MockGameRules(gridSize: 4)
        mockTimer = MockTimer()
        mockplayerA = MockPlayer()
        mockplayerB = MockPlayer()
        mockDelegate = MockDelegate()
        sut = TokenChaseGame(gameRules: mockGameRules, timer: mockTimer, playerA: mockplayerA, playerB: mockplayerB)
        sut.delegate = mockDelegate
    }

    override func tearDown() {
        mockGameRules = nil
        mockTimer = nil
        mockplayerA = nil
        mockplayerB = nil
        mockDelegate = nil
        sut = nil
    }

    func testInitializer() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.gridSize, mockGameRules.gridSize)
        XCTAssertFalse(sut.isRunning)
    }
    
    func testStop_shouldStopTimerPrepareNewRoundAndCallDidStartNewRoundDelegate() {
        XCTAssertFalse(sut.isRunning)
        XCTAssertFalse(mockGameRules.resetTokenAndPrepareNewRoundCalled)
        XCTAssertFalse(mockDelegate.didStartNewRoundCalled)
        
        mockplayerA.score = 3
        mockplayerB.score = 5
        
        sut.start()
        XCTAssertTrue(sut.isRunning)
        
        XCTAssertEqual(mockplayerA.score, 3)
        XCTAssertEqual(mockplayerB.score, 5)
        
        sut.stop()
        XCTAssertFalse(sut.isRunning)
        XCTAssertFalse(mockTimer.isRunning)
        
        XCTAssertTrue(mockGameRules.resetTokenAndPrepareNewRoundCalled)
        
        XCTAssertEqual(mockplayerA.score, 0)
        XCTAssertEqual(mockplayerA.currentCoordinate, GridCoordinate(x: mockGameRules.gridSize - 1, y: 0))
        
        XCTAssertEqual(mockplayerB.score, 0)
        XCTAssertEqual(mockplayerB.currentCoordinate, GridCoordinate(x: 0, y: mockGameRules.gridSize - 1))
        
        XCTAssertTrue(mockDelegate.didStartNewRoundCalled)
        XCTAssertNotNil(mockDelegate.didStartNewRoundTokenUpdate)
        XCTAssertEqual(mockDelegate.didStartNewRoundplayerAInitialCoordinate, mockplayerA.currentCoordinate)
        XCTAssertEqual(mockDelegate.didStartNewRoundplayerBInitialCoordinate, mockplayerB.currentCoordinate)
    }
    
    func testStart_shouldStartTimerAndCallTimerBlock() {
        XCTAssertFalse(mockTimer.timerBlockCalled)
        XCTAssertFalse(sut.isRunning)
        
        sut.start()
        XCTAssertTrue(mockTimer.timerBlockCalled)
        XCTAssertTrue(sut.isRunning)
    }
    
    func testMovePlayers_withRandomMovesUpdate_shouldCallDidMovePlayersDelegate() {
        mockGameRules.nextMoveMockplayerAUpdate = CoordinateUpdate(previousCoordinate: GridCoordinate(x: 1, y: 2), nextCoordinate: GridCoordinate(x: 1, y: 1))
        mockplayerA.currentCoordinate = mockGameRules.nextMoveMockplayerAUpdate!.previousCoordinate
        
        mockGameRules.nextMoveMockplayerBUpdate = CoordinateUpdate(previousCoordinate: GridCoordinate(x: 3, y: 2), nextCoordinate: GridCoordinate(x: 3, y: 3))
        mockplayerB.currentCoordinate = mockGameRules.nextMoveMockplayerBUpdate!.previousCoordinate
        
        XCTAssertFalse(mockDelegate.didMovePlayersCalled)
        XCTAssertFalse(mockGameRules.nextMoveForItemCalled)
        
        sut.start()
        
        XCTAssertTrue(mockGameRules.nextMoveForItemCalled)
        
        XCTAssertTrue(mockDelegate.didMovePlayersCalled)
        XCTAssertEqual(mockDelegate.didMovePlayerAUpdate, mockGameRules.nextMoveMockplayerAUpdate)
        XCTAssertEqual(mockDelegate.didMovePlayerBUpdate, mockGameRules.nextMoveMockplayerBUpdate)
    }
    
    func testMovePlayers_withStalemateMovesUpdate_shouldCallDidMovePlayersDidFinishRoundWithStalemateAndDidStartNewRoundDelegates() {
        mockGameRules.nextMoveMockplayerAUpdate = CoordinateUpdate(previousCoordinate: GridCoordinate(x: 1, y: 1), nextCoordinate: GridCoordinate(x: 1, y: 1))
        mockplayerA.currentCoordinate = mockGameRules.nextMoveMockplayerAUpdate!.previousCoordinate
        mockplayerA.score = 5
        
        mockGameRules.nextMoveMockplayerBUpdate = CoordinateUpdate(previousCoordinate: GridCoordinate(x: 3, y: 2), nextCoordinate: GridCoordinate(x: 3, y: 2))
        mockplayerB.currentCoordinate = mockGameRules.nextMoveMockplayerBUpdate!.previousCoordinate
        mockplayerB.score = 2
        
        mockGameRules.evaluateRoundResultMockStalemate = .stalemate
        
        XCTAssertFalse(mockDelegate.didMovePlayersCalled)
        XCTAssertFalse(mockDelegate.didFinishRoundWithStalemateCalled)
        XCTAssertFalse(mockDelegate.didStartNewRoundCalled)
        
        XCTAssertFalse(mockGameRules.nextMoveForItemCalled)
        XCTAssertFalse(mockGameRules.evaluateRoundResultCalled)
        XCTAssertFalse(mockGameRules.resetTokenAndPrepareNewRoundCalled)
        
        sut.start()
        
        XCTAssertTrue(mockGameRules.nextMoveForItemCalled)
        XCTAssertTrue(mockGameRules.evaluateRoundResultCalled)
        
        XCTAssertTrue(mockGameRules.resetTokenAndPrepareNewRoundCalled)
        XCTAssertEqual(mockplayerA.score, 5)
        XCTAssertEqual(mockplayerB.score, 2)
        
        XCTAssertTrue(mockDelegate.didMovePlayersCalled)
        XCTAssertEqual(mockDelegate.didMovePlayerAUpdate, mockGameRules.nextMoveMockplayerAUpdate)
        XCTAssertEqual(mockDelegate.didMovePlayerBUpdate, mockGameRules.nextMoveMockplayerBUpdate)
        
        XCTAssertTrue(mockDelegate.didFinishRoundWithStalemateCalled)
        
        XCTAssertTrue(mockDelegate.didStartNewRoundCalled)
        XCTAssertNotNil(mockDelegate.didStartNewRoundTokenUpdate)
        XCTAssertEqual(mockDelegate.didStartNewRoundplayerAInitialCoordinate, mockplayerA.currentCoordinate)
        XCTAssertEqual(mockDelegate.didStartNewRoundplayerBInitialCoordinate, mockplayerB.currentCoordinate)
    }
    
    func testMovePlayers_withWinMovesUpdate_shouldCallDidMovePlayersDidFinishRoundWithWinAndDidStartNewRoundDelegates() {
        mockGameRules.nextMoveMockplayerAUpdate = CoordinateUpdate(previousCoordinate: GridCoordinate(x: 1, y: 2), nextCoordinate: GridCoordinate(x: 1, y: 3))
        mockplayerA.currentCoordinate = mockGameRules.nextMoveMockplayerAUpdate!.previousCoordinate
        mockplayerA.score = 5
        
        mockGameRules.nextMoveMockplayerBUpdate = CoordinateUpdate(previousCoordinate: GridCoordinate(x: 3, y: 2), nextCoordinate: GridCoordinate(x: 3, y: 2))
        mockplayerB.currentCoordinate = mockGameRules.nextMoveMockplayerBUpdate!.previousCoordinate
        mockplayerB.score = 2
        
        mockGameRules.evaluateRoundResultMockStalemate = .win(firstItemDidWin: true, secondItemDidWin: false)
        
        XCTAssertFalse(mockDelegate.didMovePlayersCalled)
        XCTAssertFalse(mockDelegate.didFinishRoundWithWinCalled)
        XCTAssertFalse(mockDelegate.didStartNewRoundCalled)
        
        XCTAssertFalse(mockGameRules.nextMoveForItemCalled)
        XCTAssertFalse(mockGameRules.evaluateRoundResultCalled)
        XCTAssertFalse(mockGameRules.resetTokenAndPrepareNewRoundCalled)
        
        sut.start()
        
        XCTAssertTrue(mockGameRules.nextMoveForItemCalled)
        XCTAssertTrue(mockGameRules.evaluateRoundResultCalled)
        
        XCTAssertTrue(mockGameRules.resetTokenAndPrepareNewRoundCalled)
        XCTAssertEqual(mockplayerA.score, 6)
        XCTAssertEqual(mockplayerB.score, 2)
        
        XCTAssertTrue(mockDelegate.didMovePlayersCalled)
        XCTAssertEqual(mockDelegate.didMovePlayerAUpdate, mockGameRules.nextMoveMockplayerAUpdate)
        XCTAssertEqual(mockDelegate.didMovePlayerBUpdate, mockGameRules.nextMoveMockplayerBUpdate)
        
        XCTAssertTrue(mockDelegate.didFinishRoundWithWinCalled)
        XCTAssertEqual(mockDelegate.didFinishRoundWithWinplayerAScore, mockplayerA.score)
        XCTAssertEqual(mockDelegate.didFinishRoundWithWinplayerBScore, mockplayerB.score)
        
        XCTAssertTrue(mockDelegate.didStartNewRoundCalled)
        XCTAssertNotNil(mockDelegate.didStartNewRoundTokenUpdate)
        XCTAssertEqual(mockDelegate.didStartNewRoundplayerAInitialCoordinate, mockplayerA.currentCoordinate)
        XCTAssertEqual(mockDelegate.didStartNewRoundplayerBInitialCoordinate, mockplayerB.currentCoordinate)
    }
}

extension GameTests {
    class MockDelegate: GameUpdateDelegate {
        var didStartNewRoundCalled = false
        var didStartNewRoundTokenUpdate: CoordinateUpdate?
        var didStartNewRoundplayerAInitialCoordinate: GridCoordinate?
        var didStartNewRoundplayerBInitialCoordinate: GridCoordinate?
        
        var didFinishRoundWithWinCalled = false
        var didFinishRoundWithWinplayerAScore: Int?
        var didFinishRoundWithWinplayerBScore: Int?
        
        var didMovePlayersCalled = false
        var didMovePlayerAUpdate: CoordinateUpdate?
        var didMovePlayerBUpdate: CoordinateUpdate?
        
        var didFinishRoundWithStalemateCalled = false
        
        func didStartNewRound(tokenUpdate: CoordinateUpdate, playerAInitialCoordinate: GridCoordinate, playerBInitialCoordinate: GridCoordinate) {
            didStartNewRoundCalled = true
            didStartNewRoundTokenUpdate = tokenUpdate
            didStartNewRoundplayerAInitialCoordinate = playerAInitialCoordinate
            didStartNewRoundplayerBInitialCoordinate = playerBInitialCoordinate
        }
        
        func didMovePlayers(playerAUpdate: CoordinateUpdate, playerBUpdate: CoordinateUpdate) {
            didMovePlayersCalled = true
            didMovePlayerAUpdate = playerAUpdate
            didMovePlayerBUpdate = playerBUpdate
        }
        
        func didFinishRoundWithWin(playerAScore: Int, playerBScore: Int) {
            didFinishRoundWithWinCalled = true
            didFinishRoundWithWinplayerAScore = playerAScore
            didFinishRoundWithWinplayerBScore = playerBScore
        }
        
        func didFinishRoundWithStalemate() {
            didFinishRoundWithStalemateCalled = true
        }
    }
    
    class MockGameRules: GameRulesProtocol {
        var gridSize: UInt = 0
        
        var nextMoveForItemCalled = false
        var nextMoveMockplayerAUpdate: CoordinateUpdate?
        var nextMoveMockplayerBUpdate: CoordinateUpdate?
        
        var evaluateRoundResultCalled = false
        var evaluateRoundResultMockWin: TokenChaseGameRoundResult?
        var evaluateRoundResultMockStalemate: TokenChaseGameRoundResult?
        
        var resetTokenAndPrepareNewRoundCalled = false
        
        init(gridSize: UInt) {
            self.gridSize = gridSize
        }
  
        func nextMoveForItem(at coordinate: GridCoordinate) -> CoordinateUpdate {
            nextMoveForItemCalled = true
            
            if coordinate == nextMoveMockplayerAUpdate?.previousCoordinate {
                return nextMoveMockplayerAUpdate!
                
            } else if coordinate == nextMoveMockplayerBUpdate?.previousCoordinate {
                return nextMoveMockplayerBUpdate!
                
            } else {
                return CoordinateUpdate(previousCoordinate: GridCoordinate(x: 0, y: 0), nextCoordinate: GridCoordinate(x: 0, y: 0))
            }
        }
        
        func evaluateRoundResult(firstItemUpdate: CoordinateUpdate, secondItemUpdate: CoordinateUpdate) -> TokenChaseGameRoundResult? {
            evaluateRoundResultCalled = true
            
            if let evaluateRoundResultMockWin = evaluateRoundResultMockWin {
                return evaluateRoundResultMockWin
                
            } else if let evaluateRoundResultMockStalemate = evaluateRoundResultMockStalemate {
                return evaluateRoundResultMockStalemate
                
            } else {
                return nil
            }
        }
        
        func resetTokenAndPrepareNewRoundFor(firstItemInitialCoordinate: GridCoordinate, secondItemInitialCoordinate: GridCoordinate) -> CoordinateUpdate {
            resetTokenAndPrepareNewRoundCalled = true
            return CoordinateUpdate(previousCoordinate: GridCoordinate(x: 0, y: 0), nextCoordinate: GridCoordinate(x: 0, y: 0))
        }
    }
    
    class MockTimer: GameTimerProtocol {
        var isRunning: Bool = false
        var timerBlock: TimerBlock? = nil
        var timerBlockCalled = false
        
        func start() {
            isRunning = true
            guard let timerBlock = timerBlock else {
                return
            }
            
            timerBlockCalled = true
            timerBlock()
        }
        
        func stop() {
            isRunning = false
        }
        
        func scheduledTimer(withBlock block: @escaping TimerBlock) {
            timerBlock = block
        }
    }
    
    class MockPlayer: PlayerProtocol {
        var currentCoordinate: GridCoordinate
        var score: Int
        
        convenience init() {
            self.init(currentCoordinate: GridCoordinate(x: 0, y: 0), score: 0)
        }
        
        init(currentCoordinate: GridCoordinate, score: Int) {
            self.currentCoordinate = currentCoordinate
            self.score = score
        }
    }
}




