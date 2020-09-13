//
//  NewExerciseConfigurator.swift
//  fitnes
//
//  Created by Vitali on 9/13/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import TrainingProgramm

class AddEditExerciseConfigurator {
    
    var exercise: TPExercise?
    var onSaveHandler: (() -> Void)?
    
    init(exercise: TPExercise?, onSaveHandler: (() -> Void)?) {
        self.exercise = exercise
    }
    
    func create() -> UIViewController {
        let vc = TPNewExerciseViewController()
        if let exercise = exercise {
            vc.exercise = exercise
        }
        vc.inventory = ["Клюшка", "Уюшка", "Черпак", "Кулак"]
        vc.onSaveHandler = onSaveHandler
        vc.service = TPExercisesService.shared
        return vc
    }
}
