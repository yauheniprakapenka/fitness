//
//  MainTabbarController.swift
//  PrototypingProject
//
//  Created by Vitali on 8/30/20.
//

import UIKit

class MainTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trainingProgramm1 = UIViewController.trainingProgrammViewController1
        trainingProgramm1.tabBarItem = UITabBarItem(title: "TrainingProgramm1", image: nil, tag: 0)
        
        let tp2 = UIViewController.trainingProgrammViewController2
        tp2.tabBarItem = UITabBarItem(title: "TrainingProgramm2", image: nil, selectedImage: nil)
        
        let list = [
            trainingProgramm1,
            tp2
        ]
        
        viewControllers = list
        setActiveController(tp2)
    }
    
    
    private func setActiveController(_ controller: UIViewController) {
        if let index = viewControllers?.firstIndex(of: controller) {
            selectedIndex = index
        }
    }
}
