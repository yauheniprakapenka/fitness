//
//  FViewAddTraining.swift
//  fitnes
//
//  Created by yauheni prakapenka on 18.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FViewBlankPlace: UIView {
    
    let addPlaceLabel = UILabel()
    let backgroundImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 12)//CGSize.zero
        layer.shadowRadius = 4
        
        configureBackgroundImageView()
        configureAddPlaceButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAddPlaceButton() {
        addSubview(addPlaceLabel)
        addPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        addPlaceLabel.text = "Добавьте место\nпроведения ваших тренировок"
        addPlaceLabel.textColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        addPlaceLabel.backgroundColor = .white
        addPlaceLabel.numberOfLines = 2
        addPlaceLabel.textAlignment = .center
        
        addPlaceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        addPlaceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    private func configureBackgroundImageView() {
        addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = #imageLiteral(resourceName: "city-black-and-white")
        backgroundImageView.clipsToBounds = true
        backgroundImageView.alpha = 0.3
        
        backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
}
