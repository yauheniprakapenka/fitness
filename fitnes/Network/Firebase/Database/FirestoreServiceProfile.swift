//
//  FirestoreServiceProfile.swift
//  fitnes
//
//  Created by yauheni prakapenka on 19.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

extension FirestoreService {
    
    func saveProfile(email: String, uid: String, lastName: String, firstName: String, role: RoleEnum?) {
        db.collection("users").document(profileInfoModel.uid).setData([
            "email": email,
            "uid": uid,
            "lastName": lastName,
            "firstName": firstName,
            "role": ConverterRoleToString.shared.fromEnumToString(role: role)
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func fetchProfile(completion: @escaping () -> Void) {
        let docRef = db.collection("users").document(profileInfoModel.uid)
        
        docRef.getDocument { (document, error) in
            let result = Result {
                try document?.data(as: ProfileInfoModel.self)
            }
            
            switch result {
            case .success(let userFromFirestore):
                if let userFromFirestore = userFromFirestore {
                    print("Document exist")
                    profileInfoModel.email = userFromFirestore.email
                    profileInfoModel.uid = userFromFirestore.uid
                    profileInfoModel.lastName = userFromFirestore.lastName
                    profileInfoModel.firstName = userFromFirestore.firstName
                    profileInfoModel.role = userFromFirestore.role
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
