//
//  CheckmarkButton.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FCheckmarkButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.8940489888, green: 0.8941563964, blue: 0.8940123916, alpha: 1)
        
        let symbol = UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(weight: .light))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        setImage(symbol, for: .normal)
    }
    
}
