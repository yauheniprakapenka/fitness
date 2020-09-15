//
//  TrainingViewModel.swift
//  fitnes
//
//  Created by Vitali on 9/15/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import TrainingProgramm

extension TrainingsViewModel {
    typealias OnLoadingStatusChanged = (Bool) -> Void
    typealias OnTrainingsListChanged = ([TrainingModel]) -> Void
    typealias OnError = (String?) -> Void
}

class TrainingsViewModel {
    private var router: Router
    private var trainingsService: TPTrainingService
    private var exercisesService: TPExercisesService
    private var trainings: [TPTraining] = []
    private var profileValues: [String]
    
    private var images: [UIImage] = [
        #imageLiteral(resourceName: "Screenshot 08-12-2020 23.44.00"),
        #imageLiteral(resourceName: "Screenshot 08-12-2020 23.43.45"),
        #imageLiteral(resourceName: "Screenshot 08-12-2020 23.45.49"),
        #imageLiteral(resourceName: "Screenshot 08-12-2020 23.44.58")
    ]
    
    init(
        router: Router,
        profileValues: [String],
        trainingsService: TPTrainingService,
        exercisesService: TPExercisesService
    ) {
        self.trainingsService = trainingsService
        self.exercisesService = exercisesService
        self.router = router
        self.profileValues = profileValues
    }
    
    // MARK: - View Bindings
    var onLoadingStatusChanged: OnLoadingStatusChanged?
    var onTrainingListChanged: OnTrainingsListChanged?
    var onError: OnError?
    
    // MARK: - Main Interface
    func viewPrepared() {
        loadTrainings()
    }
    
    func createTrainingTapped() {
        onLoadingStatusChanged?(true)
        loadExercises { exercises in
            self.onLoadingStatusChanged?(false)
            guard let exercises = exercises else {
                self.onError?("Не удалось получить список упражнений")
                return
            }
            let vc = AddEditTrainingConfigurator(
                exercises: exercises,
                profileValues: self.profileValues,
                trainingService: self.trainingsService,
                trainingToEdit: nil,
                userId: Int(apiTokenModel.userId!),
                onSaveHandler: self.handleTrainingsChanged).create()
            self.router.push(vc: vc)
        }
    }
    
    func trainingSelected(index: Int) {
        let training = trainings[index]
        onLoadingStatusChanged?(true)
        loadExercises { exercises in
            self.onLoadingStatusChanged?(false)
            guard let exercises = exercises else {
                self.onError?("Не удалось получить список упражнений")
                return
            }
            let vc = AddEditTrainingConfigurator(
                exercises: exercises,
                profileValues: self.profileValues,
                trainingService: self.trainingsService,
                trainingToEdit: training,
                userId: Int(apiTokenModel.userId!),
                onSaveHandler: self.handleTrainingsChanged).create()
            self.router.push(vc: vc)
        }
    }
}

extension TrainingsViewModel {
    private func handleTrainingsChanged() {
        loadTrainings()
    }
    
    private func loadTrainings() {
        guard let id = apiTokenModel.userId else {
            return
        }
        let userId = Int(id)
        onLoadingStatusChanged?(true)
        trainingsService.trainingList(userId: userId) { result in
            self.onLoadingStatusChanged?(false)
            switch result {
            case .success(let trainings):
                self.trainings = trainings.reversed()
                let mapped = self.trainings.enumerated().map { (index, item) in
                    return self.convertTrainingToViewDataObject(item, index: index)
                }
                self.onTrainingListChanged?(mapped)
            case .failure:
                self.onError?("Не удалось получить список тренировок")
                return
            }
            
        }
    }
    
    private func loadExercises(completed: @escaping ([TPExercise]?) -> Void) {
        guard let id = apiTokenModel.userId else {
            return
        }
        let userId = Int(id)
        onLoadingStatusChanged?(true)
        exercisesService.exercisesList(userId: userId) { result in
            self.onLoadingStatusChanged?(false)
            switch result {
            case .success(let exercises):
                completed(exercises)
            case .failure:
                completed(nil)
            }
        }
    }
    
    func convertTrainingToViewDataObject(_ training: TPTraining, index: Int) -> TrainingModel {
        
        let image = images[index % images.count]
        let exercisesCount = training.sections?.reduce(0) { accum, elem in
            
            let itemsCount = elem.items?.reduce(0) { itemsAccum, item in
                return itemsAccum + 1
            }
            return (accum ?? 0) + (itemsCount ?? 0)
        }
        let firstKind = training.sections?.first?.trainingType.title ?? ""
        return TrainingModel(title: training.name ?? "Без имени",
                             image: image,
                             kind: firstKind,
                             count: "\(exercisesCount ?? 0) упражнений")
        
    }
}

private extension TPTrainingType {
    var title: String {
        switch self {
        case .amrap:
            return "Amrap"
        case .emom:
            return "Emom"
        case .forTime:
            return "For Time"
        case .rest:
            return "Rest"
        }
    }
}
