//
//  ApiGetTicket.swift
//  fitnes
//
//  Created by yauheni prakapenka on 12.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

extension NetworkManager {
    
    func getTicket(completion: (() -> Void)? = nil) {
        
        let url = URL(string: baseURL + ticket + String(1))
        guard let requestUrl = url else { return }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
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
                let userResponse = try decoder.decode(ApiGetTicketModel.self, from: data)
                print(userResponse)
                apiGetTicketModel = userResponse
                print(apiGetTicketModel)
                completion?()
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
