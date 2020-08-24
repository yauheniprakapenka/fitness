//
//  FAlertView.swift
//  fitnes
//
//  Created by yauheni prakapenka on 14.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FAlertView: UIView {
    
    let alertContainerView = UIView()
    let stackView = UIStackView()
    let cancelButton = UIButton()
    let confirmButton = UIButton()
    let backgroundImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureBackgroundImageView()
        configureButtons()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundImage: UIImage, confirmButtonText: String) {
        super.init(frame: .zero)
        
        backgroundImageView.image = backgroundImage
        confirmButton.setTitle(confirmButtonText, for: .normal)
        
        configureView()
        configureBackgroundImageView()
        configureButtons()
        configureStackView()
    }
    
    private func configureView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureBackgroundImageView() {
        addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    private func configureButtons() {
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
                
        confirmButton.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(confirmButton)
        
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
