//
//  Validator.swift
//  fitnes
//
//  Created by yauheni prakapenka on 16.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

class EmailValidation {
    static let shared = EmailValidation()
    
    func isEmail(email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}

