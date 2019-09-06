//
//  GameTimerTests.swift
//  TokenChaseTests
//
//  Created by Jozef Lipovsky on 2019-09-01.
//  Copyright © 2019 JoLi. All rights reserved.
//

import XCTest
@testable import TokenChase

class GameTimerTests: XCTestCase {

    func testScheduledTimer_timeBlockShouldGetCalledAfterTimerStarts() {
        let timer = GameTimer(timerInterval: TimeInterval(0.1))
        let timerBlockExpectation = expectation(description: "timer block called")
        timer.start()
        timer.scheduledTimer {
            timerBlockExpectation.fulfill()
        }
        
        wait(for: [timerBlockExpectation], timeout: TimeInterval(0.3))
    }
}
