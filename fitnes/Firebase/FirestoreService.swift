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

    func saveProfile(email: String, uid: String) {
        db.collection("users").document(profileInfo.uid).setData([
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
    
    func getProfile(completion: @escaping () -> Void) {
        let docRef = db.collection("users").document(profileInfo.uid)

        docRef.getDocument { (document, error) in
            let result = Result {
                try document?.data(as: ProfileInfoModel.self)
            }
            
            switch result {
            case .success(let firestoreUser):
                if let firestoreUser = firestoreUser {
                    profileInfo.email = firestoreUser.email
                    profileInfo.name = firestoreUser.name
                    profileInfo.uid = firestoreUser.uid
                    completion()
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding city: \(error)")
            }
        }
    }
}

