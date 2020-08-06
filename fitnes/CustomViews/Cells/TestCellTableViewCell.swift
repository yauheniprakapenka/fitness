//
//  TestCellTableViewCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class TestCellTableViewCell: UITableViewCell {
    
    private var isCheckmarked = false
    
    let checkmarkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.8940489888, green: 0.8941563964, blue: 0.8940123916, alpha: 1)
        
        let symbol = UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(weight: .light))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        button.setImage(symbol, for: .normal)
        
        return button
    }()
    
    let nameLabel = FTitleLabel(textAligment: .left, fontSize: 15, weight: .regular, color: .black, message: "")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
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
        
        if isCheckmarked {
            checkmarkButton.backgroundColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        } else {
            checkmarkButton.backgroundColor = .white
        }
    }
    
}
