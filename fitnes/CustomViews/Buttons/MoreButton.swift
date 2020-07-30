//
//  MoreButton.swift
//  fitnes
//
//  Created by yauheni prakapenka on 30.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class MoreButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 34, weight: .medium, scale: .small)
        let more = UIImage(systemName: "ellipsis", withConfiguration: largeConfig)?.withTintColor(#colorLiteral(red: 0.3999670744, green: 0.4000185132, blue: 0.3999494314, alpha: 1), renderingMode: .alwaysOriginal)
        setImage(more, for: .normal)
    }
}
