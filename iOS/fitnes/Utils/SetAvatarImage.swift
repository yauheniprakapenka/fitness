//
//  SetAvatarImage.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class SetAvatarImage {
    
    static let shared = SetAvatarImage()
    
    func set(imageView: UIImageView) {
        if let avatar = apiGetUserModel.avatar {
            let image = Base64Converter.shared.stringToImage(imageBase64String: avatar)
            imageView.image = image
        } else {
            imageView.image = #imageLiteral(resourceName: "fitnes-girl")
        }
    }
}
