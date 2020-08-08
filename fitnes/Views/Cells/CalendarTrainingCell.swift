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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        configureDayOfWeekLabel()
        configureNumberAndMonthLabel()
        configureDescriptionLabel()
    }
    
    private func configureDayOfWeekLabel() {
        addSubview(dayOfWeekLabel)
        dayOfWeekLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        dayOfWeekLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureNumberAndMonthLabel() {
        addSubview(numberAndMonthLabel)
        numberAndMonthLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        numberAndMonthLabel.leadingAnchor.constraint(equalTo: dayOfWeekLabel.trailingAnchor, constant: 10).isActive = true
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: dayOfWeekLabel.bottomAnchor, constant: 30).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.numberOfLines = 2
    }
}
