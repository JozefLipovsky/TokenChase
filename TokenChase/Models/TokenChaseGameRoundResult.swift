//
//  TokenChaseGameRoundResult.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-31.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

enum TokenChaseGameRoundResult {
    case stalemate
    case win(firstItemDidWin: Bool, secondItemDidWin: Bool)
}

extension TokenChaseGameRoundResult: Equatable {
    static public func ==(lhs: TokenChaseGameRoundResult, rhs: TokenChaseGameRoundResult) -> Bool {
        switch (lhs, rhs) {
        case (.stalemate, .stalemate):
            return true
            
        case let(.win(firstItemWinLHS, secondItemDidWinLHS), .win(firstItemWinRHS, secondItemDidWinRHS)):
            return firstItemWinLHS == firstItemWinRHS && secondItemDidWinLHS == secondItemDidWinRHS

        default:
            return false
        }
    }
}
