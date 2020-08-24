//
//  TrainingPlaceView.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FViewContentPlace: UIView {
    
    private let titleLabel = FLabel(fontSize: 11, weight: .medium, color: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), message: "МЕСТО ТРЕНИРОВОК")
    private let seeOnMapLabel = FLabel(fontSize: 11, weight: .medium, color: #colorLiteral(red: 0.5999526381, green: 0.6000268459, blue: 0.5999273658, alpha: 1), message: "СМОТРЕТЬ НА КАРТЕ")

    let placeImageView = UIImageView()
    let addressLabel = FLabel(fontSize: 15, weight: .regular, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), message: "Не указано")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureTrainingPlaceImageView()
        configureTitleLabel()
        configureTrainingPlaceLabel()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 1)//CGSize.zero
        layer.shadowRadius = 4
    }
    
    private func configureTrainingPlaceImageView() {
        addSubview(placeImageView)
        
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        placeImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        placeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        placeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        placeImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2.5).isActive = true
        
        placeImageView.contentMode = .scaleAspectFill
        placeImageView.clipsToBounds = true
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: 20).isActive = true
    }
    
    private func configureTrainingPlaceLabel() {
        addSubview(addressLabel)
        addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: 20).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        addressLabel.numberOfLines = 3
    }

    private func configureLabel() {
        addSubview(seeOnMapLabel)
        seeOnMapLabel.translatesAutoresizingMaskIntoConstraints = false
        
        seeOnMapLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        seeOnMapLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: 20).isActive = true
        seeOnMapLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }

}
