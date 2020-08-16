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
            daysLeftLabel.text = "\(data.daysLeft) дней"
            countVisitLabel.text = "\(data.countVisit) занятий"
            contentView.backgroundColor = ColorConverter.shared.stringToColor(string: data.color)
        }
    }
    
    let abonementNameLabel = FLabel(fontSize: 15, weight: .bold, color: .white, message: "")
    let daysLeftLabel = FLabel(fontSize: 12, weight: .light, color: .white, message: "")
    let costLabel = FLabel(fontSize: 12, weight: .light, color: .white, message: "")
    let countVisitLabel = FLabel(fontSize: 12, weight: .light, color: .white, message: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 10
        
        configureAbonementNameLabel()
        configureDaysLeftLabel()
        configureCostLabel()
        configureCountVisit()
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
        costLabel.bottomAnchor.constraint(equalTo: daysLeftLabel.topAnchor, constant: -10).isActive = true
        costLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        costLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        costLabel.textColor = .white
        costLabel.numberOfLines = 1
        costLabel.adjustsFontSizeToFitWidth = true
        costLabel.minimumScaleFactor = 0.5
    }
    
    private func configureCountVisit() {
        contentView.addSubview(countVisitLabel)
        countVisitLabel.bottomAnchor.constraint(equalTo: costLabel.topAnchor, constant: -10).isActive = true
        countVisitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        countVisitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    
}
