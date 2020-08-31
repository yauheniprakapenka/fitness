//
//  NewRegistrationViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 15.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let backgroundImageView = UIImageView()
    
    let lastnameLabel = FLabel(fontSize: 14, weight: .regular, color: .white, message: "Фамилия")
    let lastnameTextField = FTextField(placeholderText: "Введите фамилию", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    
    let firstnameLabel = FLabel(fontSize: 14, weight: .regular, color: .white, message: "Имя")
    let firstnameTextField = FTextField(placeholderText: "Введите имя", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    
    let emailLabel = FLabel(fontSize: 14, weight: .regular, color: .white, message: "email")
    let emailTextField = FTextField(placeholderText: "Введите email", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    
    let passwordLabel = FLabel(fontSize: 14, weight: .regular, color: .white, message: "Пароль")
    let passwordTextField = FTextField(placeholderText: "Введите пароль", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    
    let trainerContainerView = UIView()
    let athleteContainerView = UIView()
    
    var currentRole: RoleEnum = .athlete
    
    let trainerVioletCircle = UIView()
    let athleteVioletCircle = UIView()
    
    let continueButton = FButtonWithBackgroundColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Создать профиль", size: 18)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureBackgroundImageView()
        configureNavigation()
        
        configureLastnameLabel()
        configurelastnameTextField()
        
        configureFirstnameLabel()
        configureFirstnameTextField()
        
        configureEmailLabel()
        configureEmailTextField()
        
        configurePasswordLabel()
        configurePasswordTextField()
        
        configureTrainerContainerView()
        configureAthleteContainerView()
        
        configureGesture()
        
        configureContinueButton()
        
        configureVioletCircle()
        
        // Test Data
        firstnameTextField.text = "Mickey"
        lastnameTextField.text = "Mouse"
        emailTextField.text = "mickey@mouse.com"
        passwordTextField.text = "123456"
    }
    
    private func configureBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = #imageLiteral(resourceName: "login_back_2")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.85
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        navigationItem.title = "Новый аккаунт"
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let cancelButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(cancelNavigationButtonTapped))
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func configureLastnameLabel() {
        view.addSubview(lastnameLabel)
        lastnameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastnameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        lastnameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        lastnameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configurelastnameTextField() {
        view.addSubview(lastnameTextField)
        lastnameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastnameTextField.topAnchor.constraint(equalTo: lastnameLabel.bottomAnchor, constant: 10).isActive = true
        lastnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        lastnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        lastnameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureFirstnameLabel() {
        view.addSubview(firstnameLabel)
        firstnameLabel.translatesAutoresizingMaskIntoConstraints = false
        firstnameLabel.topAnchor.constraint(equalTo: lastnameTextField.bottomAnchor, constant: 40).isActive = true
        firstnameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        firstnameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureFirstnameTextField() {
        view.addSubview(firstnameTextField)
        firstnameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstnameTextField.topAnchor.constraint(equalTo: firstnameLabel.bottomAnchor, constant: 10).isActive = true
        firstnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        firstnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        firstnameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureEmailLabel() {
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: firstnameTextField.bottomAnchor, constant: 40).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configurePasswordLabel() {
        view.addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configurePasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureContinueButton() {
        view.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        continueButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc
    func registerButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        
        NetworkManager.shared.registerUser(firstname: firstnameTextField.text ?? "",
                                           lastname: lastnameTextField.text ?? "",
                                           password: passwordTextField.text ?? "",
                                           passwordConfirmation: "1234",
                                           email: emailTextField.text ?? "",
                                           role: .athlete,
                                           phone: "79262001813") { result in
            switch result {
            case .success(let response):
                print(response)
                DispatchQueue.main.async {
                    let alertVC = AlertViewController(question: "Поздравляем!", description: "Вы успешно зарегистрировались в приложении", actionButtonTitle: "Продолжить", cancelButtonTitle: nil, icon: .chevronDownCircle)
                    alertVC.modalPresentationStyle = .overCurrentContext
                    alertVC.modalTransitionStyle = .crossDissolve
                    alertVC.actionButton.addTarget(self, action: #selector(self.alertSuccessButtonTapped), for: .touchUpInside)
                    self.present(alertVC, animated: true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alertVC = AlertViewController(question: "Не удалось подключиться", description: error.rawValue, actionButtonTitle: "Закрыть", cancelButtonTitle: nil, icon: .multiplyCircle)
                    alertVC.modalPresentationStyle = .overCurrentContext
                    alertVC.modalTransitionStyle = .crossDissolve
                    alertVC.actionButton.addTarget(self, action: #selector(self.alertFailureButtonTapped), for: .touchUpInside)
                    self.present(alertVC, animated: true)
                }
            }
        }
    }
    
    @objc
    private func cancelNavigationButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func alertSuccessButtonTapped() {
        dismiss(animated: false)
        
        switch currentRole {
        case .trainer:
            let vc = TrainerViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        case .athlete:
            let vc = AthleteViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    @objc
    private func alertFailureButtonTapped() {
        dismiss(animated: true) {
            
        }
    }
}

// MARK: - Radio button

extension RegisterViewController {
    
    private func configureTrainerContainerView() {
        view.addSubview(trainerContainerView)
        trainerContainerView.isUserInteractionEnabled = true
        trainerContainerView.translatesAutoresizingMaskIntoConstraints = false
        trainerContainerView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40).isActive = true
        trainerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        trainerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        trainerContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let whiteShape = UIView()
        trainerContainerView.addSubview(whiteShape)
        whiteShape.translatesAutoresizingMaskIntoConstraints = false
        whiteShape.layer.cornerRadius = 12
        whiteShape.clipsToBounds = true
        whiteShape.backgroundColor = .white
        
        whiteShape.leadingAnchor.constraint(equalTo: trainerContainerView.leadingAnchor).isActive = true
        whiteShape.centerYAnchor.constraint(equalTo: trainerContainerView.centerYAnchor).isActive = true
        whiteShape.heightAnchor.constraint(equalToConstant: 24).isActive = true
        whiteShape.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        let roleLabel = FLabel(fontSize: 16, weight: .medium, color: .white, message: "Я тренер")
        trainerContainerView.addSubview(roleLabel)
        roleLabel.leadingAnchor.constraint(equalTo: whiteShape.trailingAnchor, constant: 10).isActive = true
        roleLabel.centerYAnchor.constraint(equalTo: trainerContainerView.centerYAnchor).isActive = true
        
        whiteShape.addSubview(trainerVioletCircle)
        trainerVioletCircle.translatesAutoresizingMaskIntoConstraints = false
        trainerVioletCircle.layer.cornerRadius = 8
        trainerVioletCircle.clipsToBounds = true
        trainerVioletCircle.backgroundColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        
        trainerVioletCircle.centerXAnchor.constraint(equalTo: whiteShape.centerXAnchor).isActive = true
        trainerVioletCircle.centerYAnchor.constraint(equalTo: whiteShape.centerYAnchor).isActive = true
        trainerVioletCircle.heightAnchor.constraint(equalToConstant: 16).isActive = true
        trainerVioletCircle.widthAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    private func configureAthleteContainerView() {
        view.addSubview(athleteContainerView)
        athleteContainerView.isUserInteractionEnabled = true
        athleteContainerView.translatesAutoresizingMaskIntoConstraints = false
        athleteContainerView.topAnchor.constraint(equalTo: trainerContainerView.bottomAnchor, constant: 4).isActive = true
        athleteContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        athleteContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        athleteContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let whiteShape = UIView()
        athleteContainerView.addSubview(whiteShape)
        whiteShape.translatesAutoresizingMaskIntoConstraints = false
        whiteShape.layer.cornerRadius = 12
        whiteShape.clipsToBounds = true
        whiteShape.backgroundColor = .white
        
        whiteShape.leadingAnchor.constraint(equalTo: athleteContainerView.leadingAnchor).isActive = true
        whiteShape.centerYAnchor.constraint(equalTo: athleteContainerView.centerYAnchor).isActive = true
        whiteShape.heightAnchor.constraint(equalToConstant: 24).isActive = true
        whiteShape.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        let roleLabel = FLabel(fontSize: 16, weight: .medium, color: .white, message: "Я атлет")
        athleteContainerView.addSubview(roleLabel)
        roleLabel.leadingAnchor.constraint(equalTo: whiteShape.trailingAnchor, constant: 10).isActive = true
        roleLabel.centerYAnchor.constraint(equalTo: athleteContainerView.centerYAnchor).isActive = true
        
        whiteShape.addSubview(athleteVioletCircle)
        athleteVioletCircle.translatesAutoresizingMaskIntoConstraints = false
        athleteVioletCircle.layer.cornerRadius = 8
        athleteVioletCircle.clipsToBounds = true
        athleteVioletCircle.backgroundColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        
        athleteVioletCircle.centerXAnchor.constraint(equalTo: whiteShape.centerXAnchor).isActive = true
        athleteVioletCircle.centerYAnchor.constraint(equalTo: whiteShape.centerYAnchor).isActive = true
        athleteVioletCircle.heightAnchor.constraint(equalToConstant: 16).isActive = true
        athleteVioletCircle.widthAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    @objc
    private func trainerContainerViewTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        currentRole = .trainer
        configureVioletCircle()
    }
    
    @objc
    private func athleteContainerViewTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        currentRole = .athlete
        configureVioletCircle()
    }
    
    private func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(athleteContainerViewTapped))
        athleteContainerView.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(trainerContainerViewTapped))
        trainerContainerView.addGestureRecognizer(tap2)
    }
    
    private func configureVioletCircle() {
        athleteVioletCircle.alpha = 0
        trainerVioletCircle.alpha = 0
        
        switch currentRole {
        case .trainer:
            trainerVioletCircle.alpha = 1
        case .athlete:
            athleteVioletCircle.alpha = 1
        }
    }
}
