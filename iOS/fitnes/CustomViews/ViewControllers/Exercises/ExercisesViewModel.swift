//
//  ExercisesViewModel.swift
//  fitnes
//
//  Created by Vitali on 9/13/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation
import TrainingProgramm

extension ExercisesViewModel {
    typealias OnLoadingStatusChangedCallback = (Bool) -> Void
    typealias OnExercisesListChanged = ([ExercisesModel]) -> Void
}

class ExercisesViewModel {
    private var router: Router
    private var exerciesService: TPExercisesService
    private var exercises: [TPExercise] = []
    
    init(
        router: Router,
        service: TPExercisesService
    ) {
        self.exerciesService = service
        self.router = router
    }
    
    // MARK: - View Bindings
    var onLoadingStatusChanged: OnLoadingStatusChangedCallback?
    var onExercisesListChanged: OnExercisesListChanged?
    
    // MARK: - Main Interface
    func viewPrepared() {
        loadExercises()
    }
    func createExerciseTapped() {
        let exercisesInventory = exercises.compactMap { $0.inventory }.filter { !$0.isEmpty }
        let uniqInventory = Array(Set(exercisesInventory))
        let vc = AddEditExerciseConfigurator(
            userId: Int(apiTokenModel.userId!),
            exercise: nil,
            inventoryList: uniqInventory,
            onSaveHandler: handleExercisesChanged).create()
        router.push(vc: vc)
    }
    
    func exerciseSelected(index: Int) {
        let exercise = exercises[index]
        let exercisesInventory = exercises.compactMap { $0.inventory }.filter { !$0.isEmpty }
        let uniqInventory = Array(Set(exercisesInventory))
        let vc = AddEditExerciseConfigurator(
            userId: Int(apiTokenModel.userId!),
            exercise: exercise,
            inventoryList: uniqInventory,
            onSaveHandler: handleExercisesChanged).create()
        router.push(vc: vc)
    }
    
    private func handleExercisesChanged() {
        loadExercises()
    }
    
    private func loadExercises() {
        guard let id = apiTokenModel.userId
              else {
            return
        }
        let userId = Int(id)
        onLoadingStatusChanged?(true)
        exerciesService.exercisesList(userId: userId) { result in
            self.onLoadingStatusChanged?(false)
            switch result {
            case .success(let exercises):
                self.exercises = exercises.reversed()
                let maped = self.exercises.map { item in
                    return ExercisesModel(image: #imageLiteral(resourceName: "scott-webb-U5kQvbQWoG0-unsplash"), exerciseName: item.name ?? "", kindInventory: item.inventory ?? "")
                }
                self.onExercisesListChanged?(maped)
            case .failure:
                return
            }
            
        }
    }
}
