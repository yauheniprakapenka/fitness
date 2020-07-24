//
//  ExcersisesViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 19.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ExcersisesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let AddExerciseVC = segue.destination as! AddExerciseViewController
        AddExerciseVC.delegate = self
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "AddExerciseID", sender: nil)
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        updateUI() 
    }
    
}


// MARK: - UI Table View Data Source, UI Table View Delegate
extension ExcersisesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExersiseCell", for: indexPath) as! CustomExerciseTableViewCell
        cell.nameLabel.text = exercises[indexPath.row].name
        cell.descriptionLabel.text = exercises[indexPath.row].description
        cell.typeLabel.text = exercises[indexPath.row].type
        return cell
    }
}


// MARK: - UI Table Height For Row At
extension ExcersisesViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84
    }
}


// MARK: - Add Exercise View Controller Delegate
extension ExcersisesViewController: AddExerciseViewControllerDelegate {
    func updateUI() {
        FirestoreService.shared.fetchExercisesList() {
            FirestoreService.shared.fetchExercises(userListExercises: exersisesList.currentExercises)
        }
      
        self.tableView.reloadData()
    }

}
