//
//  ViewController.swift
//  PrototypingProject
//
//  Created by Vitali on 8/29/20.
//

import UIKit

class TrainingProgrammViewController1: UIViewController {
    @IBOutlet weak var timeSelectionView: TPTimeSelectionView!
    @IBOutlet weak var exerciseListView: TPExerciseListView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeSelectionView.viewDelegate = self
        timeSelectionView.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        timeSelectionView.refreshData()
        timeSelectionView.select(at: 0)
        
        exerciseListView.viewDelegate = self
    }
}

extension TrainingProgrammViewController1: TPTimeSelectionViewDelegate {
    func tpTimeSelectionViewItems(_ sender: TPTimeSelectionView) -> [String] {
        return TrainingExcercisesStubData.timeItems.map { String($0) }
    }
    
    func tpTimeSelectionView(_ sender: TPTimeSelectionView, didSelectItemAtIndex index: Int) {
        
    }
}

extension TrainingProgrammViewController1: TPExerciseListViewDelegate {
    func tpExerciseListViewItems(_ sender: TPExerciseListView) -> [TPExerciseListView.ItemViewModel] {
        return [
            TPExerciseListView.ItemViewModel(
                isCheckboxVisible: true,
                itemState: .completed,
                contentViewModel: TrainingExcercisesStubData.exerciseItemFull
            ),
            TPExerciseListView.ItemViewModel(
                isCheckboxVisible: false,
                itemState: .active,
                contentViewModel: TrainingExcercisesStubData.exerciseItemTopContent
            ),
            TPExerciseListView.ItemViewModel(
                isCheckboxVisible: true,
                itemState: .normal,
                contentViewModel: TrainingExcercisesStubData.exerciseItemLeftBottomTitles
            ),
        ]
    }
    
    func tpExerciseListView(_ sender: TPExerciseListView, didTapVideoPreviewAtIndex index: Int) {
        
    }
    
    func tpExerciseListView(_ sender: TPExerciseListView, didChangeCheckboxStatusAtIndex index: Int, status: Bool) {
        
    }
}
