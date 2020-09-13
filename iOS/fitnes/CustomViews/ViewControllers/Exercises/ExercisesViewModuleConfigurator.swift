//
//  ExercisesViewModuleConfigurator.swift
//  fitnes
//
//  Created by Vitali on 9/13/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import TrainingProgramm

class ExercisesViewModuleConfigurator {
    func create(insets: UIEdgeInsets, router: Router) -> ExercisesViewController {
        let vc = ExercisesViewController(contentInset: insets)
        let viewModel = ExercisesViewModel(router: router, service: .shared)
        vc.viewModel = viewModel
        return vc
    }
}
