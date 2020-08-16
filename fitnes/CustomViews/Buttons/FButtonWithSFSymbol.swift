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
    
    init(sfSymbol: String) {
        super.init(frame: .zero)
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium, scale: .small)
        let more = UIImage(systemName: sfSymbol, withConfiguration: largeConfig)?.withTintColor(#colorLiteral(red: 0.3999670744, green: 0.4000185132, blue: 0.3999494314, alpha: 1), renderingMode: .alwaysOriginal)
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
