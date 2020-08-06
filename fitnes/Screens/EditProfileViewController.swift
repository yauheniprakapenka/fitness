//
//  ProfileViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 18.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirestoreService.shared.fetchProfile {
            self.nameTextField.text = profileInfoModel.firstName
            self.emailTextField.text = profileInfoModel.email
            self.phoneTextField.text = profileInfoModel.lastName
        }
//        print(profileInfo.profileInfo)
//
//        profileLabel.text = profileInfo.profileInfo
    }
    
    
}
