//
//  NewAlertVC.swift
//  fitnes
//
//  Created by yauheni prakapenka on 25.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    // MARK: - Variables
    
    private let alertView = UIView()
    
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
    
    private var cancelButton: UIButton = {
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
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(question: String, description: String, actionButtonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        questionLabel.text = question
        descriptionLabel.text = description
        actionButton.setTitle(actionButtonTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3469492364)
        
        configureAlertView()
        configureQuestionLabel()
        configureDescriptionLabel()
        
        configureStackView()
    }
    
    // MARK: - Private Methods
    
    private func configureAlertView() {
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        alertView.layer.cornerRadius = 10
        
        let padding: CGFloat = 40
        
        alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        alertView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -padding).isActive = true
        alertView.heightAnchor.constraint(equalToConstant: 240).isActive = true
    }
    
    private func configureQuestionLabel() {
        alertView.addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.numberOfLines = 2
        questionLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        questionLabel.textAlignment = .center
        questionLabel.textColor = .black
        
        let padding: CGFloat = 20
        
        questionLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 30).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: padding).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -padding).isActive = true
    }
    
    private func configureDescriptionLabel() {
        alertView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .gray
        
        let padding: CGFloat = 20
        
        descriptionLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: padding).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -padding).isActive = true
    }
    
    private func configureStackView() {
        alertView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.addArrangedSubview(actionButton)
        stackView.addArrangedSubview(cancelButton)
        
        stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 35).isActive = true
        stackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK: - Actions
    
    @objc
    private func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
