//
//  Player.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-25.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

class Player: PlayerProtocol {
    var currentCoordinate: GridCoordinate
    var score: Int
    
    init(currentCoordinate: GridCoordinate, score: Int) {
        self.currentCoordinate = currentCoordinate
        self.score = score
    }
}
