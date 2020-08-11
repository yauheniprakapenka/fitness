//
//  GenerateQR.swift
//  fitnes
//
//  Created by yauheni prakapenka on 27.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class QRGeneratorViewController: UIViewController {
    
    let qrImageView = UIImageView()
    let qrButton = FButtonSimple(title: "Создать QR код", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 22)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureQrImageView()
        configureQRbutton()
    }
    
    private func configureQrImageView() {
        view.addSubview(qrImageView)
        qrImageView.contentMode = .scaleAspectFit
        qrImageView.translatesAutoresizingMaskIntoConstraints = false
        qrImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        qrImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        qrImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        qrImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }

    private func configureQRbutton() {
        view.addSubview(qrButton)
        qrButton.topAnchor.constraint(equalTo: qrImageView.bottomAnchor, constant: 20).isActive = true
        qrButton.leadingAnchor.constraint(equalTo: qrImageView.leadingAnchor).isActive = true
        
        qrButton.addTarget(self, action: #selector(generateQRButtonTapped), for: .touchUpInside)
    }
    
    @objc private func generateQRButtonTapped() {
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
