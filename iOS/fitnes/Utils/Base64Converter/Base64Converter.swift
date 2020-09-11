//
//  Base64Converter.swift
//  fitnes
//
//  Created by yauheni prakapenka on 07.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class Base64Converter {
    
    static let shared = Base64Converter()
    
    func stringToImage (imageBase64String: String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    
    func imageToString (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
}
