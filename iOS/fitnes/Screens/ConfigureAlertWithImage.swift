//
//  ConfigureAlertWithImage.swift
//  fitnes
//
//  Created by yauheni prakapenka on 14.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//
//swiftlint:disable function_body_length

import UIKit

extension ProfileViewController {
    
    func configureAlertWithImage(apiName: String) {
        switch apiName {
        case "weight":
            alertVC = AlertWithImageViewController(title: "",
                                                   description: "Укажите ваш вес",
                                                   placeholder: "Например, 55 кг",
                                                   image: #imageLiteral(resourceName: "measure-type"),
                                                   position: .center)
        case "backSquat":
            alertVC = AlertWithImageViewController(title: "",
                                                   description: "Максимальный вес приседания со штангой на спине",
                                                   placeholder: "Например, 80 кг",
                                                   image: #imageLiteral(resourceName: "barbell-sit"),
                                                   position: .center)
        case "frontSquat":
            alertVC = AlertWithImageViewController(title: "",
                                                   description: "Максимальный вес приседания со штангой на груди",
                                                   placeholder: "Например, 55 кг",
                                                   image: #imageLiteral(resourceName: "frontSquat"),
                                                   position: .center)
        case "snatch":
            alertVC = AlertWithImageViewController(title: "",
                                                   description: "Максимальный вес рывка тяжелоатлетического",
                                                   placeholder: "Например, 55 кг",
                                                   image: #imageLiteral(resourceName: "snatch"),
                                                   position: .center)
        case "phone":
            alertVC = AlertWithImageViewController(title: "",
                                                   description: "Позволит тренеру связаться с вами",
                                                   placeholder: "Например, 7 916 901 80 59",
                                                   image: #imageLiteral(resourceName: "phone"),
                                                   position: .center)
        case "deadlift":
            alertVC = AlertWithImageViewController(title: "",
                                                   description: "Максимальный вес становой тяги",
                                                   placeholder: "Например, 90 кг",
                                                   image: #imageLiteral(resourceName: "deadlift"),
                                                   position: .center)
        case "overheadPress":
            alertVC = AlertWithImageViewController(title: "",
                                                   description: "Максимальный вес жима стоя",
                                                   placeholder: "Например, 60 кг",
                                                   image: #imageLiteral(resourceName: "overheadPress"),
                                                   position: .center)
        case "benchPress":
            alertVC = AlertWithImageViewController(title: "",
                                                   description: "Максимальный вес жима лежа",
                                                   placeholder: "Например, 60 кг",
                                                   image: #imageLiteral(resourceName: "benchPress"),
                                                   position: .center)
        case "clean_and_jerk":
            alertVC = AlertWithImageViewController(title: "",
                                                   description: "Максимальный вес рывка тяжелоатлетического",
                                                   placeholder: "Например, 60 кг",
                                                   image: #imageLiteral(resourceName: "clean_and_jerk"),
                                                   position: .center)
        case "first_name":
            alertVC = AlertWithImageViewController(title: "",
                                                   description: "Укажите ваше имя",
                                                   placeholder: "Например, Артем Ходос",
                                                   image: #imageLiteral(resourceName: "first_name"),
                                                   position: .center)
        case "description":
            alertVC = AlertWithImageViewController(title: "",
                                                   description: "Вашу подпись будут видеть все посетители",
                                                   placeholder: "Например, у меня лапки",
                                                   image: #imageLiteral(resourceName: "description"),
                                                   position: .center)
        case "birthDate":
            alertVC = AlertWithImageViewController(title: "",
                                                   description: "В этот день вы появились на свет",
                                                   placeholder: "Например, у меня лапки",
                                                   image: #imageLiteral(resourceName: "birthDate"),
                                                   position: .center)
        default:
            fatalError("Error: unknown api name \"\(apiName)\" for configure alert with image")
        }
    }
}
