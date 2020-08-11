//
//  ProgrammView.swift
//  fitnes
//
//  Created by yauheni prakapenka on 29.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FViewItem: UIView {
    
    let countLabel = FLabel(fontSize: 17, weight: .bold, color: .black, message: "")
    let messageLabel = FLabel(fontSize: 13, weight: .regular, color: .black, message: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(message: String, count: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        countLabel.text = count
        configure()
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: self.topAnchor),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 17),
            
            messageLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            messageLabel.heightAnchor.constraint(equalToConstant: 13)
        ])
    }
}
