//
//  PlayerProtocol.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-09-02.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

protocol PlayerProtocol {
    var currentCoordinate: GridCoordinate { get set }
    var score: Int { get set }
}
