//
//  CalendarTrainingCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class CalendarTrainingCell: UITableViewCell {
    
    let dayOfWeekLabel = FLabel(fontSize: 15, weight: .light, color: .black, message: "Не указано")
    
    let numberOfDayLabel = FLabel(fontSize: 15, weight: .light, color: .gray, message: "Не указано")
    
    let monthLabel = FLabel(fontSize: 15, weight: .light, color: .gray, message: "Не указано")
    
    let descriptionLabel = FLabel(fontSize: 13, weight: .light, color: .black, message: "Не указано")
    
    let circleView = FCircleView(x: 20, y: 13, size: 13, color: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1))
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        configureCircleView()
        configureDayOfWeekLabel()
        configureNumberOfDayLabel()
        configureMonthLabel()
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
    
    private func configureNumberOfDayLabel() {
        addSubview(numberOfDayLabel)
        numberOfDayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        numberOfDayLabel.leadingAnchor.constraint(equalTo: dayOfWeekLabel.trailingAnchor, constant: 10).isActive = true
    }
    
    private func configureMonthLabel() {
        addSubview(monthLabel)
        monthLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        monthLabel.leadingAnchor.constraint(equalTo: numberOfDayLabel.trailingAnchor, constant: 4).isActive = true
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: dayOfWeekLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        descriptionLabel.numberOfLines = 2
    }
}
