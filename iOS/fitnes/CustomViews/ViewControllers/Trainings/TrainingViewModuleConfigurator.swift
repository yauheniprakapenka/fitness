//
//  TrainingViewModuleConfigurator.swift
//  fitnes
//
//  Created by Vitali on 9/16/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import TrainingProgramm
import Common

class TrainingViewModuleConfigurator {
    private let insets: UIEdgeInsets
    private let router: Router
    private let activityIndicator: ActivityIndicatorProtocol
    
    private var profileValues = [
        "Приседания со штангой на спине",
        "Приседания со штангой на груди",
        "Толчек тяжелоатлетический",
        "Рывок тяжелоатлетический",
        "Жим лежа",
        "Жим стоя",
        "Становая тяга"
    ]
    
    init(
        insets: UIEdgeInsets,
        router: Router,
        activityIndicator: ActivityIndicatorProtocol
    ) {
        self.insets = insets
        self.router = router
        self.activityIndicator = activityIndicator
    }
    
    func create() -> TrainingViewController {
        let viewModel = TrainingsViewModel(
            router: router,
            profileValues: profileValues,
            trainingsService: TPTrainingService.shared,
            exercisesService: TPExercisesService.shared)
        let vc = TrainingViewController(contentInset: insets)
        vc.activityIndicator = activityIndicator
        vc.modalPresentationStyle = .fullScreen
        vc.viewModel = viewModel
        return vc
    }
}
