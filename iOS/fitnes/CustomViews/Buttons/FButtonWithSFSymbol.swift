//
//  MoreButton.swift
//  fitnes
//
//  Created by yauheni prakapenka on 07.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FButtonWithSFSymbol: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(sfSymbol: SfSymbolEnum, color: UIColor, size: CGFloat) {
        super.init(frame: .zero)
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: size, weight: .medium, scale: .small)
        let more = UIImage(systemName: sfSymbol.rawValue, withConfiguration: largeConfig)?.withTintColor(color, renderingMode: .alwaysOriginal)
        setImage(more, for: .normal)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
