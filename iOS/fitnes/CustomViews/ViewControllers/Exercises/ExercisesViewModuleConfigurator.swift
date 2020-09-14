//
//  ExercisesViewModuleConfigurator.swift
//  fitnes
//
//  Created by Vitali on 9/13/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import TrainingProgramm
import Common

class ExercisesViewModuleConfigurator {
    private var insets: UIEdgeInsets
    private var router: Router
    private var activityIndicator: ActivityIndicatorProtocol
    
    init(
        insets: UIEdgeInsets,
        router: Router,
        indicator: ActivityIndicatorProtocol
    ) {
        self.insets = insets
        self.router = router
        self.activityIndicator = indicator
    }
    
    func create() -> ExercisesViewController {
        let vc = ExercisesViewController(contentInset: insets)
        vc.activityIndicator = activityIndicator
        let viewModel = ExercisesViewModel(router: router, service: .shared)
        vc.viewModel = viewModel
        return vc
    }
}
