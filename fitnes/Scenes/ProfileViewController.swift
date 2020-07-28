//
//  ProfileViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 18.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirestoreService.shared.fetchProfile {
            self.nameTextField.text = profileInfo.name
            self.emailTextField.text = profileInfo.email
            self.phoneTextField.text = profileInfo.phone
        }
//        print(profileInfo.profileInfo)
//
//        profileLabel.text = profileInfo.profileInfo
    }
    
    
}
