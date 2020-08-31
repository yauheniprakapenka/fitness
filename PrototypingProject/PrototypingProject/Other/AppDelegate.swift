//
//  AppDelegate.swift
//  PrototypingProject
//
//  Created by Vitali on 8/29/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabbarController()
        window?.makeKeyAndVisible()
        return true
    }
}
