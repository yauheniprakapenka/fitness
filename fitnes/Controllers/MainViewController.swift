//
//  MainViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 27.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    
    @IBAction func qrButtonTapped(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "qrCodeId") as! QRViewController
        
        present(vc, animated: true)
    }
    
    
}
