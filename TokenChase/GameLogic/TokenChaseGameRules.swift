//
//  TokenChaseGameRules.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-29.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

class TokenChaseGameRules: GameRulesProtocol {
    let gridSize: UInt
    private let itemsGrid: TokenChaseGameGrid
    var prizeTokenCoordinate: GridCoordinate
    
    init(grid: TokenChaseGameGrid) {
        self.gridSize = UInt(grid.items.count)
        self.itemsGrid = grid
        self.prizeTokenCoordinate = GridCoordinate(x: UInt.random(in: 0..<gridSize - 1), y: UInt.random(in: 0..<gridSize - 1))
    }
    
    func nextMoveForItem(at coordinate: GridCoordinate) -> CoordinateUpdate {
        let itemUpdate = CoordinateUpdate(previousCoordinate: coordinate, nextCoordinate: nextRandomMove(for: coordinate))
        
        if coordinate != itemUpdate.nextCoordinate {
            itemsGrid.item(at: itemUpdate.nextCoordinate)?.updateAlreadyVisitedState(to: true)
        }
        
        return itemUpdate
    }
    
    func evaluateRoundResult(firstItemUpdate: CoordinateUpdate, secondItemUpdate: CoordinateUpdate) -> TokenChaseGameRoundResult? {
        if firstItemUpdate.nextCoordinate == prizeTokenCoordinate || secondItemUpdate.nextCoordinate == prizeTokenCoordinate {
            itemsGrid.resetItemsToDefaultState()
            return .win(firstItemDidWin: firstItemUpdate.nextCoordinate == prizeTokenCoordinate, secondItemDidWin: secondItemUpdate.nextCoordinate == prizeTokenCoordinate)
            
        } else if firstItemUpdate.previousCoordinate == firstItemUpdate.nextCoordinate && secondItemUpdate.previousCoordinate == secondItemUpdate.nextCoordinate {
            itemsGrid.resetItemsToDefaultState()
            return .stalemate
            
        } else {
            return nil
        }
    }
    
    func resetTokenAndPrepareNewRoundFor(firstItemInitialCoordinate: GridCoordinate, secondItemInitialCoordinate: GridCoordinate) -> CoordinateUpdate {
        itemsGrid.resetItemsToDefaultState()
        
        let tokenUpdate = resetPrizeToken()
        itemsGrid.item(at: firstItemInitialCoordinate)?.updateAlreadyVisitedState(to: true)
        itemsGrid.item(at: secondItemInitialCoordinate)?.updateAlreadyVisitedState(to: true)
        
        return tokenUpdate
    }
    
    // MARK:- Private
    
    private func nextRandomMove(for coordinate: GridCoordinate) -> GridCoordinate {
        var nextMove = coordinate
        
        if let currentPlayerItem = itemsGrid.item(at: coordinate) {
            let availableMoves = currentPlayerItem.availableMoves()
            let validMoves = availableMoves.filter { itemsGrid.item(at: $0)?.alreadyVisited == false }
            if !validMoves.isEmpty {
                let randomMoveIndex = Int.random(in: 0..<validMoves.count)
                nextMove = validMoves[randomMoveIndex]
            }
        }
        
        return nextMove
    }
    
    private func resetPrizeToken() -> CoordinateUpdate {
        let oldTokenCoordinate = prizeTokenCoordinate
        itemsGrid.item(at: prizeTokenCoordinate)?.updateIsTokenState(to: false)
        
        let newTokenCoordinate = GridCoordinate(x: UInt.random(in: 0..<gridSize - 1), y: UInt.random(in: 0..<gridSize - 1))
        itemsGrid.item(at: newTokenCoordinate)?.updateIsTokenState(to: false)
        prizeTokenCoordinate = newTokenCoordinate
        
        return CoordinateUpdate(previousCoordinate: oldTokenCoordinate, nextCoordinate: newTokenCoordinate)
    }
}
