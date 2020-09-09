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
        //listView.viewDelegate = self
        //listView.refreshData()
    }
}

extension TrainingProgrammViewController3: TPTrainingSectionsItemListViewDelegate {
    func tpTrainingSectionsItemListViewItems(_ sender: TPTrainingSectionsItemListView) -> [String] {
        return ["Раз", "Раз", "Раз"]
    }
}
