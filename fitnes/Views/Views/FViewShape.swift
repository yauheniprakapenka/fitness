//
//  RoundView.swift
//  fitnes
//
//  Created by yauheni prakapenka on 30.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FViewShape: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(x: Int, y: Int, size: Int, color: UIColor) {
        super.init(frame: CGRect(x: x, y: y, width: size, height: size))
        backgroundColor = color
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = self.frame.size.width / 2
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
    }
}
