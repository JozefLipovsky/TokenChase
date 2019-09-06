//
//  TokenChaseGameGrid.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-09-01.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

class TokenChaseGameGrid: Grid<TokenChaseGameGridItem> {
    private(set) var gridSize: GridSize
    
    init(gridSize: GridSize) {
        self.gridSize = gridSize
        super.init(items: TokenChaseGameGrid.itemsGrid(ofSize: gridSize))
    }
}

extension TokenChaseGameGrid {
    static func itemsGrid(ofSize gridSize: GridSize) -> [[TokenChaseGameGridItem]] {
        let grid = Grid<TokenChaseGameGridItem>()
        for row in 0..<gridSize.rawValue {
            for column in 0..<gridSize.rawValue {
                let gridItem = TokenChaseGameGridItem(coordinate: GridCoordinate(x: UInt(row), y: UInt(column)), gridSize: gridSize)
                grid.append(item: gridItem, toRow: Int(row))
            }
        }
        
        return grid.items
    }
}
