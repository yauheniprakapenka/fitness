//
//  AuthViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 15.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var passwordConfirmTextField: UITextField!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func signupButton(_ sender: Any) {
        activityIndicator.startAnimating()
        
        AuthService.shared.register(email: emailTextField.text!, password: passwordTextfield.text!, confirmPassword: passwordConfirmTextField.text) { (result) in
            
            guard self.passwordTextfield.text == self.passwordConfirmTextField.text else {
                self.showAlert(title: "", message: "Не совпадают пароли")
                self.activityIndicator.stopAnimating()
                return
            }
            
            switch result {
            case .success(let user):
                print(user.email as Any)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                self.showAlert(title: "Что-то пошло не так", message: error.localizedDescription)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
}
