//
//  FitnesErrorEnum.swift
//  fitnes
//
//  Created by yauheni prakapenka on 30.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

enum ApiErrorEnum: String, Error {
    case userExist = "Пользователь уже существует"
    case passwordDoesNotMatch = "Пароли не совпадают"
    case incorrectPasswordLength = "Длина пароля от 4 до 8 символов"
    case invalidGrant = "Неверно указан email или пароль"
    case invalidPassword = "Неверно указан пароль"
}
