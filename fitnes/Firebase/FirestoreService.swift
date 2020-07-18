//
//  FirestoreService.swift
//  fitnes
//
//  Created by yauheni prakapenka on 17.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import FirebaseFirestore

let db = Firestore.firestore()

class FirestoreService {
    
    static let shared = FirestoreService()

    func saveUser() {
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "email": fitnesUser.email,
            "uid": fitnesUser.uid,
            "name": "nil"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
}

struct FitnesUser {
    var email: String
    var name: String
    var uid: String
}

var fitnesUser = FitnesUser(email: "", name: "", uid: "")
