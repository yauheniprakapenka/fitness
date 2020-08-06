//
//  ValidationError.swift
//  fitnes
//
//  Created by yauheni prakapenka on 16.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

enum ValidationError {
    case invalidEmail
    case roleRadioButtonNotSelected
    case lastNameIsEmpty
    case firstNameIsEmpty
    case emailIsEmpty
    case passwordIsEmpty
}

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return NSLocalizedString("Неверно указана почта", comment: "")
        case .roleRadioButtonNotSelected:
            return NSLocalizedString("Выберите роль", comment: "")
        case .lastNameIsEmpty:
            return NSLocalizedString("Заполните фамилию", comment: "")
        case .firstNameIsEmpty:
            return NSLocalizedString("Заполните имя", comment: "")
        case .emailIsEmpty:
            return NSLocalizedString("Заполните email", comment: "")
        case .passwordIsEmpty:
            return NSLocalizedString("Заполните пароль", comment: "")
        }
    }
}
