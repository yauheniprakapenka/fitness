//
//  AddExerciseViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 19.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

protocol AddExerciseViewControllerDelegate {
    func updateUI()
}

class AddExerciseViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var equipmentTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var videoUrlTextField: UITextField!
    
    var delegate: AddExerciseViewControllerDelegate!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let queue = DispatchQueue(label: "test", attributes: .concurrent)
        let semaphore = DispatchSemaphore(value: 1)
        
        queue.async {
            semaphore.wait()
            
            FirestoreService.shared.fetchExercisesList() {
                let isExerciseExistInList = FirestoreService.shared.isExerciseExist(name: self.nameTextField.text!)
                if isExerciseExistInList {
                    self.showAlert(title: "", message: "Имя упражнения уже существует")
                    return
                }
                
                semaphore.signal()
            }
        }
        
        queue.async {
            semaphore.wait()
            
            DispatchQueue.main.async {
                FirestoreService.shared.saveExercise(name: self.nameTextField.text ?? "",
                                                     type: self.typeTextField.text ?? "",
                                                     description: self.descriptionTextField.text ?? "",
                                                     equipment: self.equipmentTextField.text ?? "",
                                                     videoUrl: self.videoUrlTextField.text ?? "")
                
                FirestoreService.shared.addExersiseToList(name: self.nameTextField.text ?? "")
                
                FirestoreService.shared.fetchExercisesList() {
                    FirestoreService.shared.fetchExercises(list: exersisesList.currentExercises, completion: nil)
                }
                
                self.dismiss(animated: true) {
                    self.delegate.updateUI()
                }
            }
            semaphore.signal()
        }
    }
}

