//
//  DefineRoleAndPresentViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 20.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

//import UIKit
//
//class DefineRole: UIViewController {
//    
//    static let shared = DefineRole()
//    
//    func defineRole() -> ProfileRoleEnum {
//        
//        switch profileInfoModel.role {
//        case "Athlete":
//            let vc = self.storyboard!.instantiateViewController(withIdentifier: "AthleteVC") as! AthleteViewController
//            let navController = UINavigationController(rootViewController: vc)
//            self.present(navController, animated:true)
//        case "Trainer":
//            DispatchQueue.main.async {
//                let vc = ProfileViewController()
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true)
//            }
//            
//            let vc = self.storyboard!.instantiateViewController(withIdentifier: "containerID") as! ContainerViewController
//            self.present(vc, animated: true)
//            
//        default:
//            print("Роль не найдена")
//        }
//        
//        
//    }
//}
