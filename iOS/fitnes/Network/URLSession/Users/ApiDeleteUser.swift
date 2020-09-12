//
//  ApiDeleteUser.swift
//  fitnes
//
//  Created by yauheni prakapenka on 11.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

extension NetworkManager {
    func deleteUser(completion: (() -> Void)? = nil) {
        
        let url = URL(string: baseURL + users + GetUserId.getUserId())
        guard let requestUrl = url else { return }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let accessToken = "Bearer \(apiTokenModel.accessToken ?? "missingToken")"
        request.setValue(accessToken, forHTTPHeaderField: "authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response else {
                return
            }
            print(response)
            
            do {
                completion?()
            }
        }
        task.resume()
    }
}
