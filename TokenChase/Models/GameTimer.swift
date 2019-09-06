//
//  GameTimer.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-27.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

class GameTimer: GameTimerProtocol {
    private let timerInterval: TimeInterval
    private var timer: Timer? = nil
    private var timerBlock: TimerBlock? = nil

    init(timerInterval: TimeInterval) {
        self.timerInterval = timerInterval
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true, block: { [weak self] (timer) in
            guard let timerBlock = self?.timerBlock else {
                return
            }
            
            timerBlock()
        })
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    func scheduledTimer(withBlock block: @escaping TimerBlock) {
        timerBlock = block
    }
}
