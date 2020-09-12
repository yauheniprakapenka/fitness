//
//  GetStubAvatarImage.swift
//  fitnes
//
//  Created by yauheni prakapenka on 12.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

private var countPeople = -1

class GetStubAvatarImage {
    
    static let shared = GetStubAvatarImage()
    
    func getImage() -> UIImage {
        let avatar: [UIImage] = [#imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.43"), #imageLiteral(resourceName: "Screenshot 08-08-2020 14.29.10"), #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.59-1"), #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.21"), #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.34"), #imageLiteral(resourceName: "Screenshot 09-12-2020 14.44.49"), #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.27"), #imageLiteral(resourceName: "Screenshot 08-08-2020 14.27.36"), #imageLiteral(resourceName: "4c493aa33dc14aaa498cbc38e2993b66"), #imageLiteral(resourceName: "Screenshot 09-12-2020 17.48.46"), #imageLiteral(resourceName: "Screenshot 09-12-2020 17.49.56"), #imageLiteral(resourceName: "Screenshot 09-12-2020 17.51.25"), #imageLiteral(resourceName: "Screenshot 09-12-2020 17.52.31"), #imageLiteral(resourceName: "Screenshot 09-12-2020 17.52.54"), #imageLiteral(resourceName: "photo_2017-09-01_14-29-45")]
        countPeople += 1
        
        if countPeople >= avatar.count {
            countPeople = 0
        }
        
        return avatar[countPeople]
    }
}
