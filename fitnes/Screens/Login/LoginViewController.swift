//
//  NewLoginViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 15.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let backgroundImageView = UIImageView()
    
    let startLabel = FLabel(fontSize: 34, weight: .light, color: .white, message: "Начнём")
    let signinLabel = FLabel(fontSize: 20, weight: .light, color: .white, message: "Войдите для начала занятий")
    
    let emailLabel = FLabel(fontSize: 14, weight: .regular, color: .white, message: "Email")
    let emailTextField = FTextField(placeholderText: "Введите email", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    
    let passwordLabel = FLabel(fontSize: 14, weight: .regular, color: .white, message: "Пароль")
    let passwordTextField = FTextField(placeholderText: "Введите пароль", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    
    let trainerContainerView = UIView()
    let athleteContainerView = UIView()
    
    var currentRole: RoleEnum = .Trainer
    
    let trainerVioletCircle = UIView()
    let athleteVioletCircle = UIView()
    
    let continueButton = FButtonWithBackgroundColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Войти", size: 18)
    
    let createNewAccountButton = FButtonSimple(title: "Создать новый аккаунт", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 18)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureBackgroundImageView()
        
        configureStartLabel()
        configureSigninLabel()
        
        configureEmailLabel()
        configureEmailTextField()
        
        configurePasswordLabel()
        configurePasswordTextField()
        
        configureTrainerContainerView()
        configureAthleteContainerView()
        
        configureGesture()
        
        configureVioletCircle()
        
        configureContinueButton()
        configureCreateNewAccountButton()
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
    
    private func configureStartLabel() {
        view.addSubview(startLabel)
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        
        startLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        startLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureSigninLabel() {
        view.addSubview(signinLabel)
        signinLabel.translatesAutoresizingMaskIntoConstraints = false
        
        signinLabel.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 20).isActive = true
        signinLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureEmailLabel() {
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: signinLabel.bottomAnchor, constant: 40).isActive = true
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
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    private func configureCreateNewAccountButton() {
        view.addSubview(createNewAccountButton)
        createNewAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createNewAccountButton.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -60).isActive = true
        createNewAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        createNewAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        createNewAccountButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        createNewAccountButton.addTarget(self, action: #selector(createNewAccountButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func continueButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        
        switch currentRole {
        case .Trainer:
            let vc = TrainerViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        case .Athlete:
            let vc = AthleteViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
        
        //        AuthService.shared.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result) in
        //            switch result {
        //            case .success(let user):
        //                profileInfoModel.email = user.email ?? ""
        //                profileInfoModel.uid = user.uid
        //
        //                FirestoreService.shared.fetchProfile() {
        //                    switch ConverterRoleToEnum.shared.roleToEnum(role: profileInfoModel.role) {
        //                    case .Trainer:
        //
        //                        let vc = TrainerViewController()
        //                        vc.modalPresentationStyle = .fullScreen
        //                        self.present(vc, animated: true)
        //                    case .Athlete:
        //                        let vc = AthleteViewController()
        //                        vc.modalPresentationStyle = .fullScreen
        //                        self.present(vc, animated: true)
        //                    case .none:
        //                        break
        //                    }
        //                }
        //
        //            case .failure(let error):
        //                self.showAlert(title: "Что-то пошло не так", message: error.localizedDescription)
        //            }
        //        }
    }
    
    @objc
    func createNewAccountButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        
        let nav = UINavigationController(rootViewController: RegisterViewController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    
}


// MARK: - Radio button

extension LoginViewController {

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
        currentRole = .Trainer
        configureVioletCircle()
    }
    
    @objc
    private func athleteContainerViewTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        currentRole = .Athlete
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
        case .Trainer:
            trainerVioletCircle.alpha = 1
        case .Athlete:
            athleteVioletCircle.alpha = 1
        }
    }
}
