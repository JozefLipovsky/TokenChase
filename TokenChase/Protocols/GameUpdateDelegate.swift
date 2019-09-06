//
//  GameUpdateDelegate.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-25.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

protocol GameUpdateDelegate: class {
    func didStartNewRound(tokenUpdate: CoordinateUpdate, playerAInitialCoordinate: GridCoordinate, playerBInitialCoordinate: GridCoordinate)
    func didMovePlayers(playerAUpdate: CoordinateUpdate, playerBUpdate: CoordinateUpdate)
    func didFinishRoundWithWin(playerAScore: Int, playerBScore: Int)
    func didFinishRoundWithStalemate()
}
