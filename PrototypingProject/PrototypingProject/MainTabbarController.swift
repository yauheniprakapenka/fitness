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
        trainingProgramm1.tabBarItem = UITabBarItem(title: "TP1", image: nil, tag: 0)
        
        let tp2 = UIViewController.trainingProgrammViewController2
        tp2.tabBarItem = UITabBarItem(title: "TP2", image: nil, selectedImage: nil)
        
        let tp3 = TPNewExerciseViewController()
        tp3.tabBarItem = UITabBarItem(title: "NewExerc", image: nil, selectedImage: nil)
        tp3.onPrepared = {
            tp3.configure(with: TrainingExcercisesStubData.trainingInventoryDropdown)
            tp3.configure(with: TrainingExcercisesStubData.exercise)
        }
        let tp4 = TPNewTrainingViewController()
        tp4.tabBarItem = UITabBarItem(title: "NewTrain", image: nil, selectedImage: nil)
        
        let tp5 = UIViewController.trainingProgrammViewController3
        tp5.tabBarItem = UITabBarItem(title: "TP3", image: nil, selectedImage: nil)
        
        let list = [
            trainingProgramm1,
            tp2,
            tp3,
            tp4,
            tp5
        ]
        
        viewControllers = list
        setActiveController(tp4)
    }
    
    private func setActiveController(_ controller: UIViewController) {
        if let index = viewControllers?.firstIndex(of: controller) {
            selectedIndex = index
        }
    }
}