//
//  TokenChaseGameGridItemProtocol.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-31.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

protocol TokenChaseGameGridItemProtocol {
    func updateAlreadyVisitedState(to visitedState: Bool)
    func updateIsTokenState(to isTokenState: Bool)
}
