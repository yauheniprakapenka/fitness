//
//  NewRegistrationViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 15.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

private extension RegistrationViewController {
    enum Const {
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

class RegistrationViewController: UIViewController {
    var scrollView: UIScrollView!
    
    let lastnameLabel = FLabel(fontSize: Const.labelFontSize, weight: .regular, color: .white, message: "Фамилия")
    let lastnameTextField = FTextField(placeholderText: "Введите фамилию", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    let firstnameLabel = FLabel(fontSize: Const.labelFontSize, weight: .regular, color: .white, message: "Имя")
    let firstnameTextField = FTextField(placeholderText: "Введите имя", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    let emailLabel = FLabel(fontSize: Const.labelFontSize, weight: .regular, color: .white, message: "email")
    let emailTextField = FTextField(placeholderText: "Введите email", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    let phoneLabel = FLabel(fontSize: Const.labelFontSize, weight: .regular, color: .white, message: "Телефон")
    let phoneTextField = FTextField(placeholderText: "Введите телефон", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    let passwordLabel = FLabel(fontSize: Const.labelFontSize, weight: .regular, color: .white, message: "Пароль")
    let passwordTextField = FTextField(placeholderText: "Введите пароль", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    let passwordRepeatLabel = FLabel(fontSize: Const.labelFontSize, weight: .regular, color: .white, message: "Повторите пароль")
    let passwordRepeatTextField = FTextField(placeholderText: "Повторите пароль", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    let createUserButton = FButtonWithBackgroundColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Создать профиль", size: 18)
    
    let trainerContainerView = UIView()
    let athleteContainerView = UIView()
    
//    var currentRole: RoleEnum = .trainer
    
    let trainerVioletCircle = UIView()
    let athleteVioletCircle = UIView()
    
    let fRadioButtonView = FRadioButtonView()
    
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
        
        configureScrollView()
        
        configureRadioButton()
        
        // test data
        lastnameTextField.text = "Mickey"
        firstnameTextField.text = "Mouse"
        emailTextField.text = "mickey@mouse2.com"
        phoneTextField.text = "79262001813"
        passwordTextField.text = "123456"
        passwordRepeatTextField.text = "123456"
    }
}

// MARK: - Private methods

private extension RegistrationViewController {
    
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
                                                width: Const.screenWidth,
                                                height: Const.screenHeight - 290))
    }
    
    func configureScrollView() {
        scrollView.contentSize = CGSize(width: Const.screenWidth,
                                        height: 1000)
        view.addSubview(scrollView)
    }
    
    func configureView(view: UIView, topAnchor: UIView) {
        scrollView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor.bottomAnchor, constant: Const.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Const.leftMargin),
            view.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Const.rightMargin),
            view.heightAnchor.constraint(equalToConstant: Const.textfieldHeightAnchor)
        ])
    }
    
    func configureRadioButton() {
        scrollView.addSubview(fRadioButtonView)
        fRadioButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fRadioButtonView.topAnchor.constraint(equalTo: passwordRepeatTextField.bottomAnchor, constant: Const.bottomAnchor),
            fRadioButtonView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Const.leftMargin),
            fRadioButtonView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Const.rightMargin),
            fRadioButtonView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    func configureCreateUserButton() {
        view.addSubview(createUserButton)
        
        NSLayoutConstraint.activate([
            createUserButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Const.createButtonBottonAnchor),
            createUserButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftMargin),
            createUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: Const.rightMargin),
            createUserButton.heightAnchor.constraint(equalToConstant: Const.textfieldHeightAnchor)
        ])
        
        createUserButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    
    func saveUserDataToModel() {
        profile.firstName = firstnameTextField.text
        profile.lastName = lastnameTextField.text
        profile.password = passwordTextField.text
        profile.passwordConfirmation = passwordRepeatTextField.text
        profile.email = emailTextField.text
        profile.phone = phoneTextField.text
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
    
    func presentVC() {
        if tokenModel.client {
            DispatchQueue.main.async {
                let vc = AthleteViewController()
                self.present(vc, animated: true)
            }
        }
        
        if tokenModel.trainer {
            DispatchQueue.main.async {
                let vc = TrainerViewController()
                self.present(vc, animated: true)
            }
        }
    }
}

// MARK: - Actions

private extension RegistrationViewController {
    
    @objc
    func cancelNavigationButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    func createButtonTapped() {
        saveUserDataToModel()
        
        NetworkManager.shared.makeRegistration(profile: profile, role: fRadioButtonView.currentRole, resultCompletion: { (result) in
            switch result {
            case .success(let response):
                print(response)
                NetworkManager.shared.getToken(email: profile.email ?? "", password: profile.password ?? "") { (result) in
                    switch result {
                    case .success(let success):
                        print(success)
                        NetworkManager.shared.getUser {
                            self.presentVC()
                        }
                    case .failure(let failure):
                        print(failure.rawValue)
                    }
                }
            case .failure(let error):
                print(error.rawValue)
                self.displayFailedAlert(message: error.rawValue)
            }
        }, completion: nil)
    }
    
    @objc
    func alertCreateButtonTapped() {
        dismiss(animated: false)
        
        switch fRadioButtonView.currentRole {
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
