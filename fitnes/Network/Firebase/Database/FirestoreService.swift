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
}
