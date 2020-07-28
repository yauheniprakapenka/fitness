//
//  NewInventoryViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 14.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class AddInventoryViewController: UITableViewController {
    
    var newPlace: InventoryModel?

    @IBOutlet var inventoryImage: UIImageView!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        
        titleTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @objc private func textFieldChanged() {
        saveButton.isEnabled = titleTextField.text!.isEmpty ? false : true
    }
    
    func saveNewInventory() {
        newPlace = InventoryModel(logoImageView: inventoryImage.image ?? #imageLiteral(resourceName: "default"),
                                  titleLabel: titleTextField.text ?? "",
                                  descriptionLabel: descriptionTextField.text ?? "")
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}


// MARK: - Text field delegate

extension AddInventoryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: - Did Select Row At indexPath

extension AddInventoryViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            
            let photo = UIAlertAction(title: "Photo", style: .default) { (_) in
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
                
            }
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
    
}

// MARK: - UI ImagePicker Controller

extension AddInventoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        inventoryImage.image = info[.editedImage] as? UIImage
        inventoryImage.contentMode = .scaleAspectFill
        inventoryImage.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
}
