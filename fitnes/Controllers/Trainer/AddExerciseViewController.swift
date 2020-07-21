//
//  AddExerciseViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 19.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class AddExerciseViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionLabel: UITextField!
    @IBOutlet var equipmentLabel: UITextField!
    @IBOutlet var typeLabel: UITextField!
    @IBOutlet var videoUrlLabel: UITextField!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        FirestoreService.shared.fetchExercisesList() { }
        
        if FirestoreService.shared.isExerciseInListExist(name: nameTextField.text ?? "") {
            showAlert(title: "", message: "Такое название упражнения уже существует. Придумайте новое.")
        } else {
            FirestoreService.shared.saveExercise(name: nameTextField.text ?? "",
                                                 type: typeLabel.text ?? "",
                                                 description: descriptionLabel.text ?? "",
                                                 equipment: equipmentLabel.text ?? "",
                                                 videoUrl: videoUrlLabel.text ?? "")
            
            FirestoreService.shared.addExersiseToList(name: nameTextField.text ?? "")
            
            
        }
    }
}
