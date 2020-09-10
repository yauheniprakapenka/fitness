//
//  AthleteProfileModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct AthelteProfileModel {
    var description: String?
    var userDataString: String?
    var userDataInt: Int?
    var apiName: String?
    var typeData: TypeData
}

var athleteProfileModel: [AthelteProfileModel] = []

func updateProfileModel() {
    athleteProfileModel = [
        AthelteProfileModel(description: "Имя", userDataString: apiGetUserModel.firstName, apiName: "first_name", typeData: .string),
        AthelteProfileModel(description: "Подпись", userDataString: apiGetUserModel.description, apiName: "description", typeData: .string),
        AthelteProfileModel(description: "Почта", userDataString: apiGetUserModel.email, apiName: "email", typeData: .string),
        AthelteProfileModel(description: "Телефон", userDataString: apiGetUserModel.phone, apiName: "phone", typeData: .string),
        AthelteProfileModel(description: "День рождения", userDataString: apiGetUserModel.birthDate, apiName: "birthDate", typeData: .string),
        AthelteProfileModel(description: "Пол", userDataString: apiGetUserModel.sex, apiName: "sex", typeData: .string),
        AthelteProfileModel(description: "Вес (в килограммах)", userDataInt: apiGetUserModel.weight, apiName: "weight", typeData: .int),
        AthelteProfileModel(description: "Приседание со штангой на спине", userDataInt: apiGetUserModel.backSquat, apiName: "backSquat", typeData: .int),
        AthelteProfileModel(description: "Приседание со штангой на груди", userDataInt: apiGetUserModel.frontSquat, apiName: "frontSquat", typeData: .int),
        AthelteProfileModel(description: "Толчок тяжелоатлетический", userDataInt: apiGetUserModel.cleanAndJerk, apiName: "clean_and_jerk", typeData: .int),
        AthelteProfileModel(description: "Рывок тяжелоатлетический", userDataInt: apiGetUserModel.snatch, apiName: "snatch", typeData: .int),
        AthelteProfileModel(description: "Жим лежа", userDataInt: apiGetUserModel.benchPress, apiName: "benchPress", typeData: .int),
        AthelteProfileModel(description: "Жим стоя", userDataInt: apiGetUserModel.deadlift, apiName: "deadlift", typeData: .int),
        AthelteProfileModel(description: "Становая тяга", userDataInt: apiGetUserModel.deadlift, apiName: "deadlift", typeData: .int),
    ]
}
