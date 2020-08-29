//
//  ViewController.swift
//  PrototypingProject
//
//  Created by Vitali on 8/29/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeSelectionView: TimeSelectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeSelectionView.viewDelegate = self
        timeSelectionView.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        timeSelectionView.refreshData()
        timeSelectionView.select(at: 0)
    }


}

extension ViewController: TimeSelectionViewDelegate {
    func timeSelectionViewItems(_ sender: TimeSelectionView) -> [String] {
        return TrainingExcercisesStubData.timeItems.map { String($0) }
    }
    
    func timeSelectionView(_ sender: TimeSelectionView, didSelectItemAtIndex index: Int) {
        
    }
    
    
}
