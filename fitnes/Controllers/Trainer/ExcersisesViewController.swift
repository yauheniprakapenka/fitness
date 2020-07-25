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
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddExerciseViewController
        vc.delegate = self
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "AddExercise", sender: nil)
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        updateUI()
    }
}


// MARK: - Add Exercise View Controller Delegate
extension ExcersisesViewController: AddExerciseViewControllerDelegate {
    internal func updateUI() {
        FirestoreService.shared.fetchExercisesList() {
            FirestoreService.shared.fetchExercises(list: exersisesList.currentExercises) {
                self.tableView.reloadData()
            }
        }
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


// MARK: - Did Select Row At indexPath
extension ExcersisesViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exercise = exercises[indexPath.row]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let exerciseVC = storyBoard.instantiateViewController(withIdentifier: "SelectedExerciseVC") as! ExerciseViewController
        exerciseVC.exercise = exercise
        present(exerciseVC, animated: true, completion: nil)
    }
}
