//
//  TrainingProgrammViewController3.swift
//  PrototypingProject
//
//  Created by Vitali on 9/5/20.
//

import UIKit

class TrainingProgrammViewController3: UIViewController {
    
    @IBOutlet weak var listView: TPTrainingView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let exercises = [
            TPExercise(name: "Прыжки", inventory: nil, description: nil, video: nil),
            TPExercise(name: "Кувырки", inventory: nil, description: nil, video: nil),
            TPExercise(name: "Подтягивания", inventory: nil, description: nil, video: nil),
        ]
        listView.configure(withAllowedExercises: exercises)
        
        //listView.viewDelegate = self
        //listView.refreshData()
    }
}

extension TrainingProgrammViewController3: TPTrainingSectionsItemListViewDelegate {
    func tpTrainingSectionsItemListViewItems(_ sender: TPTrainingSectionsItemListView) -> [String] {
        return ["Раз", "Раз", "Раз"]
    }
}
