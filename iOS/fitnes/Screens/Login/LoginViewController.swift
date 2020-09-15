//
//  NewLoginViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 15.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

// MARK: - Constants

private extension LoginViewController {
    enum Const {
        static let leftRightMargins: CGFloat = 20
        static let inputBorderColor = UIColor(named: "loginScreenInputFieldBorder")!
        
        static let copyrightBottomAnchor: CGFloat = 20
        static let githubViewSize: CGFloat = 20
        static let copyrightColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
}

class LoginViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let contentScrollView = UIScrollView()
    private let backgroundImageView = UIImageView()
    private let activityIndicator = FActivityIndicator()
    
    private let startLabel = FLabel(fontSize: 34, weight: .semibold, color: .white, message: "Начнем")
    private let signinLabel = FLabel(fontSize: 20, weight: .light, color: .white, message: "Войдите для начала занятий")
    private let emailLabel = FLabel(fontSize: 14, weight: .regular, color: .white, message: "Email")
    private let emailTextField = FTextField(placeholderText: "Введите email", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    private let passwordLabel = FLabel(fontSize: 14, weight: .regular, color: .white, message: "Пароль")
    private let passwordTextField = FTextField(placeholderText: "Введите пароль", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    private let loginButton = FButtonWithBackgroundColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Войти", size: 18)
    private let createProfileButton = FButtonSimple(title: "Создать новый профиль", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 18)
    private let githubView = FGithubView()
    
    // MARK: - View Life Cycle
    
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
        
        configureGithubView()
        configureCreateProfleButton()
        configureLoginButton()
        configureActivityIndicator()
        
        DismissKeyboardWhenTap.shared.dismissKeyboard(view: contentScrollView)
        
        emailTextField.text = UserDefaultsStorage.shared.previousEnteredLogin
        
        // test data
        emailTextField.text = "tony5@hawk.trainer"
        passwordTextField.text = "123456"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentScrollView.resizeContentSizeToFitChilds()
    }
}

// MARK: - Private methods

private extension LoginViewController {
    
    func configureGithubView() {
        view.addSubview(githubView)
        
        NSLayoutConstraint.activate([
            githubView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            githubView.widthAnchor.constraint(equalToConstant: 180),
            githubView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            githubView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCreateProfleButton() {
        view.addSubview(createProfileButton)
        createProfileButton.translatesAutoresizingMaskIntoConstraints = false
        createProfileButton.bottomAnchor.constraint(equalTo: githubView.topAnchor, constant: -30).isActive = true
        createProfileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargins).isActive = true
        createProfileButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Const.leftRightMargins * 2).isActive = true
        createProfileButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        createProfileButton.addTarget(self, action: #selector(createProfileButtonTapped), for: .touchUpInside)
    }
    
    func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    func presentAlertVC(errorMessage: String) {
        DispatchQueue.main.async {
            let vc = AlertViewController(question: "Упс", description: errorMessage, actionButtonTitle: "Закрыть", cancelButtonTitle: nil, icon: .multiplyCircle)
            vc.modalPresentationStyle = .fullScreen
            vc.modalPresentationStyle = .overCurrentContext
            vc.actionButton.addTarget(self, action: #selector(self.alertCancelButtonTapped), for: .touchUpInside)
            self.present(vc, animated: false)
        }
    }
    
    func presentProfile() {
        DispatchQueue.main.async {
            if let client = apiTokenModel.client, client {
                let vc = AthleteViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
                return
            }
            
            if let trainer = apiTokenModel.trainer, trainer {
                let vc = TrainerViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
                return
            }
            self.presentAlertVC(errorMessage: "Не удалось определить роль")
        }
    }
    
    func saveUserDataToModel() {
        currentProfile.email = emailTextField.text
        currentProfile.password = passwordTextField.text
    }
    
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
    }
    
    func configureLoginButton() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.bottomAnchor.constraint(equalTo: createProfileButton.topAnchor, constant: -20).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargins).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Const.leftRightMargins * 2).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Private extension

private extension LoginViewController {
    
    @objc
    func loginButtonTapped() {
        HapticFeedback.shared.make(type: .light)
        activityIndicator.startAnimate()
        saveUserDataToModel()
        
        NetworkManager.shared.getToken(email: currentProfile.email ?? "", password: currentProfile.password ?? "", completion: { (result) in
            switch result {
            case .success(let tokenModel):
                UserDefaultsStorage.shared.previousEnteredLogin = currentProfile.email
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                print(tokenModel)
                NetworkManager.shared.getUser {
                    self.presentProfile()
                    NetworkManager.shared.getTicket()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                print(failure)
                self.presentAlertVC(errorMessage: failure.rawValue)
            }
        })
    }
    
    @objc
    func createProfileButtonTapped() {
        HapticFeedback.shared.make(type: .light)
        
        let vc = RegistrationViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc
    func alertCancelButtonTapped() {
        dismiss(animated: false)
    }
}
