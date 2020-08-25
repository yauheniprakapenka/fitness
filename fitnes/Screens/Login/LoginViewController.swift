//
//  NewLoginViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 15.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

private extension LoginViewController {
    enum Const {
        static let leftRightMargins: CGFloat = 25
        static let inputBorderColor = UIColor(named: "loginScreenInputFieldBorder")!
    }
}

class LoginViewController: UIViewController {
    
    // MARK: - Variables
    
    let backgroundImageView = UIImageView()
    
    let startLabel = FLabel(fontSize: 34, weight: .semibold, color: .white, message: "Начнём")
    let signinLabel = FLabel(fontSize: 20, weight: .light, color: .white, message: "Войдите для начала занятий")
    
    let emailLabel = FLabel(fontSize: 14, weight: .regular, color: .white, message: "Email")
    let emailTextField = RoundedTextField(placeholderText: "Введите email", placeholderColor: .gray)
    
    let passwordLabel = FLabel(fontSize: 14, weight: .regular, color: .white, message: "Пароль")
    let passwordTextField = RoundedTextField(placeholderText: "Введите пароль", placeholderColor: .gray)
    
    let trainerContainerView = UIView()
    let athleteContainerView = UIView()
    
    var currentRole: RoleEnum = .trainer
    
    let trainerVioletCircle = UIView()
    let athleteVioletCircle = UIView()
    
    let continueButton = FButtonWithBackgroundColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Войти", size: 18)
    
    let createNewAccountButton = FButtonSimple(title: "Создать новый аккаунт", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 18)
    let contentScrollView = UIScrollView()
    
    // MARK: - View Controller LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureBackgroundImageView()
        configureRootScrollView()
        configureStartLabel(addTo: contentScrollView)
        configureSigninLabel(addTo: contentScrollView)
        
        configureEmailLabel(addTo: contentScrollView)
        configureEmailTextField(addTo: contentScrollView)
        
        configurePasswordLabel(addTo: contentScrollView)
        configurePasswordTextField(addTo: contentScrollView)
        
        configureTrainerContainerView(addTo: contentScrollView)
        configureAthleteContainerView(addTo: contentScrollView)
        
        configureGesture()
        
        configureVioletCircle()
        
        configureContinueButton(addTo: contentScrollView)
        configureCreateNewAccountButton(addTo: contentScrollView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentScrollView.resizeContentSizeToFitChilds()
    }
    
    // MARK: - Actions
    
    @objc
    func continueButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        
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

        let alertVC = AlertViewController(question: "привет", description: "описание", actionButtonTitle: "кнопка")
        alertVC.modalPresentationStyle = .overCurrentContext
        present(alertVC, animated: true)
    }
    
    @objc
    private func alertCancelButtonTapped() {
        print(#function)
    }
    
    @objc
    private func confirmButtonTapped() {
        print(#function)
    }
    
}

// MARK: - Radio button
private extension LoginViewController {
    
    func configureRootScrollView() {
        view.addSubview(contentScrollView)
        contentScrollView.isScrollEnabled = true
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.constraintAllSidesToSuperview()
    }
    
    func configureBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = #imageLiteral(resourceName: "login_back_2")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.85
        backgroundImageView.constraintAllSidesToSuperview()
    }
    
    func configureStartLabel(addTo view: UIView) {
        view.addSubview(startLabel)
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        
        startLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        startLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargins).isActive = true
    }
    
    func configureSigninLabel(addTo view: UIView) {
        view.addSubview(signinLabel)
        signinLabel.translatesAutoresizingMaskIntoConstraints = false
        
        signinLabel.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 20).isActive = true
        signinLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargins).isActive = true
        signinLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        signinLabel.lineBreakMode = .byWordWrapping
        signinLabel.numberOfLines = 0
    }
    
    func configureEmailLabel(addTo view: UIView) {
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: signinLabel.bottomAnchor, constant: 40).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargins).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.leftRightMargins).isActive = true
    }
    
    func configureEmailTextField(addTo view: UIView) {
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargins).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Const.leftRightMargins * 2).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.backgroundColor = .white
        emailTextField.borderColor = Const.inputBorderColor
    }
    
    func configurePasswordLabel(addTo view: UIView) {
        view.addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargins).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.leftRightMargins).isActive = true
    }
    
    func configurePasswordTextField(addTo view: UIView) {
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargins).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Const.leftRightMargins * 2).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.backgroundColor = .white
        passwordTextField.borderColor = Const.inputBorderColor
    }
    
    func configureContinueButton(addTo view: UIView) {
        view.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.topAnchor.constraint(equalTo: athleteContainerView.bottomAnchor, constant: 20).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargins).isActive = true
        continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Const.leftRightMargins * 2).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        continueButton.cornerRadius = 5
    }
    
    func configureCreateNewAccountButton(addTo view: UIView) {
        view.addSubview(createNewAccountButton)
        createNewAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createNewAccountButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20).isActive = true
        createNewAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargins).isActive = true
        createNewAccountButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Const.leftRightMargins * 2).isActive = true
        createNewAccountButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        createNewAccountButton.addTarget(self, action: #selector(createNewAccountButtonTapped), for: .touchUpInside)
    }

    func configureTrainerContainerView(addTo view: UIView) {
        view.addSubview(trainerContainerView)
        trainerContainerView.isUserInteractionEnabled = true
        trainerContainerView.translatesAutoresizingMaskIntoConstraints = false
        trainerContainerView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25).isActive = true
        trainerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargins).isActive = true
        trainerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.leftRightMargins).isActive = true
        trainerContainerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
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
    
    func configureAthleteContainerView(addTo view: UIView) {
        view.addSubview(athleteContainerView)
        athleteContainerView.isUserInteractionEnabled = true
        athleteContainerView.translatesAutoresizingMaskIntoConstraints = false
        athleteContainerView.topAnchor.constraint(equalTo: trainerContainerView.bottomAnchor, constant: 4).isActive = true
        athleteContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargins).isActive = true
        athleteContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.leftRightMargins).isActive = true
        athleteContainerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
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
    func trainerContainerViewTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        currentRole = .trainer
        configureVioletCircle()
    }
    
    @objc
    func athleteContainerViewTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        currentRole = .athlete
        configureVioletCircle()
    }
    
    func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(athleteContainerViewTapped))
        athleteContainerView.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(trainerContainerViewTapped))
        trainerContainerView.addGestureRecognizer(tap2)
    }
    
    func configureVioletCircle() {
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
