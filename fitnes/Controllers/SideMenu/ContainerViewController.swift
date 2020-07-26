//
//  ContainerViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 26.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var trainerVC: UIViewController!
    var menuVC: UIViewController!
    var isMove = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTrainerVC()
    }
    
    private func configureTrainerVC() {
        let trainerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "trainerID") as! TrainerViewController
        trainerViewController.delegate = self
        
        trainerVC = trainerViewController
        view.addSubview(trainerVC.view)
        addChild(trainerVC)
    }
    
    private func configureMenuVC() {
        if menuVC == nil {
            let trainerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sideMenuID") as! SideMenuViewController
            
            menuVC = trainerViewController
            view.insertSubview(menuVC.view, at: 0)
            addChild(menuVC)
        }
    }
    
    private func showMenuViewController(shouldMove: Bool) {
        if shouldMove {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.trainerVC.view.frame.origin.x = self.trainerVC.view.frame.width - 180
            }) { (Bool) in
                
            }
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.trainerVC.view.frame.origin.x = 0
            }) { (Bool) in
                
            }
        }
    }
}

// MARK: - TrainerViewControllerDelegate
extension ContainerViewController: TrainerViewControllerDelegate {
    func toggleMenu() {
        configureMenuVC()
        isMove = !isMove
        showMenuViewController(shouldMove: isMove)
    }
}
