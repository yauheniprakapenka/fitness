//
//  MyAbonementsCollectionCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 07.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class AbonementsCollectionCell: UICollectionViewCell {
    
    var data: AbonementModel? {
        didSet {
            guard let data = data else { return }
            abonementNameLabel.text = data.abonementName
            costLabel.text = "Стоимость \(data.cost) бел руб"
            daysLeftLabel.text = "Истекает через \(data.daysLeft) дней"
            contentView.backgroundColor = makeAbonementColor(color: data.color)
        }
    }
    
    let abonementNameLabel = FLabel(fontSize: 15, weight: .bold, color: .white, message: "")
    let costLabel = FLabel(fontSize: 15, weight: .semibold, color: .white, message: "")
    let daysLeftLabel = FLabel(fontSize: 12, weight: .light, color: .white, message: "")
    let Label = FLabel(fontSize: 12, weight: .light, color: .white, message: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 10
        
        configureAbonementNameLabel()
        configureDaysLeftLabel()
        configureCostLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAbonementNameLabel() {
        contentView.addSubview(abonementNameLabel)
        abonementNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        abonementNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        abonementNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        abonementNameLabel.numberOfLines = 3
        abonementNameLabel.textColor = .white
    }
    
    private func configureDaysLeftLabel() {
        contentView.addSubview(daysLeftLabel)
        daysLeftLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        daysLeftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        daysLeftLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        daysLeftLabel.numberOfLines = 2
    }
    
    private func configureCostLabel() {
        contentView.addSubview(costLabel)
        costLabel.bottomAnchor.constraint(equalTo: daysLeftLabel.topAnchor, constant: -5).isActive = true
        costLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        costLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        costLabel.textColor = .white
        costLabel.numberOfLines = 1
        costLabel.adjustsFontSizeToFitWidth = true
        costLabel.minimumScaleFactor = 0.5
    }
    
    private func makeAbonementColor(color: String) -> UIColor {
        var currentColor: UIColor!
        
        switch color {
        case "blue":
            currentColor = #colorLiteral(red: 0.3045426607, green: 0.6667945385, blue: 0.9780504107, alpha: 1)
        case "pink":
            currentColor = #colorLiteral(red: 1, green: 0.5700934529, blue: 0.6348041892, alpha: 1)
        case "orange":
            currentColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        default:
            currentColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
        
        return currentColor
    }
}
