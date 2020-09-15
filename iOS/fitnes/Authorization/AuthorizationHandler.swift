//
//  AuthorizationHandler.swift
//  fitnes
//
//  Created by Vitali on 9/13/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation
import TrainingProgramm

class AuthorizationHandler {
    private init() {}
    static let shared = AuthorizationHandler()
        
    func userAuthorized(token: String) {
        TPExercisesService.shared.initialize(withAuthorizationToken: token)
        TPTrainingService.shared.initialize(withAuthorizationToken: token)
    }
}
