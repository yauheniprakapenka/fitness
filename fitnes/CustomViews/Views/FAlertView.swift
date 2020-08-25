//
//  FAlertView.swift
//  fitnes
//
//  Created by yauheni prakapenka on 14.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FAlertView: UIView {
    
    private let containerView = UIView()
    
    private let questionLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let stackView = UIStackView()
    
    var actionButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        button.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 2.0
        return button
    }()
    
    var cancelButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        button.layer.borderColor = #colorLiteral(red: 0.8059927225, green: 0.8245008588, blue: 0.9899520278, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 2.0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
        configureAlertView()
        configureQuestionLabel()
        configureDescriptionLabel()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(question: String, description: String, actionButtonTitle: String) {
        super.init(frame: .zero)
        
        configureView()
        configureAlertView()
        configureQuestionLabel()
        configureDescriptionLabel()
        configureStackView()
        
        actionButton.setTitle(actionButtonTitle, for: .normal)
        questionLabel.text = question
        descriptionLabel.text = description
    }
    
    private func configureView() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3469492364)
    }
    
    private func configureAlertView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        containerView.layer.cornerRadius = 10
        
        let padding: CGFloat = 40
        
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: -padding).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 240).isActive = true
    }

    private func configureQuestionLabel() {
        addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.numberOfLines = 2
        questionLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        questionLabel.textAlignment = .center
        questionLabel.textColor = .black
        
        let padding: CGFloat = 20
        
        questionLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding).isActive = true
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .gray
        
        let padding: CGFloat = 20
        
        descriptionLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding).isActive = true
    }
    
    private func configureStackView() {
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.addArrangedSubview(actionButton)
        stackView.addArrangedSubview(cancelButton)
        
        stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 35).isActive = true
        stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
