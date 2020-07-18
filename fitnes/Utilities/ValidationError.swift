//
//  ValidationError.swift
//  fitnes
//
//  Created by yauheni prakapenka on 16.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

enum ValidationError {
    case fieldIisNodFilled
    case invalidEmail
    case passwordMismatch
}

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .fieldIisNodFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Неверно указана почта", comment: "")
        case .passwordMismatch:
            return NSLocalizedString("Пароли не совпадают", comment: "")
        }
    }
}
