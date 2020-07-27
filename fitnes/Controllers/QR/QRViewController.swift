//
//  GenerateQR.swift
//  fitnes
//
//  Created by yauheni prakapenka on 27.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class QRViewController: UIViewController {
    
    @IBOutlet var qrImageView: UIImageView!
    
    @IBAction func generateQRButtonTapped(_ sender: Any) {
        let image = generateQRCode(string: "Hacking with Swift is the best iOS coding tutorial I've ever read!")
        
        qrImageView.image = image
    }
    
    private func generateQRCode(string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
