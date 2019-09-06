//
//  GameTimerProtocol.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-27.
//  Copyright © 2019 JoLi. All rights reserved.
//

import Foundation

typealias TimerBlock = () -> Void

protocol GameTimerProtocol {
    func start()
    func stop()
    func scheduledTimer(withBlock block: @escaping TimerBlock)
}
