//
//  FirestoreServiceExercise.swift
//  fitnes
//
//  Created by yauheni prakapenka on 19.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

extension FirestoreService {
    
    func getExercises() {
        let docRef = db.collection("exercises").document(profileInfo.uid)
        
        docRef.getDocument { (document, error) in
            let result = Result {
                try document?.data(as: AllExercisesModel.self)
            }
            
            switch result {
            case .success(let firestoreTrainer):
                if let firestoreExercisesModel = firestoreTrainer {
                    allExercises.exercises = firestoreExercisesModel.exercises
                    print(allExercises.exercises)
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding: \(error)")
            }
        }
    }
    
    func isExerciseExist(name: String) -> Bool {
        if allExercises.exercises.contains(where: {$0 == name}) {
            print("Exersise is exists")
            return true
        }
        
        print("Exersise is not exists, create it.")
        return false
    }
    
    func addExersiseToExersises(name: String) {
        print(allExercises.exercises)
        allExercises.exercises.append(name)
        print(allExercises.exercises)
        
        db.collection("exercises").document(profileInfo.uid).setData([
            "exercises": allExercises.exercises
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func saveExercise(name: String, description: String, criteria: String, inventory: String, urlVideo: String, exerciseType: String) {
        db.collection("exercises").document(profileInfo.uid).collection(name).document(name).setData([
            "name": name,
            "description": description,
            "criteria": criteria,
            "inventory": inventory,
            "urlVideo": urlVideo,
            "exerciseType": exerciseType
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}
