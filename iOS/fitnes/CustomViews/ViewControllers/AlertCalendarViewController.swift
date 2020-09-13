//
//  AlertCalendarViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 13.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

// MARK: - Constants

private extension AlertCalendarViewController {
    
    enum Const {
        static let screenSize: CGRect = UIScreen.main.bounds
        static let screenHeight: CGFloat = screenSize.height
        
        static let viewColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3451817024)
        
        static let alertLeftRightMargin: CGFloat = 40
        static let alertHeght: CGFloat = 270
        
        static let logoSize: CGFloat = 90
        static let logoTopLeftMargin: CGFloat = -20
        static let logoImage = #imageLiteral(resourceName: "fitnes-illustration")
        
        static let titleLabelMessage = "Укажите время тренировки"
        static let titleLabelColor = #colorLiteral(red: 0.3768857121, green: 0.5291256905, blue: 0.5530951619, alpha: 1)
        static let titleLabelTopMargin: CGFloat = 30
        static let titleLabelLeftRightMargin: CGFloat = 20
        static let titleLabelFontSize: CGFloat = 16
        
        static let descriptionTopMargin: CGFloat = 20
        static let descriptionLeftRigthMargin: CGFloat = 20
        static let descriptionFontSize: CGFloat = 14
        static let descriptionMessage = "Атлеты будут видеть время проведения ваши тренировок"
        
        static let textfieldPlaceholder = "Например, 10:00 - 18:00"
        static let textfieldLeftRightMargin: CGFloat = 20
        static let textFieldTopMargin: CGFloat = 20
        static let textfieldBorderColor: CGColor = #colorLiteral(red: 0.7058702707, green: 0.9068961143, blue: 0.9431461692, alpha: 1)
        static let textfieldTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        static let textfieldPlaceholderColor: UIColor = #colorLiteral(red: 0.80783763, green: 0.80783763, blue: 0.80783763, alpha: 1)
        static let textFieldHeightAnchor: CGFloat = 40
        
        static let stackViewTopMargin: CGFloat = 20
        static let stackViewLeftRightMargin: CGFloat = 20
        static let stackViewHeight: CGFloat = 50
    }
}

class AlertCalendarViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let alertView = UIView()
    private let logoImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let buttonStackView = UIStackView()
    
    // MARK: - Public properties
    
    let dateTextfield = FTextField(placeholderText: Const.textfieldPlaceholder,
                               placeholderColor: Const.textfieldPlaceholderColor)
    
    let actionButton = FButtonWithBackgroundColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1),
                                                  title: "Добавить", size: 16)
    let cancelButton = FButtonWithBackgroundColor(backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                                  title: "Отменить", size: 16)
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureAlertView()
        configureLogoImageView()
        configureTitleLabel()
        configureDescriptionLabel()
        configureTextfield()
        configureBottonStackView()
        configureButtons()
    }
}

// MARK: - Private methods

private extension AlertCalendarViewController {
    
    func configureAlertView() {
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.layer.cornerRadius = 10
        alertView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            alertView.heightAnchor.constraint(equalToConstant: Const.alertHeght),
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.alertLeftRightMargin),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.alertLeftRightMargin),
            alertView.topAnchor.constraint(equalTo: view.topAnchor, constant: Const.screenHeight / 4)
        ])
    }
    
    func configureLogoImageView() {
        alertView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.layer.cornerRadius = Const.logoSize / 2
        logoImageView.clipsToBounds = true
        logoImageView.image = Const.logoImage
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: Const.logoTopLeftMargin),
            logoImageView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: Const.logoTopLeftMargin),
            logoImageView.widthAnchor.constraint(equalToConstant: Const.logoSize),
            logoImageView.heightAnchor.constraint(equalToConstant: Const.logoSize)
        ])
    }
    
    func configureTitleLabel() {
        let titleLabel = UILabel()
        alertView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Const.titleLabelMessage
        titleLabel.textColor = Const.titleLabelColor
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: Const.titleLabelFontSize, weight: .medium)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: Const.titleLabelTopMargin),
            titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Const.titleLabelLeftRightMargin - 10),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -Const.titleLabelLeftRightMargin),
            titleLabel.heightAnchor.constraint(equalToConstant: Const.titleLabelFontSize)
        ])
    }
    
    func configureDescriptionLabel() {
        alertView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 2
        descriptionLabel.text = Const.descriptionMessage
        descriptionLabel.font = UIFont.systemFont(ofSize: Const.descriptionFontSize, weight: .regular)
        descriptionLabel.textColor = Const.titleLabelColor
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Const.descriptionTopMargin),
            descriptionLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: Const.descriptionLeftRigthMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -Const.descriptionLeftRigthMargin)
        ])
    }
    
    func configureTextfield() {
        alertView.addSubview(dateTextfield)
        dateTextfield.layer.borderColor = Const.textfieldBorderColor
        dateTextfield.textColor = Const.textfieldTextColor
        dateTextfield.becomeFirstResponder()
        dateTextfield.delegate = self
        
        NSLayoutConstraint.activate([
            dateTextfield.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Const.textFieldTopMargin),
            dateTextfield.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: Const.textfieldLeftRightMargin),
            dateTextfield.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -Const.textfieldLeftRightMargin),
            dateTextfield.heightAnchor.constraint(equalToConstant: Const.textFieldHeightAnchor)
        ])
    }
    
    func configureBottonStackView() {
        alertView.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 8
        
        buttonStackView.addArrangedSubview(actionButton)
        buttonStackView.addArrangedSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: dateTextfield.bottomAnchor, constant: Const.stackViewTopMargin),
            buttonStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: Const.stackViewLeftRightMargin),
            buttonStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -Const.stackViewLeftRightMargin),
            buttonStackView.heightAnchor.constraint(equalToConstant: Const.stackViewHeight)
        ])
    }
    
    func configureButtons() {
        actionButton.setTitleColor(.white, for: .normal)
        
        cancelButton.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    func configureView() {
        view.backgroundColor = Const.viewColor
    }
}

extension AlertCalendarViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
