//
//  Validator.swift
//  fitnes
//
//  Created by yauheni prakapenka on 16.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

class Validator {
    
    static let shared = Validator()
}

// MARK: - Registration text fields validation

extension Validator {
    func registerFieldsIsFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let email = email, let password = password, let confirmPassword = confirmPassword, email != "", password != "", confirmPassword != "" else {
            return false
        }
        return true
    }
}

// MARK: - Login text fields validation

extension Validator {
    func loginFieldsIsFilled(email: String?, password: String?) -> Bool {
        guard let email = email, let password = password, email != "", password != "" else {
            return false
        }
        return true
    }
}

// MARK: - Email validation

extension Validator {
    func isSimpleEmail(email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
