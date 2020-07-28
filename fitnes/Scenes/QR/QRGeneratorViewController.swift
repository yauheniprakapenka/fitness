//
//  GenerateQR.swift
//  fitnes
//
//  Created by yauheni prakapenka on 27.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class QRGeneratorViewController: UIViewController {
    
    @IBOutlet var qrImageView: UIImageView!
    
    @IBAction func generateQRButtonTapped(_ sender: Any) {
        let image = generateQRCode(string: "Hello World")
        
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
