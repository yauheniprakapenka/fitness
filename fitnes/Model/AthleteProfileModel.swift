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

var athelteProfileModel: [AthelteProfileModel] = [
    AthelteProfileModel(description: "Имя", userData: "Mickey"),
    AthelteProfileModel(description: "Фамилия", userData: "Mouse"),
    AthelteProfileModel(description: "Почта", userData: "mickey@mouse.com"),
    AthelteProfileModel(description: "Телефон", userData: "79262001813"),
    AthelteProfileModel(description: "День рождения", userData: "29.02.2012"),
    AthelteProfileModel(description: "Пол", userData: "Мужской"),
    AthelteProfileModel(description: "Вес (в килограммах)", userData: "64"),
    AthelteProfileModel(description: "Приседание со штангой на спине", userData: "6"),
    AthelteProfileModel(description: "Приседание со штангой на груди", userData: "4"),
    AthelteProfileModel(description: "Толчок тяжелоатлетический", userData: "3"),
    AthelteProfileModel(description: "Рывок тяжелоатлетический", userData: "8"),
    AthelteProfileModel(description: "Жим лежа", userData: "9"),
    AthelteProfileModel(description: "Становая тяга", userData: "12"),
    AthelteProfileModel(description: "Становая тяга", userData: "5"),
    AthelteProfileModel(description: "Объект, хранящий информацию об абонементах", userData: "53"),
    AthelteProfileModel(description: "Идентификатор тренера, у которого куплен абонемент", userData: "4"),
    AthelteProfileModel(description: "Время покупки абонемента", userData: "55"),
    AthelteProfileModel(description: "Продолжительность (в днях)", userData: "22"),
    AthelteProfileModel(description: "Количество посещений", userData: "213"),
    AthelteProfileModel(description: "Цена (в рублях)", userData: "222"),
    AthelteProfileModel(description: "Посещения тренировок по текущему абонементу", userData: "32"),
    AthelteProfileModel(description: "Время списания занятия (с помощью qr)", userData: "123")
]
