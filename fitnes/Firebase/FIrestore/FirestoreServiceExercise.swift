//
//  FirestoreServiceExercise.swift
//  fitnes
//
//  Created by yauheni prakapenka on 19.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

extension FirestoreService {
    
    func fetchExercisesList(completion: @escaping () -> ()) {
        let docRef = db.collection("exercises").document(profileInfo.uid)
        
        docRef.getDocument { (document, error) in
            let result = Result {
                try document?.data(as: ExercisesListModel.self)
            }
            
            switch result {
            case .success(let firestoreTrainer):
                if let firestoreExercisesModel = firestoreTrainer {
                    exersisesList.exercises = firestoreExercisesModel.exercises
                    print("Упражнения профиля: \(exersisesList.exercises)")
                    completion()
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding: \(error)")
            }
        }
    }
    
    func isExerciseInListExist(name: String) -> Bool {
        if exersisesList.exercises.contains(where: {$0 == name}) {
            print("Exersise is exists")
            return true
        }
        
        print("Exersise is not exists, create it.")
        return false
    }
    
    func addExersiseToList(name: String) {
        exersisesList.exercises.append(name)
        
        db.collection("exercises").document(profileInfo.uid).setData([
            "exercises": exersisesList.exercises
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func saveExercise(name: String, type: String, description: String, equipment: String, videoUrl: String) {
        db.collection("exercises").document(profileInfo.uid).collection(name).document(name).setData([
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
    
    func fetchExercises(userListExercises: [String]) {
        exercises = [exerciseModel]()

        for userExercise in userListExercises {
            let docRef = db.collection("exercises").document(profileInfo.uid).collection(userExercise).document(userExercise)
            docRef.getDocument { (document, error) in
                let result = Result {
                    try document?.data(as: exerciseModel.self)
                }
                
                switch result {
                case .success(let firestoreExercise):
                    if let firestoreExercise = firestoreExercise {
                        let profileExercise = exerciseModel(
                            name: firestoreExercise.name,
                            type: firestoreExercise.type,
                            description: firestoreExercise.description,
                            equipment: firestoreExercise.equipment,
                            videoUrl: firestoreExercise.videoUrl
                        )
                        exercises.append(profileExercise)
                        self.countExercises()
                    } else {
                        print("Document does not exist")
                    }
                case .failure(let error):
                    print("Error decoding: \(error)")
                }
            }
        }
    }
    
    private func countExercises() {
        print("Итого \(exercises)")
        print("Итого упражнений: \(exercises.count)")
    }
    
}
