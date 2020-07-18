//
//  ProfileViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 18.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var profileLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(profileInfo.profileInfo)
        
        profileLabel.text = profileInfo.profileInfo
    }
}
