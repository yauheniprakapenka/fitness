//
//  NewAlertVC.swift
//  fitnes
//
//  Created by yauheni prakapenka on 25.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let alertView = UIView()
    private let questionLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let iconImageView = UIImageView()
    
    private let verticalStackView = UIStackView()
    private let buttonsStackView = UIStackView()
    
    // MARK: - Public properties
    
    var actionButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        
        return button
    }()
    
    var cancelButton = UIButton()
    
    // MARK: - Initializers
    
    init(question: String, description: String, actionButtonTitle: String?, cancelButtonTitle: String?, icon: IconImageEnum) {
        super.init(nibName: nil, bundle: nil)
        
        questionLabel.text = question
        descriptionLabel.text = description
        
        configureAlertView()
        configureVerticalStackView()
        
        configureIconImageView(icon: icon)
        configureQuestionLabel()
        configureDescriptionLabel()
        
        configureCancelButton()
        
        configureButtonsStackView(actionButtonTitle: actionButtonTitle, cancelButtonTitle: cancelButtonTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    // MARK: - Actions
    
    @objc
    private func cancelButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - Private methods

private extension AlertViewController {
    
    func configureButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        button.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 2.0
        
        return button
    }
    
    func configureCancelButton() {
        cancelButton = configureButton()
        cancelButton.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        cancelButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        cancelButton.layer.borderColor = #colorLiteral(red: 0.8059927225, green: 0.8245008588, blue: 0.9899520278, alpha: 1)
        cancelButton.layer.borderWidth = 1
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    func configureAlertView() {
        view.addSubview(alertView)
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
    
    func configureVerticalStackView() {
        alertView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 2
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 16),
            verticalStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 8),
            verticalStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -8),
            verticalStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -16)
        ])
    }
    
    func configureIconImageView(icon: IconImageEnum) {
        verticalStackView.addArrangedSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let checkmarkImage = UIImage(systemName: icon.rawValue)?.withTintColor(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), renderingMode: .alwaysOriginal)
        iconImageView.image = checkmarkImage
        iconImageView.contentMode = .scaleAspectFit
    }
    
    func configureQuestionLabel() {
        verticalStackView.addArrangedSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.numberOfLines = 2
        questionLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        questionLabel.textAlignment = .center
        questionLabel.textColor = .black
    }
    
    func configureDescriptionLabel() {
        verticalStackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .gray
    }
    
    func configureButtonsStackView(actionButtonTitle: String?, cancelButtonTitle: String?) {
        verticalStackView.addArrangedSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 20
        
        if let actionButtonTitle = actionButtonTitle {
            actionButton.setTitle(actionButtonTitle, for: .normal)
            buttonsStackView.addArrangedSubview(actionButton)
        }
        
        if let cancelButtonTitle = cancelButtonTitle {
            cancelButton.setTitle(cancelButtonTitle, for: .normal)
            buttonsStackView.addArrangedSubview(cancelButton)
        }
    }
}
