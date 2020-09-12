//
//  GetStubAvatarImage.swift
//  fitnes
//
//  Created by yauheni prakapenka on 12.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class GetStubAvatarImage {
    
    static let shared = GetStubAvatarImage()
    
    func getImage() -> UIImage {
        let avatar: [UIImage] = [#imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.43"), #imageLiteral(resourceName: "Screenshot 08-08-2020 14.29.10"), #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.59-1"), #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.21"), #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.34"), #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.27"), #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.21"), #imageLiteral(resourceName: "Screenshot 09-12-2020 14.44.49"), #imageLiteral(resourceName: "fitnes-girl")]
        let random = Int.random(in: 0...avatar.count - 1)
        return avatar[random]
    }
}
