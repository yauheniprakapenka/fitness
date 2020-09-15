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
    private var training: TPTraining?
    private var exercises: [TPExercise]
    private var profileValues: [String]
    private var userId: Int
    private var onSaveHandler: (() -> Void)?
    
    init(exercises: [TPExercise],
         profileValues: [String],
         trainingService: TPTrainingService,
         trainingToEdit: TPTraining?,
         userId: Int,
         onSaveHandler: (() -> Void)?) {
        self.exercises = exercises
        self.userId = userId
        self.trainingService = trainingService
        self.training = trainingToEdit
        self.onSaveHandler = onSaveHandler
        self.profileValues = profileValues
    }
    
    func create() -> TPNewTrainingViewController {
        let vc = TPNewTrainingViewController.instance()
        if let training = training {
            vc.mode = .edit(training: training)
        } else {
            vc.mode = .creation
        }
        vc.profileValues = profileValues
        vc.trainingsService = trainingService
        vc.exercises = exercises
        vc.userId = userId
        vc.modalPresentationStyle = .fullScreen
        vc.onSaveHandler = onSaveHandler
        return vc
    }
}
