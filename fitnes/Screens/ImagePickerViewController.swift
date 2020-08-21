//
//  ImagePickerViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 20.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

protocol PhotoViewControllerDelegate {
    func addPhoto(image: UIImage)
}

class PhotoViewController: UIViewController {
    
    let placeImage = UIImageView()
    let addImageButton = FButtonSimple(title: "Выберите фото с местом проведения", titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), size: 18)
    
    var delegate: PhotoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.3848997056, green: 0.5940957665, blue: 0.9974791408, alpha: 1)
        
        configurePlaceImage()
        configureAddImageButton()
    }
    
    private func configurePlaceImage() {
        view.addSubview(placeImage)
        placeImage.translatesAutoresizingMaskIntoConstraints = false
        placeImage.contentMode = .scaleAspectFill
        placeImage.image = #imageLiteral(resourceName: "basket_full")
        
        placeImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        placeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        placeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        placeImage.heightAnchor.constraint(equalToConstant: view.frame.size.height/2).isActive = true
    }
    
    private func configureAddImageButton() {
        view.addSubview(addImageButton)
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        addImageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        addImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addImageButton.heightAnchor.constraint(equalToConstant: view.frame.size.height/2).isActive = true
        
        addImageButton.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func addImageButtonTapped() {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        present(image, animated: true)
    }
    
}

extension PhotoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            dismiss(animated: true)
            return
        }
        
        delegate?.addPhoto(image: image)
    }
}
