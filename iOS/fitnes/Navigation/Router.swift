//
//  Router.swift
//  fitnes
//
//  Created by Vitali on 9/13/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class Router {
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.isNavigationBarHidden = true
    }
    
    
    func push(vc: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(vc, animated: animated)
    }
    func popCurrent(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}
