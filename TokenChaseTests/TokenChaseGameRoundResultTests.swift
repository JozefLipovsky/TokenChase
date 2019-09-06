//
//  TokenChaseGameRoundResultTests.swift
//  TokenChaseTests
//
//  Created by Jozef Lipovsky on 2019-09-02.
//  Copyright © 2019 JoLi. All rights reserved.
//

import XCTest
@testable import TokenChase

class TokenChaseGameRoundResultTests: XCTestCase {

    func testEquatableProtocolConformance() {
        let staleMate = TokenChaseGameRoundResult.stalemate
        
        let firstItemWinA = TokenChaseGameRoundResult.win(firstItemDidWin: true, secondItemDidWin: false)
        let firstItemWinB = TokenChaseGameRoundResult.win(firstItemDidWin: true, secondItemDidWin: false)
        
        let secondItemWinA = TokenChaseGameRoundResult.win(firstItemDidWin: false, secondItemDidWin: true)
        let secondItemWinB = TokenChaseGameRoundResult.win(firstItemDidWin: false, secondItemDidWin: true)
        
        XCTAssertFalse(staleMate == firstItemWinA)
        XCTAssertFalse(secondItemWinB == firstItemWinB)
        
        XCTAssertTrue(staleMate == staleMate)
        XCTAssertTrue(secondItemWinA == secondItemWinB)
        XCTAssertTrue(secondItemWinB == secondItemWinA)
    }
}
