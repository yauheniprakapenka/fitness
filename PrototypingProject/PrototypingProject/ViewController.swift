//
//  ViewController.swift
//  PrototypingProject
//
//  Created by Vitali on 8/29/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeSelectionView: TimeSelectionView!
    @IBOutlet weak var exerciseListView: ExerciseListView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeSelectionView.viewDelegate = self
        timeSelectionView.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        timeSelectionView.refreshData()
        timeSelectionView.select(at: 0)
        
        exerciseListView.viewDelegate = self
    }
}

extension ViewController: TimeSelectionViewDelegate {
    func timeSelectionViewItems(_ sender: TimeSelectionView) -> [String] {
        return TrainingExcercisesStubData.timeItems.map { String($0) }
    }
    
    func timeSelectionView(_ sender: TimeSelectionView, didSelectItemAtIndex index: Int) {
        
    }
}

extension ViewController: ExerciseListViewDelegate {
    func exerciseListViewItems(_ sender: ExerciseListView) -> [ExerciseListView.ItemViewModel] {
        return [
            ExerciseListView.ItemViewModel(
                isCheckboxVisible: true,
                itemState: .completed,
                contentViewModel: TrainingExcercisesStubData.exerciseItemFull
            ),
            ExerciseListView.ItemViewModel(
                isCheckboxVisible: false,
                itemState: .active,
                contentViewModel: TrainingExcercisesStubData.exerciseItemTopContent
            ),
            ExerciseListView.ItemViewModel(
                isCheckboxVisible: true,
                itemState: .normal,
                contentViewModel: TrainingExcercisesStubData.exerciseItemLeftBottomTitles
            ),
        ]
    }
    
    func exerciseListView(_ sender: ExerciseListView, didTapVideoPreviewAtIndex index: Int) {
        
    }
    
    func exerciseListView(_ sender: ExerciseListView, didChangeCheckboxStatusAtIndex index: Int, status: Bool) {
        
    }
}
