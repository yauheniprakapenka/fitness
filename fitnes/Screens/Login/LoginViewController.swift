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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 5
    }
    
    @IBAction func forgetPasswordTapped(_ sender: Any) {

    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        HapticFeedback.shared.makeHapticFeedback(kind: 5)
        
        AuthService.shared.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result) in
            switch result {
            case .success(let user):
                profileInfoModel.email = user.email ?? ""
                profileInfoModel.uid = user.uid
                
                FirestoreService.shared.fetchProfile() {
                    switch ConverterRoleToEnum.shared.roleToEnum(role: profileInfoModel.role) {
                    case .Trainer:
                        let vc = TrainerViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
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

