//
//  ViewController + Extension.swift
//  fitnes
//
//  Created by yauheni prakapenka on 16.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Продолжить", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func defineRoleAndPresentViewController() {
        switch currentProfleRole {
        case .Athlete:
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "AthleteVC") as! AthleteViewController
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated:true)
        case .Trainer:
            let vc = storyboard!.instantiateViewController(withIdentifier: "TrainerVC") as! TrainerViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}
