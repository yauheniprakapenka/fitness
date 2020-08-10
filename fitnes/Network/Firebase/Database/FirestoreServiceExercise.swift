//
//  FirestoreServiceExercise.swift
//  fitnes
//
//  Created by yauheni prakapenka on 19.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

extension FirestoreService {
    
    // MARK: - Получить лист упражнений
    func fetchExercisesList(completion: @escaping () -> Void) {
        let docRef = db.collection("exercises").document(profileInfoModel.uid)
        docRef.getDocument { (document, error) in
            let result = Result {
                try document?.data(as: ExercisesListModel.self)
            }

            switch result {
            case .success(let exercisesList):
                if let exercisesList = exercisesList {
                    exersisesList.currentExercises = exercisesList.currentExercises
                    print("Упражнения профиля: \(exersisesList.currentExercises)")
                    completion()
                } else {
                    print("Document does not exist")
                    completion()
                }

            case .failure(let error):
                print("Error decoding: \(error)")
            }
        }
    }
    
    
    // MARK: - Проверить, существует ли такое название упражнения в листе упражнений
    func isExerciseExist(name: String) -> Bool {
        if exersisesList.currentExercises.contains(where: {$0 == name}) {
            print("Имя упражнения уже существует")
            return true
        }
        
        print("Упражнение не существует. Создаем его.")
        return false
    }
    
    
    // MARK: - Добавить упражнение в лист упражнений
    func addExersiseToList(name: String) {
        exersisesList.currentExercises.append(name)
        
        db.collection("exercises").document(profileInfoModel.uid).setData([
            "currentExercises": exersisesList.currentExercises
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    // MARK: - Сохранить само упражнение
    func saveExercise(name: String, type: String, description: String, equipment: String, videoUrl: String) {
        print(#function)
        db.collection("exercises").document(profileInfoModel.uid).collection(name).document(name).setData([
            "name": name,
            "type": type,
            "description": description,
            "equipment": equipment,
            "videoUrl": videoUrl
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    // MARK: - Получить все упражнения
    func fetchExercises(list: [String], completion: (() -> Void)? = nil) {
        exerciseModelOld = [ExerciseModelOld]()

        for exercise in list {
            let docRef = db.collection("exercises").document(profileInfoModel.uid).collection(exercise).document(exercise)
            docRef.getDocument { (document, error) in
                let result = Result {
                    try document?.data(as: ExerciseModelOld.self)
                }
                
                switch result {
                case .success(let firestoreExercise):
                    if let firestoreExercise = firestoreExercise {
                        let profileExercise = ExerciseModelOld(
                            name: firestoreExercise.name,
                            type: firestoreExercise.type,
                            description: firestoreExercise.description,
                            equipment: firestoreExercise.equipment,
                            videoUrl: firestoreExercise.videoUrl
                        )
                        exerciseModelOld.append(profileExercise)
                    
                        print("Упражнения профиля: \(exersisesList.currentExercises)")
                      completion?()
                    } else {
                        print("Document does not exist")
                    }
                case .failure(let error):
                    print("Error decoding: \(error)")
                }
            }
        }
    }

}
