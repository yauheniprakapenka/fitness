//
//  TestCellTableViewCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class TitleWithCheckboxCell: UITableViewCell {
    
    private var isCheckmarked = false
    
    let checkmarkButton = FCheckmarkButton()
    
    let nameLabel = FLabel(textAligment: .left, fontSize: 15, weight: .regular, color: .black, message: "")
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureNameLabel()
        configureCheckmarkButton()
    }
    
    private func configureNameLabel() {
        addSubview(nameLabel)
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureCheckmarkButton() {
        addSubview(checkmarkButton)
        checkmarkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        checkmarkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        checkmarkButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        checkmarkButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        checkmarkButton.addTarget(self, action: #selector(checkmarkButtonTapped), for: .touchUpInside)
    }
    
    @objc private func checkmarkButtonTapped() {
        isCheckmarked = !isCheckmarked
        checkmarkButton.backgroundColor = isCheckmarked ? #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1) : .white
    }
    
}
