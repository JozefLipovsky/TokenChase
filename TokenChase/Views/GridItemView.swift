//
//  GridItemView.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-24.
//  Copyright © 2019 JoLi. All rights reserved.
//

import UIKit

class GridItemView: UIView {
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        resetStateToDefault()
        layer.cornerRadius = 10
    }
    
    func updateState(withColor color: UIColor) {
        backgroundColor = color
    }
}

extension GridItemView: GridItemProtocol {
    func resetStateToDefault() {
        backgroundColor = .lightGray
    }
}
