//
//  FetchYoutubePreviewImage.swift
//  fitnes
//
//  Created by yauheni prakapenka on 10.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FetchYoutubePreviewImage {
    
    // MARK: - Public properties
    
    static let shared = FetchYoutubePreviewImage()
    
    // MARK: - Public methods
    
    func fetchImage(youtubeUrl: String, completion: @escaping (UIImage) -> Void) {
        let videoId = GetIdFromYoutubeUrl.shared.getId(youtubeUrl: youtubeUrl)
        
        let previewUrl = "http://img.youtube.com/vi/\(videoId)/maxresdefault.jpg"
        
        guard let url = URL(string: previewUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            completion(image)
        }
        task.resume()
    }
}
