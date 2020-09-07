//
//  AthleteProfileModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct AthelteProfileModel {
    var description: String?
    var userData: String?
}

var athleteProfileModel: [AthelteProfileModel] = [
    AthelteProfileModel(description: "Имя", userData: apiGetUserModel.firstName),
    AthelteProfileModel(description: "Фамилия", userData: apiGetUserModel.lastName),
    AthelteProfileModel(description: "Почта", userData: apiGetUserModel.email),
    AthelteProfileModel(description: "Телефон", userData: apiGetUserModel.phone),
    AthelteProfileModel(description: "День рождения", userData: apiGetUserModel.birthDate),
    AthelteProfileModel(description: "Пол", userData: apiGetUserModel.sex),
    AthelteProfileModel(description: "Вес (в килограммах)", userData: String(apiGetUserModel.weight ?? 0)),
    AthelteProfileModel(description: "Приседание со штангой на спине", userData: String(apiGetUserModel.backSquat ?? 0)),
    AthelteProfileModel(description: "Приседание со штангой на груди", userData: String(apiGetUserModel.frontSquat ?? 0)),
    AthelteProfileModel(description: "Толчок тяжелоатлетический", userData: String(apiGetUserModel.cleanAndJerk ?? 0)),
    AthelteProfileModel(description: "Рывок тяжелоатлетический", userData: String(apiGetUserModel.snatch ?? 0)),
    AthelteProfileModel(description: "Жим лежа", userData: String(apiGetUserModel.benchPress ?? 0)),
    AthelteProfileModel(description: "Одноповторный максимум в уп soражнении «Становая тяга»", userData: String(apiGetUserModel.deadlift ?? 0)),
    AthelteProfileModel(description: "Становая тяга", userData: String(apiGetUserModel.deadlift ?? 0))
]
