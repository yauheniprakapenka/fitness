//
//  TrainerViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 18.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class TrainerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirestoreService.shared.createTrainerIfNotExist() {
            FirestoreService.shared.saveTrainer(uid: profileInfo.uid)
        }
        
        FirestoreService.shared.getTrainer()
        FirestoreService.shared.getExercises()
    }
}
