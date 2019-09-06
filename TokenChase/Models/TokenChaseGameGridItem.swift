//
//  TokenChaseGameGridItem.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-25.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

class TokenChaseGameGridItem: GridItem {
    private(set) var isToken = false
    private(set) var alreadyVisited = false
    
    override init(coordinate: GridCoordinate, gridSize: GridSize) {
        super.init(coordinate: coordinate, gridSize: gridSize)
    }
}

extension TokenChaseGameGridItem: GridItemProtocol {
    func resetStateToDefault() {
        isToken = false
        alreadyVisited = false
    }
}

extension TokenChaseGameGridItem: TokenChaseGameGridItemProtocol {
    func updateAlreadyVisitedState(to visitedState: Bool) {
        alreadyVisited = visitedState
    }
    
    func updateIsTokenState(to isTokenState: Bool) {
        isToken = isTokenState
    }
}
