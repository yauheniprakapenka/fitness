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
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var criteriaTextField: UITextField!
    @IBOutlet var inventoryTextField: UITextField!
    @IBOutlet var urlVideoTextField: UITextField!
    @IBOutlet var exerciseTypeTextField: UITextField!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        FirestoreService.shared.getExercises()
        
        if FirestoreService.shared.isExerciseExist(name: nameTextField.text ?? "") {
            showAlert(title: "", message: "Такое название упражнения уже существует. Придумайте новое.")
        } else {
            FirestoreService.shared.saveExercise(name: nameTextField.text ?? "",
                                                 description: descriptionTextField.text ?? "",
                                                 criteria: criteriaTextField.text ?? "",
                                                 inventory: inventoryTextField.text ?? "",
                                                 urlVideo: urlVideoTextField.text ?? "",
                                                 exerciseType: exerciseTypeTextField.text ?? "")
            
            FirestoreService.shared.addExersiseToExersises(name: nameTextField.text ?? "")
        }
    }
}
