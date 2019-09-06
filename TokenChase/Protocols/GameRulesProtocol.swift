//
//  GameRulesProtocol.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-09-01.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

protocol GameRulesProtocol {
    var gridSize: UInt { get }
    func nextMoveForItem(at coordinate: GridCoordinate) -> CoordinateUpdate
    func evaluateRoundResult(firstItemUpdate: CoordinateUpdate, secondItemUpdate: CoordinateUpdate) -> TokenChaseGameRoundResult?
    func resetTokenAndPrepareNewRoundFor(firstItemInitialCoordinate: GridCoordinate, secondItemInitialCoordinate: GridCoordinate) -> CoordinateUpdate
}
