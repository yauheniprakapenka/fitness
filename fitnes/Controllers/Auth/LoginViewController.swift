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
    
    @IBOutlet var roleSegmentedControl: UISegmentedControl!
    
    @IBAction func roleSegmentedControlTapped(_ sender: Any) {
        ProfileRoleModel.shared.setProfileRole(selectedSegmentIndex: roleSegmentedControl.selectedSegmentIndex)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        AuthService.shared.login(email: emailTextField.text!, password: passwordTextField.text!) { (result) in
            switch result {
            case .success(let user):
                profileInfo.email = user.email ?? ""
                profileInfo.uid = user.uid
                
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "mainID") as! MainViewController
                let navController = UINavigationController(rootViewController: vc)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated:true, completion: nil)

            case .failure(let error):
                self.showAlert(title: "Что-то пошло не так", message: error.localizedDescription)
            }
        }
    }
}


