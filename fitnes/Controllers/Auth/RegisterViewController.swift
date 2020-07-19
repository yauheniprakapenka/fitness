//
//  AuthViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 15.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var passwordConfirmTextField: UITextField!
    
    @IBOutlet var roleSegmentedControl: UISegmentedControl!

    @IBAction func roleSegmentedControlTapped(_ sender: Any) {
        ProfileRoleModel.shared.setProfileRole(index: roleSegmentedControl.selectedSegmentIndex)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        AuthService.shared.register(email: emailTextField.text, password: passwordTextfield.text, confirmPassword: passwordConfirmTextField.text) { (result) in
            switch result {
            case .success(let user):
                
                profileInfo.email = String(user.email ?? "")
                profileInfo.uid = String(user.uid)
                
                FirestoreService.shared.saveProfile(email: profileInfo.email, uid: profileInfo.uid)
                
                self.defineRoleAndPresentViewController()
                
            case .failure(let error):
                self.showAlert(title: "", message: error.localizedDescription)
            }
        }
    }
}
