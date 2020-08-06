//
//  TrainerViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 18.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

protocol TrainerViewControllerDelegate {
    func toggleMenu()
}

class TrainerViewController: UIViewController {
    
    var delegate: TrainerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirestoreService.shared.isTrainerExist() {
            FirestoreService.shared.createTrainer(uid: profileInfoModel.uid)
        }
    }
    
    @IBAction func exerciseButtonTapped(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ExerciseVC") as! ExerсisesViewController
        present(vc, animated: true)
    }
    
    @IBAction func scheduleButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let scheduleVC = storyBoard.instantiateViewController(withIdentifier: "scheduleVC") as! TrainingViewController
        present(scheduleVC, animated: true, completion: nil)
    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        delegate?.toggleMenu()
    }
}
