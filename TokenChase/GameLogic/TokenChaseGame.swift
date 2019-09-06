//
//  TokenChaseGame.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-24.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

class TokenChaseGame {
    private var playerA: PlayerProtocol
    private var playerB: PlayerProtocol
    private let timer: GameTimerProtocol
    private let gameRules: GameRulesProtocol
    private(set) var isRunning: Bool = false
    var gridSize: UInt { return gameRules.gridSize }
    weak var delegate: GameUpdateDelegate?
    
    init(gameRules: GameRulesProtocol, timer: GameTimerProtocol, playerA: PlayerProtocol, playerB: PlayerProtocol) {
        self.timer = timer
        self.gameRules = gameRules
        self.playerA = playerA
        self.playerB = playerB
    }
    
    func stop() {
        guard isRunning else {
            return
        }
        
        isRunning = false
        reset()
        timer.stop()
    }
    
    func start() {
        guard !isRunning else {
            return
        }
        
        isRunning = true
        timer.scheduledTimer { [weak self] in
            self?.moveTokenChase()
        }
        
        timer.start()
    }
    
    func reset() {
        prepareNewRound(playerAScore: 0, playerBScore: 0)
    }
    
    // MARK:- Private
    
    private func moveTokenChase() {
        let playerAUpdate = gameRules.nextMoveForItem(at: playerA.currentCoordinate)
        playerA.currentCoordinate = playerAUpdate.nextCoordinate
        
        let playerBUpdate = gameRules.nextMoveForItem(at: playerB.currentCoordinate)
        playerB.currentCoordinate = playerBUpdate.nextCoordinate
    
        delegate?.didMovePlayers(playerAUpdate: playerAUpdate, playerBUpdate: playerBUpdate)
        
        if let roundEndResult = gameRules.evaluateRoundResult(firstItemUpdate: playerAUpdate, secondItemUpdate: playerBUpdate) {
            switch roundEndResult {
            case .stalemate:
                delegate?.didFinishRoundWithStalemate()
                prepareNewRound(playerAScore: playerA.score, playerBScore: playerB.score)
                
            case .win(let firstItemDidWin, let secondItemDidWin):
                playerA.score += (firstItemDidWin) ? 1 : 0
                playerB.score += (secondItemDidWin) ? 1 : 0
                delegate?.didFinishRoundWithWin(playerAScore: playerA.score, playerBScore: playerB.score)
                prepareNewRound(playerAScore: playerA.score, playerBScore: playerB.score)
            }
        }
    }
    
    private func prepareNewRound(playerAScore: Int, playerBScore: Int) {
        playerA.currentCoordinate = GridCoordinate(x: gridSize - 1, y: 0)
        playerA.score = playerAScore
        
        playerB.currentCoordinate = GridCoordinate(x: 0, y: gridSize - 1)
        playerB.score = playerBScore
        
        let tokenUpdate = gameRules.resetTokenAndPrepareNewRoundFor(firstItemInitialCoordinate: playerA.currentCoordinate, secondItemInitialCoordinate: playerB.currentCoordinate)
        
        delegate?.didStartNewRound(tokenUpdate: tokenUpdate, playerAInitialCoordinate: playerA.currentCoordinate, playerBInitialCoordinate: playerB.currentCoordinate)
    }
}
