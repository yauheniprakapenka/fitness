//
//  LoginViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 16.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
 
    let alertContainerView = UIView()
    let buttonStackView = UIStackView()
    let cancelButton = UIButton()
    let buyButton = UIButton()
    let alertImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 5

        
    }
    
    @IBAction func athleteButtonTapped(_ sender: Any) {
        let vc = AthleteViewController()//AthleteViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
  
    @IBAction func loginButtonTapped(_ sender: Any) {
        HapticFeedback.shared.makeHapticFeedback(kind: 5)
        
        let vc = TrainerViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
        AuthService.shared.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result) in
            switch result {
            case .success(let user):
                profileInfoModel.email = user.email ?? ""
                profileInfoModel.uid = user.uid
                
                FirestoreService.shared.fetchProfile() {
                    switch ConverterRoleToEnum.shared.roleToEnum(role: profileInfoModel.role) {
                    case .Trainer:
                        print("Убрать")
                        //                        let vc = TrainerViewController()
                        //                        vc.modalPresentationStyle = .fullScreen
                    //                        self.present(vc, animated: true)
                    case .Athlete:
                        let vc = AthleteViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    case .none:
                        break
                    }
                }
                
            case .failure(let error):
                self.showAlert(title: "Что-то пошло не так", message: error.localizedDescription)
            }
        }
    }
}

// TODO: - Перенести
 

extension LoginViewController {
    
    private func showAlert() {
        view.addSubview(alertContainerView)
        alertContainerView.translatesAutoresizingMaskIntoConstraints = false
        alertContainerView.layer.cornerRadius = 10
        alertContainerView.clipsToBounds = true
        
        alertContainerView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        alertContainerView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        alertContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false


        let button3 = UIButton()
        button3.setTitle("Купить", for: .normal)
        button3.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        alertContainerView.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 0

        buttonStackView.addArrangedSubview(button)
        buttonStackView.addArrangedSubview(button3)
        
        buttonStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: alertContainerView.bottomAnchor).isActive = true
        
        alertContainerView.addSubview(alertImageView)
        alertImageView.translatesAutoresizingMaskIntoConstraints = false
        alertImageView.image = #imageLiteral(resourceName: "fat-girl")
        alertImageView.contentMode = .scaleAspectFill
        
        alertImageView.topAnchor.constraint(equalTo: alertContainerView.topAnchor).isActive = true
        alertImageView.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor).isActive = true
        alertImageView.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor).isActive = true
        alertImageView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor).isActive = true
    }
}
