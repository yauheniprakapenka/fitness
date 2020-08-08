//
//  CalendarTrainingCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class CalendarTrainingCell: UITableViewCell {
    
    let dayOfWeekLabel = FLabel(textAligment: .left, fontSize: 15, weight: .light, color: .black, message: "Не указано")
    
    let numberAndMonthLabel = FLabel(textAligment: .left, fontSize: 15, weight: .light, color: .gray, message: "Не указано")
    
    let descriptionLabel = FLabel(textAligment: .left, fontSize: 13, weight: .light, color: .gray, message: "Не указано")
    
    let circleView = FCircleView(x: 20, y: 13, size: 13, color: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1))
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        configureCircleView()
        configureDayOfWeekLabel()
        configureNumberAndMonthLabel()
        configureDescriptionLabel()
    }
    
    private func configureCircleView() {
        addSubview(circleView)
    }
    
    private func configureDayOfWeekLabel() {
        addSubview(dayOfWeekLabel)
        dayOfWeekLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        dayOfWeekLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
    }
    
    private func configureNumberAndMonthLabel() {
        addSubview(numberAndMonthLabel)
        numberAndMonthLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        numberAndMonthLabel.leadingAnchor.constraint(equalTo: dayOfWeekLabel.trailingAnchor, constant: 10).isActive = true
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: dayOfWeekLabel.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
        descriptionLabel.numberOfLines = 2
    }
}
