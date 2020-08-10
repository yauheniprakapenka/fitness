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
    
    let abonementLabel = FLabel(fontSize: 15, weight: .regular, color: .white, message: "")
    let costLabel = FLabel(fontSize: 16, weight: .semibold, color: .white, message: "")
    var status = ""
    
    var abonementTimer = 59
    let timerLabel = FLabel(fontSize: 12, weight: .light, color: .white, message: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        configureUI()
        addAbonementTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        contentView.addSubview(abonementLabel)
        contentView.addSubview(costLabel)
        contentView.addSubview(timerLabel)
        
        abonementLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        abonementLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        abonementLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        timerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        timerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        costLabel.bottomAnchor.constraint(equalTo: timerLabel.topAnchor, constant: -5).isActive = true
        costLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        costLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    private func configureUI() {
        abonementLabel.numberOfLines = 3
        abonementLabel.textColor = .white
        costLabel.textColor = .white
        costLabel.numberOfLines = 1
        costLabel.adjustsFontSizeToFitWidth = true
        costLabel.minimumScaleFactor = 0.5
        
        contentView.layer.cornerRadius = 10
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
            currentColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
        
        return currentColor
    }
    
    private func addAbonementTimer() {
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.abonementTimer == 1 {
                self.abonementTimer = 59
            }
            self.abonementTimer -= 1
            self.timerLabel.text = "4 д 16 мин \(self.abonementTimer) сек"
        })
    }
}
