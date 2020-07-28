//
//  DefineRoleAndPresentViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 20.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentRoleProfile() {
        switch currentProfleRole {
        case .Athlete:
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "AthleteVC") as! AthleteViewController
            let navController = UINavigationController(rootViewController: vc)
            present(navController, animated:true)
        case .Trainer:
            let vc = storyboard!.instantiateViewController(withIdentifier: "containerID") as! ContainerViewController
            present(vc, animated: true)
        }
    }
}
