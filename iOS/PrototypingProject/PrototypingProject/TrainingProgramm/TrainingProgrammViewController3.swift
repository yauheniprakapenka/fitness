//
//  TrainingProgrammViewController3.swift
//  PrototypingProject
//
//  Created by Vitali on 9/5/20.
//

import UIKit

class TrainingProgrammViewController3: UIViewController {
    
    @IBOutlet weak var listView: TPTrainingView!
    @IBOutlet weak var addSectionFloatingView: TPTrainingAddEntityView!
    @IBOutlet weak var addSectionFloatingViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var floatingViewContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let exercises = [
            TPExercise(name: "Прыжки", inventory: nil, description: nil, video: nil),
            TPExercise(name: "Кувырки", inventory: nil, description: nil, video: nil),
            TPExercise(name: "Подтягивания", inventory: nil, description: nil, video: nil),
        ]
        listView.configure(withAllowedExercises: exercises)
        listView.viewDelegate = self
        addSectionFloatingView.viewDelegate = self
        addSectionFloatingView.isHidden = false
        addSectionFloatingViewTopConstraint.constant -= 50
        floatingViewContainerView.clipsToBounds = true
        //listView.viewDelegate = self
        //listView.refreshData()
    }
}

private extension TrainingProgrammViewController3 {
    func animateFloatingView(isVisible: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            
            let delta: CGFloat = isVisible ? 50 : -50
            self.addSectionFloatingViewTopConstraint.constant += delta
            self.view.layoutIfNeeded()
            
        }, completion: { _ in })
    }
}

extension TrainingProgrammViewController3: TPTrainingViewDelegate {
    func tpTrainingViewTrainingChanged(_ sender: TPTrainingView, training: TPTraining) {
        
    }
    
    func tpTrainingViewAddSectionVisibilityChange(_ sender: TPTrainingView, isVisible: Bool) {
        animateFloatingView(isVisible: !isVisible)
    }
}

extension TrainingProgrammViewController3: TPTrainingAddEntityViewDelegate {
    func tpTrainingAddEntityViewButtonDidTap(_ sender: TPTrainingAddEntityView, userData: [AnyHashable : Any]?) {
        listView.addSection()
    }
}
