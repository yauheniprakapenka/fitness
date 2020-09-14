//
//  TrainerModuleConfigrator.swift
//  fitnes
//
//  Created by Vitali on 9/14/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

class TrainerModuleConfigrator {
    var router: Router
    
    init(with router: Router) {
        self.router = router
    }
    
    func create() -> TrainerViewController {
        let vc = TrainerViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.router = router
        return vc
    }
}
