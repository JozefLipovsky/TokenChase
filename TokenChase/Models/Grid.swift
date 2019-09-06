//
//  Grid.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-24.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

class Grid<T: GridItemProtocol> {
    private(set) var items:[[T]]
    
    init() {
        self.items = []
    }
    
    init(items: [[T]]) {
        self.items = items
    }
    
    func append(item: T, toRow row: Int) {
        if items.count <= row {
            items.append([])
        }
        
        items[row].append(item)
    }
    
    func item(at coordinate: GridCoordinate) -> T? {
        guard items.count - 1 >= coordinate.intX else {
            return nil
        }
        
        let rowItems = items[coordinate.intX]
        guard rowItems.count - 1 >= coordinate.intY else {
            return nil
        }
        
        return rowItems[coordinate.intY]
    }
    
    func resetItemsToDefaultState() {
        for (_, items) in items.enumerated() {
            for item in items {
                item.resetStateToDefault()
            }
        }
    }
}
