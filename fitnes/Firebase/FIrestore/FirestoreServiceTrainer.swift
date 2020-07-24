//
//  FirestoreServiceTrainer.swift
//  fitnes
//
//  Created by yauheni prakapenka on 19.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

extension FirestoreService {
    
    func isTrainerExist(completion: @escaping () -> ()) {
        let docRef = db.collection("trainers").document(profileInfo.uid)
        
        docRef.getDocument { (document, error) in
            let result = Result {
                try document?.data(as: TrainerModel.self)
            }
            
            switch result {
            case .success(let firestoreUser):
                if let firestoreUser = firestoreUser {
                    print("Document exist")
                } else {
//                    print("Document does not exist")
                    completion()
                }
            case .failure(let error):
                print("Error decoding: \(error)")
            }
        }
    }
    
    func createTrainer(uid: String) {
        db.collection("trainers").document(profileInfo.uid).setData([
            "uid": uid,
            "name": ""
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func getTrainer() {
        let docRef = db.collection("trainers").document(profileInfo.uid)
        
        docRef.getDocument { (document, error) in
            let result = Result {
                try document?.data(as: TrainerModel.self)
            }
            
            switch result {
            case .success(let firestoreTrainer):
                if let firestoreTrainer = firestoreTrainer {
                    trainerInfo.uid = firestoreTrainer.uid
                    trainerInfo.name = firestoreTrainer.name
                    print(trainerInfo.uid)
                    print(trainerInfo.name)
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding: \(error)")
            }
        }
    }
}
