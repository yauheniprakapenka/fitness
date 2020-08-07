//
//  MyAbonementsCollectionCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 07.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class MyAbonementsCollectionCell: UICollectionViewCell {
    
    var data: AbonementModel? {
        didSet {
            guard let data = data else { return }
            abonementLabel.text = data.name
            costLabel.text = data.cost
            contentView.backgroundColor = makeAbonementColor(color: data.color)
        }
    }
    
    private func makeAbonementColor(color: String) -> UIColor {
        var currentColor: UIColor!
        
        switch color {
        case "blue":
            currentColor = #colorLiteral(red: 0.3045426607, green: 0.6667945385, blue: 0.9780504107, alpha: 1)
        case "pink":
            currentColor = #colorLiteral(red: 1, green: 0.5700934529, blue: 0.6348041892, alpha: 1)
        default:
            currentColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
        
        return currentColor
    }
    
    let abonementLabel = FLabel(textAligment: .left, fontSize: 15, weight: .regular, color: .white, message: "")
    let costLabel = FLabel(textAligment: .left, fontSize: 22, weight: .semibold, color: .black, message: "")
    var status = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        contentView.addSubview(abonementLabel)
        contentView.addSubview(costLabel)
        
        abonementLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        abonementLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        abonementLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        costLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        costLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    }
    
    private func configureUI() {
        abonementLabel.numberOfLines = 3
        abonementLabel.textColor = .white
        costLabel.textColor = .white
        contentView.backgroundColor = .systemPink
        
        if status == "pink" {
            print("pink")
        } else {
            print("123")
        }
        
        
        contentView.layer.cornerRadius = 10
    }
}
