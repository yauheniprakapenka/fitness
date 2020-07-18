//
//  FirestoreService.swift
//  fitnes
//
//  Created by yauheni prakapenka on 17.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

let db = Firestore.firestore()

class FirestoreService {
    
    static let shared = FirestoreService()

    func saveUser(email: String, uid: String) {
        db.collection("users").document(fitnesUser.uid).setData([
            "email": email,
            "uid": uid,
            "name": "",
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func getData() {
        let docRef = db.collection("users").document(fitnesUser.uid)

        docRef.getDocument { (document, error) in
            let result = Result {
                try document?.data(as: FitnesUser.self)
            }
            
            switch result {
            case .success(let firestoreUser):
                if let firestoreUser = firestoreUser {
                    fitnesUser.email = firestoreUser.email
                    fitnesUser.name = firestoreUser.name
                    fitnesUser.uid = firestoreUser.uid
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding city: \(error)")
            }
        }
    }
    
}

