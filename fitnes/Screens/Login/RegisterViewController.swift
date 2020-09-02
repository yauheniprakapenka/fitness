//
//  NewRegistrationViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 15.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

private extension RegisterViewController {
    enum Constants {
        static let screenSize: CGRect = UIScreen.main.bounds
        static let screenWidth = screenSize.width
        static let screenHeight = screenSize.height
        
        static let leftMargin: CGFloat = 20
        static let rightMargin: CGFloat = -leftMargin * 2
        static let bottomAnchor: CGFloat = 6
        static let labelHeightAnchor: CGFloat = 14
        static let textfieldHeightAnchor: CGFloat = 50
        static let createButtonBottonAnchor: CGFloat = -60
        
        static let labelFontSize: CGFloat = 14
    }
}

class RegisterViewController: UIViewController {
    var scrollView: UIScrollView!
    
    let lastnameLabel = FLabel(fontSize: Constants.labelFontSize, weight: .regular, color: .white, message: "Фамилия")
    let lastnameTextField = FTextField(placeholderText: "Введите фамилию", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    let firstnameLabel = FLabel(fontSize: Constants.labelFontSize, weight: .regular, color: .white, message: "Имя")
    let firstnameTextField = FTextField(placeholderText: "Введите имя", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    let emailLabel = FLabel(fontSize: Constants.labelFontSize, weight: .regular, color: .white, message: "email")
    let emailTextField = FTextField(placeholderText: "Введите email", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    let phoneLabel = FLabel(fontSize: Constants.labelFontSize, weight: .regular, color: .white, message: "Телефон")
    let phoneTextField = FTextField(placeholderText: "Введите телефон", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    let passwordLabel = FLabel(fontSize: Constants.labelFontSize, weight: .regular, color: .white, message: "Пароль")
    let passwordTextField = FTextField(placeholderText: "Введите пароль", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    let passwordRepeatLabel = FLabel(fontSize: Constants.labelFontSize, weight: .regular, color: .white, message: "Повторите пароль")
    let passwordRepeatTextField = FTextField(placeholderText: "Повторите пароль", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    let createUserButton = FButtonWithBackgroundColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Создать профиль", size: 18)
    
    let trainerContainerView = UIView()
    let athleteContainerView = UIView()
    
    var currentRole: RoleEnum = .trainer
    
    let trainerVioletCircle = UIView()
    let athleteVioletCircle = UIView()
    
    override func viewDidLoad() {
        configureView()
        configureBackgroundImageView()
        configureNavigation()
        
        configureScrollViewFrame()
        
        configureView(view: lastnameLabel, topAnchor: scrollView)
        configureView(view: lastnameTextField, topAnchor: lastnameLabel)
        configureView(view: firstnameLabel, topAnchor: lastnameTextField)
        configureView(view: firstnameTextField, topAnchor: firstnameLabel)
        configureView(view: emailLabel, topAnchor: firstnameTextField)
        configureView(view: emailTextField, topAnchor: emailLabel)
        configureView(view: phoneLabel, topAnchor: emailTextField)
        configureView(view: phoneTextField, topAnchor: phoneLabel)
        configureView(view: passwordLabel, topAnchor: phoneTextField)
        configureView(view: passwordTextField, topAnchor: passwordLabel)
        configureView(view: passwordRepeatLabel, topAnchor: passwordTextField)
        configureView(view: passwordRepeatTextField, topAnchor: passwordRepeatLabel)
        configureCreateUserButton()
        
        configureRadioButton()
        
        configureScrollView()
        
        // test data
        lastnameTextField.text = "Mickey"
        firstnameTextField.text = "Mouse"
        emailTextField.text = "mickey@mouse7.com"
        phoneTextField.text = "79262001813"
        passwordTextField.text = "123456"
        passwordRepeatTextField.text = "123456"
    }
}

// MARK: - Private methods

private extension RegisterViewController {
    
    func configureView() {
        view.backgroundColor = .white
        DismissKeyboardWhenTap.shared.dismissKeyboard(view: view)
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        navigationItem.title = "Новый профиль"
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let cancelButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(cancelNavigationButtonTapped))
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    func configureBackgroundImageView() {
        let backgroundImageView = UIImageView()
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
    
    func configureScrollViewFrame() {
        scrollView = UIScrollView(frame: CGRect(x: 0,
                                                y: 120,
                                                width: Constants.screenWidth,
                                                height: Constants.screenHeight - 290))
    }
    
    func configureScrollView() {
        scrollView.contentSize = CGSize(width: Constants.screenWidth,
                                        height: 1000)
        view.addSubview(scrollView)
    }
    
    func configureView(view: UIView, topAnchor: UIView) {
        scrollView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor.bottomAnchor, constant: Constants.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.leftMargin),
            view.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Constants.rightMargin),
            view.heightAnchor.constraint(equalToConstant: Constants.textfieldHeightAnchor)
        ])
    }
    
    func configureCreateUserButton() {
        view.addSubview(createUserButton)
        
        NSLayoutConstraint.activate([
            createUserButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.createButtonBottonAnchor),
            createUserButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leftMargin),
            createUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: Constants.rightMargin),
            createUserButton.heightAnchor.constraint(equalToConstant: Constants.textfieldHeightAnchor)
        ])
        
        createUserButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    
    func saveUserDataToModel() {
        profile.firstName = firstnameTextField.text ?? nil
        profile.lastName = lastnameTextField.text ?? nil
        profile.password = passwordTextField.text ?? nil
        profile.passwordConfirmation = passwordRepeatTextField.text ?? nil
        profile.email = emailTextField.text ?? nil
        profile.phone = phoneTextField.text ?? nil
        
        if currentRole == RoleEnum.athlete {
            profile.client = "client"
        }
        
        if currentRole == RoleEnum.trainer {
            profile.trainer = "trainer"
        }
    }
    
    func displaySuccessAlert() {
        DispatchQueue.main.async {
            let vc = AlertViewController(question: "Добро пожаловать!", description: "Вы успешно создали профиль", actionButtonTitle: "Продолжить", cancelButtonTitle: nil, icon: .chevronDownCircle)
            vc.modalPresentationStyle = .fullScreen
            vc.modalPresentationStyle = .overCurrentContext
            vc.actionButton.addTarget(self, action: #selector(self.alertCreateButtonTapped), for: .touchUpInside)
            self.present(vc, animated: false)
        }
    }
    
    func displayFailedAlert(message: String) {
        DispatchQueue.main.async {
            let vc = AlertViewController.init(question: "Упс", description: message, actionButtonTitle: "Закрыть", cancelButtonTitle: nil, icon: .multiplyCircle)
            vc.modalPresentationStyle = .fullScreen
            vc.modalPresentationStyle = .overCurrentContext
            vc.actionButton.addTarget(self, action: #selector(self.alertCancelButtonTapped), for: .touchUpInside)
            self.present(vc, animated: false)
        }
    }
}

// MARK: - Actions

private extension RegisterViewController {
    
    @objc
    func cancelNavigationButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    func createButtonTapped() {
        saveUserDataToModel()
        
        NetworkManager.shared.registerUser(firstname: profile.firstName ?? "",
                                           lastname: profile.lastName ?? "",
                                           password: profile.password ?? "",
                                           passwordConfirmation: profile.passwordConfirmation ?? "",
                                           email: profile.email ?? "",
                                           role: currentRole,
                                           phone: profile.phone ?? "") { [weak self] result in
                                            guard let self = self else { return }
                                            switch result {
                                            case .success(let response):
                                                print(response)
                                                self.displaySuccessAlert()
                                            case .failure(let error):
                                                print(error.rawValue)
                                                self.displayFailedAlert(message: error.rawValue)
                                            }
        }
    }
    
    @objc
    func alertCreateButtonTapped() {
        
        dismiss(animated: false) {
            NetworkManager.shared.getToken(email: self.emailTextField.text ?? "",
                                           password: self.passwordTextField.text ?? "")
        }
        
        switch currentRole {
        case .athlete:
            let vc = AthleteViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        case .trainer:
            let vc = TrainerViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    @objc
    func alertCancelButtonTapped() {
        dismiss(animated: false)
    }
}

// MARK: - Radio button

private extension RegisterViewController {
    
    func configureRadioButton() {
        configureContainer(view: trainerContainerView,
                           topAnchor: passwordRepeatTextField,
                           roleVioletCircle: trainerVioletCircle)
        
        configureContainer(view: athleteContainerView,
                           topAnchor: trainerContainerView,
                           roleVioletCircle: athleteVioletCircle)
        
        let trainerTap = UITapGestureRecognizer(target: self, action: #selector(trainerContainerViewTapped))
        trainerContainerView.addGestureRecognizer(trainerTap)
        
        let athleteTap = UITapGestureRecognizer(target: self, action: #selector(athleteContainerViewTapped))
        athleteContainerView.addGestureRecognizer(athleteTap)
    }
    
    func configureContainer(view: UIView, topAnchor: UIView, roleVioletCircle: UIView) {
        scrollView.addSubview(view)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor.bottomAnchor, constant: 20).isActive = true
        view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        view.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        configureShapeView(container: view, roleVioletCircle: roleVioletCircle)
    }
    
    func configureShapeView(container: UIView, roleVioletCircle: UIView) {
        let whiteShape = UIView()
        container.addSubview(whiteShape)
        whiteShape.translatesAutoresizingMaskIntoConstraints = false
        whiteShape.layer.cornerRadius = 12
        whiteShape.clipsToBounds = true
        whiteShape.backgroundColor = .white
        
        whiteShape.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        whiteShape.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        whiteShape.heightAnchor.constraint(equalToConstant: 24).isActive = true
        whiteShape.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        var roleString = ""
        
        switch container {
        case trainerContainerView:
            roleString = "Я тренер"
        case athleteContainerView:
            roleString = "Я атлет"
        default:
            break
        }
        
        let roleLabel = FLabel(fontSize: 16, weight: .medium, color: .white, message: roleString)
        container.addSubview(roleLabel)
        roleLabel.leadingAnchor.constraint(equalTo: whiteShape.trailingAnchor, constant: 10).isActive = true
        roleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
        whiteShape.addSubview(roleVioletCircle)
        roleVioletCircle.translatesAutoresizingMaskIntoConstraints = false
        roleVioletCircle.layer.cornerRadius = 8
        roleVioletCircle.clipsToBounds = true
        roleVioletCircle.backgroundColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        
        roleVioletCircle.centerXAnchor.constraint(equalTo: whiteShape.centerXAnchor).isActive = true
        roleVioletCircle.centerYAnchor.constraint(equalTo: whiteShape.centerYAnchor).isActive = true
        roleVioletCircle.heightAnchor.constraint(equalToConstant: 16).isActive = true
        roleVioletCircle.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        configureVioletCircle()
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
