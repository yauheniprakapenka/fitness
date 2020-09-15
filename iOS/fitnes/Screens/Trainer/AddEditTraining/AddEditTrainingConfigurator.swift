//
//  AddEditTrainingConfigurato.swift
//  fitnes
//
//  Created by Vitali on 9/15/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation
import TrainingProgramm

class AddEditTrainingConfigurator {
    private var trainingService: TPTrainingService
    private var exercises: [TPExercise]
    private var userId: Int
    
    init(exercises: [TPExercise],
         trainingService: TPTrainingService,
         userId: Int) {
        self.exercises = exercises
        self.userId = userId
        self.trainingService = trainingService
    }
    
    func create() -> TPNewTrainingViewController {
        let vc = TPNewTrainingViewController.instance()
        vc.trainingsService = trainingService
        vc.exercises = exercises
        vc.userId = userId
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}
