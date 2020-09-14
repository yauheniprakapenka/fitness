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
    var userId: Int
    var inventoryList: [String]
    
    init(userId: Int, exercise: TPExercise?, inventoryList: [String], onSaveHandler: (() -> Void)?) {
        self.userId = userId
        self.exercise = exercise
        self.inventoryList = inventoryList
        self.onSaveHandler = onSaveHandler
    }
    
    func create() -> UIViewController {
        let vc = TPNewExerciseViewController()
        if let exercise = exercise {
            vc.mode = .edit(exercise: exercise)
        } else {
            vc.mode = .create
        }
        vc.userId = userId
        vc.inventory = inventoryList
        vc.onSaveHandler = onSaveHandler
        vc.service = TPExercisesService.shared
        return vc
    }
}
