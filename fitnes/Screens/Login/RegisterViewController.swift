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
    
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    @IBOutlet var trainerRadioView: UIView!
    @IBOutlet var athletRadioView: UIView!
    @IBOutlet var trainerRadioSelectedView: UIView!
    @IBOutlet var athletRadioSelectedView: UIView!
    
    @IBOutlet var registerButton: UIButton!
    
    private var selectedRole: RoleEnum? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    @IBAction func trainerRadioTapped(_ sender: Any) {
        HapticFeedback.shared.makeHapticFeedback(type: .medium)
        radioButtonTapped(role: .Trainer)
    }
    
    @IBAction func athleteRadioTapped(_ sender: Any) {
        HapticFeedback.shared.makeHapticFeedback(type: .medium)
        radioButtonTapped(role: .Athlete)
    }
    
    private func radioButtonTapped(role: RoleEnum) {
        trainerRadioSelectedView.alpha = 0
        athletRadioSelectedView.alpha = 0
        
        switch role {
        case .Athlete:
            athletRadioSelectedView.alpha = 1
            selectedRole = .Athlete
        case .Trainer:
            trainerRadioSelectedView.alpha = 1
            selectedRole = .Trainer
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        HapticFeedback.shared.makeHapticFeedback(type: .medium)
        
        guard let selectedRole = selectedRole else {
            showAlert(title: "", message: ValidationError.roleRadioButtonNotSelected.localizedDescription)
            return
        }
        
        AuthService.shared.createUser(withEmail: emailTextField.text, password: passwordTextfield.text) { (result) in
            
            switch result {
            case .success(let user):
                profileInfoModel.email = String(user.email ?? "")
                profileInfoModel.uid = String(user.uid)
                
                FirestoreService.shared.saveProfile(email: profileInfoModel.email, uid: profileInfoModel.uid, lastName: self.lastNameTextField.text ?? "", firstName: self.firstNameTextField.text ?? "", role: selectedRole)
                
                FirestoreService.shared.fetchProfile() {
                    switch ConverterRoleToEnum.shared.roleToEnum(role: profileInfoModel.role) {
                    case .Trainer:
                        let vc = TrainerViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    case .Athlete:
                        break
                    case .none:
                        break
                    }
                }
                
            case .failure(let error):
                self.showAlert(title: "", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func configureUI() {
        trainerRadioSelectedView.layer.cornerRadius = trainerRadioSelectedView.frame.size.width / 2
        athletRadioSelectedView.layer.cornerRadius = athletRadioSelectedView.frame.size.width / 2
        trainerRadioSelectedView.alpha = 0
        athletRadioSelectedView.alpha = 0
        
        trainerRadioView.layer.cornerRadius = trainerRadioView.frame.size.width / 2
        athletRadioView.layer.cornerRadius = athletRadioView.frame.size.width / 2
        
        registerButton.layer.cornerRadius = 5
    }
}
