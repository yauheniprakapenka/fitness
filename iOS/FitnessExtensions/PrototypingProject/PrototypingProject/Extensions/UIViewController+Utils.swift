//
//  UIViewController+Utils.swift
//  PrototypingProject
//
//  Created by Vitali on 8/30/20.
//

extension UIViewController {
    static var trainingProgrammViewController1: TrainingProgrammViewController1 {
        get {
            return UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: String(describing: TrainingProgrammViewController1.self)) as! TrainingProgrammViewController1
        }
    }
    
    static var trainingProgrammViewController2: TrainingProgrammViewController2 {
        get {
            return UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: String(describing: TrainingProgrammViewController2.self)) as! TrainingProgrammViewController2
        }
    }
    
    static var trainingProgrammViewController3: TrainingProgrammViewController3 {
        get {
            return UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: String(describing: TrainingProgrammViewController3.self)) as! TrainingProgrammViewController3
        }
    }
}
