//
//  GridItem.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-24.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

class GridItem {
    let coordinate: GridCoordinate
    let topNeighbour: GridCoordinate?
    let bottomNeighbour: GridCoordinate?
    let rightNeighbour: GridCoordinate?
    let leftNeighbour: GridCoordinate?

    init(coordinate: GridCoordinate, gridSize: GridSize) {
        self.coordinate = coordinate
        guard gridSize.rawValue >= 1 else {
            rightNeighbour = nil
            leftNeighbour = nil
            topNeighbour = nil
            bottomNeighbour = nil
            return
        }

        rightNeighbour = coordinate.x < gridSize.rawValue - 1 ? GridCoordinate(x: coordinate.x + 1, y: coordinate.y) : nil
        leftNeighbour = coordinate.x > 0 ? GridCoordinate(x: coordinate.x - 1, y: coordinate.y) : nil
        bottomNeighbour = coordinate.y < gridSize.rawValue - 1 ? GridCoordinate(x: coordinate.x, y: coordinate.y + 1) : nil
        topNeighbour = coordinate.y > 0 ? GridCoordinate(x: coordinate.x, y: coordinate.y - 1) : nil
    }
    
    func availableMoves() -> [GridCoordinate] {
        return [rightNeighbour, leftNeighbour, bottomNeighbour, topNeighbour].compactMap { $0 }
    }
}
