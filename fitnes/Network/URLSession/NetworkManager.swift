//
//  NetworkManager.swift
//  fitnes
//
//  Created by yauheni prakapenka on 30.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseURL = "https://crossfit-api-2020.herokuapp.com"
    let registration = "/registration"
    let oauthToken = "/oauth/token"
}
