//
//  FActivityIndicator.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FActivityIndicator: UIActivityIndicatorView {
    
    // MARK: - Initializes
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public methods

extension FActivityIndicator {
    
    func startAnimate() {
        self.startAnimating()
    }
    
    func stopAnimate() {
        self.stopAnimating()
    }
}

// MARK: - Private methods

private extension FActivityIndicator {
    
    func configure() {
        self.hidesWhenStopped = true
        self.style = .large
        self.layer.cornerRadius = 10
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6986001131)
        self.color = .white
    }
}
