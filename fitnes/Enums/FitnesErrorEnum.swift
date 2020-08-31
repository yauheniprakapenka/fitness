//
//  FitnesErrorEnum.swift
//  fitnes
//
//  Created by yauheni prakapenka on 30.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

enum FitnesErrorEnum: String, Error {
     case userExist = "Пользователь уже существует"
     case passwordDoesNotMatch = "Пароли не совпадают"
}
