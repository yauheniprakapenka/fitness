//
//  FirestoreServiceProfile.swift
//  fitnes
//
//  Created by yauheni prakapenka on 19.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

extension FirestoreService {
    
    func saveProfile(email: String, uid: String, name: String, phone: String) {
        db.collection("users").document(profileInfo.uid).setData([
            "email": email,
            "uid": uid,
            "name": name,
            "phone": phone
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func fetchProfile(completion: @escaping () -> Void) {
        let docRef = db.collection("users").document(profileInfo.uid)
        
        docRef.getDocument { (document, error) in
            let result = Result {
                try document?.data(as: ProfileInfoModel.self)
            }
            
            switch result {
            case .success(let firestoreUser):
                if let firestoreUser = firestoreUser {
                    print("Document exist")
                    profileInfo.email = firestoreUser.email
                    profileInfo.name = firestoreUser.name
                    profileInfo.uid = firestoreUser.uid
                    profileInfo.phone = firestoreUser.phone
                    completion()
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding: \(error)")
            }
        }
    }
}
