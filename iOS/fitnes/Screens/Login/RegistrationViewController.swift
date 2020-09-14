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
    private let activityIndicator = FActivityIndicator()
    
    private let emailLabel = FLabel(fontSize: Const.labelFontSize, weight: .regular, color: .white, message: "Почта")
    private let emailTextField = FTextField(placeholderText: "Введите email", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    private let passwordLabel = FLabel(fontSize: Const.labelFontSize, weight: .regular, color: .white, message: "Пароль")
    private let passwordTextField = FTextField(placeholderText: "Введите пароль", placeholderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5965073529))
    private let createUserButton = FButtonWithBackgroundColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Создать профиль", size: 18)
    
    private let trainerContainerView = UIView()
    private let athleteContainerView = UIView()
    
//    var currentRole: RoleEnum = .trainer
    
    private let trainerVioletCircle = UIView()
    private let athleteVioletCircle = UIView()
    
    private let fRadioButtonView = FRadioButtonView()
    
    override func viewDidLoad() {
        configureView()
        configureBackgroundImageView()
        configureNavigation()
        
        configureScrollViewFrame()

        configureView(view: emailLabel, topAnchor: scrollView)
        configureView(view: emailTextField, topAnchor: emailLabel)
        configureView(view: passwordLabel, topAnchor: emailTextField)
        configureView(view: passwordTextField, topAnchor: passwordLabel)
        configureCreateUserButton()
        
        configureScrollView()
        configureActivityIndicator()
        
        configureRadioButton()
        
        // test data
        emailTextField.text = "tony@hawk.trainer"
        passwordTextField.text = "123456"
    }
}

// MARK: - Private methods
private extension RegistrationViewController {
    
    func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
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
        
        let cancelButton = UIBarButtonItem(title: "Обратно", style: .plain, target: self, action: #selector(cancelNavigationButtonTapped))
        cancelButton.setTitleTextAttributes([.foregroundColor : UIColor.white], for: .normal)
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
            fRadioButtonView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Const.bottomAnchor + 20),
            fRadioButtonView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Const.leftMargin),
            fRadioButtonView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: Const.rightMargin),
            fRadioButtonView.heightAnchor.constraint(equalToConstant: 120)
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
        currentProfile.password = passwordTextField.text
        currentProfile.passwordConfirmation = passwordTextField.text
        currentProfile.email = emailTextField.text
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
        if let client = apiTokenModel.client,
           client {
            
            DispatchQueue.main.async {
                let vc = AthleteViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }

        if let trainer = apiTokenModel.trainer,
           trainer {
            
            DispatchQueue.main.async {
                let router = Router()
                let vc = TrainerModuleConfigrator(with: router).create()
                router.push(vc: vc)
                self.present(router.navigationController, animated: true)
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
        DispatchQueue.main.async {
            self.activityIndicator.startAnimate()
        }
        
        saveUserDataToModel()
        
        NetworkManager.shared.makeRegistration(profile: currentProfile, role: fRadioButtonView.currentRole, resultCompletion: { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimate()
                }
                print(response)
                NetworkManager.shared.getToken(email: currentProfile.email ?? "", password: currentProfile.password ?? "") { (result) in
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
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimate()
                }
                print(error.rawValue)
                self.displayFailedAlert(message: error.rawValue)
            }
        }, completion: nil)
    }
    
    @objc
    func alertCancelButtonTapped() {
        dismiss(animated: false)
    }
}
