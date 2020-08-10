//
//  TrainingPlaceView.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class TrainingPlaceView: UIView {
    
    let trainingPlaceImageView = UIImageView()
    let titleLabel = FLabel(fontSize: 11, weight: .medium, color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), message: "МЕСТО ТРЕНИРОВКИ")
    let descriptionPlaceLabel = FLabel(fontSize: 15, weight: .semibold, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), message: "Не указано")
    let mapButton = FButtonWithColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Посмотреть на карте", size: 12)//FSimpleButton(title: "Посмотреть на карте", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 13)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureTrainingPlaceImageView()
        configureTitleLabel()
        configureTrainingPlaceLabel()
        configureMapButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 12)//CGSize.zero
        layer.shadowRadius = 4
    }
    
    private func configureTrainingPlaceImageView() {
        addSubview(trainingPlaceImageView)
        
        trainingPlaceImageView.translatesAutoresizingMaskIntoConstraints = false
        trainingPlaceImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        trainingPlaceImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        trainingPlaceImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        trainingPlaceImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2).isActive = true
        
        trainingPlaceImageView.contentMode = .scaleAspectFill
        trainingPlaceImageView.clipsToBounds = true
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: trainingPlaceImageView.trailingAnchor, constant: 20).isActive = true
    }
    
    private func configureTrainingPlaceLabel() {
        addSubview(descriptionPlaceLabel)
        descriptionPlaceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionPlaceLabel.leadingAnchor.constraint(equalTo: trainingPlaceImageView.trailingAnchor, constant: 20).isActive = true
        descriptionPlaceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        descriptionPlaceLabel.numberOfLines = 3
    }
    
    private func configureMapButton() {
        addSubview(mapButton)
        mapButton.topAnchor.constraint(equalTo: descriptionPlaceLabel.bottomAnchor, constant: 10).isActive = true
        mapButton.leadingAnchor.constraint(equalTo: trainingPlaceImageView.trailingAnchor, constant: 20).isActive = true
        mapButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
}
