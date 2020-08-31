//
//  TrainingExcercisesStubData.swift
//  PrototypingProject
//
//  Created by Vitali on 8/30/20.
//

import Foundation

class TrainingExcercisesStubData {
    static let timeItems = [1, 2, 5, 10, 16, 20]
    
    static let exerciseItemTopContent: TPExerciseItemContentView.ViewModel =
        .topContent(topTitle: "Что-то", mainTitle: "Что-то надо сделать", checkboxStatus: true)
    
    static let exerciseItemLeftBottomTitles: TPExerciseItemContentView.ViewModel =
        .withBottomContentOnlyLeftSubitem(topTitle: "Что-то",
                                          mainTitle: "Что-то надо сделать",
                                          leftSubtitle: "Как делать", letfDescription: "Неизвестно", videoPreviewImage: Asset.PrototypingProject.StudDataImages.prototypingProjectStubImagesCat.image,
                                          checkboxStatus: false)
    
    static let exerciseItemFull: TPExerciseItemContentView.ViewModel =
        .fullContent(topTitle: "Что-то",
                     mainTitle: "Что-то надо сделать",
                     leftSubtitle: "Как делать",
                     letfDescription: "Неизвестно",
                     rightSubtitle: "Что делать?",
                     rightDescription: "Погладить кота",
                     videoPreviewImage: Asset.PrototypingProject.StudDataImages.prototypingProjectStubImagesCat.image,
                     checkboxStatus: false)
}
