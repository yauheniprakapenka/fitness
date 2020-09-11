//
//  UserDefaultStoredPropertyWrapper.swift
//  fitnes
//
//  Created by Vitali on 9/10/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultStored<Value> {
    let key: String
    let defaultValue: Value
    
    var wrappedValue: Value {
        get {
            let value = UserDefaults.standard.value(forKey: key) as? Value
            return value ?? defaultValue
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}


@propertyWrapper
struct UserDefaultStoredNullable<Value> {
    let key: String
    
    var wrappedValue: Value? {
        get {
            return UserDefaults.standard.value(forKey: key) as? Value
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}
