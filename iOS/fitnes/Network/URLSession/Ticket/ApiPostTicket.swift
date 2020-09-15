//
//  ApiPostTicket.swift
//  fitnes
//
//  Created by yauheni prakapenka on 12.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func postTicket(completion: (() -> Void)? = nil) {
        
        let url = URL(string: baseURL + ticket)
        guard let requestUrl = url else { return }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let jsonString = "{\"duration\":30,\"visits\":12,\"price\":58,\"create\":true,\"buy\":false}"
        request.httpBody = jsonString.data(using: String.Encoding.utf8)
        
        let accessToken = "Bearer \(apiTokenModel.accessToken ?? "missingToken")"
        request.setValue(accessToken, forHTTPHeaderField: "authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let userResponse = try decoder.decode(ApiPostTicketModel.self, from: data)
                print(userResponse)
                apiPostTicketModel = userResponse
                completion?()
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
