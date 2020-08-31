//
//  TrainingProgrammViewController2.swift
//  PrototypingProject
//
//  Created by Vitali on 8/31/20.
//

class TrainingProgrammViewController2: UIViewController {
    
    @IBOutlet weak var expandableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var timePickerView: TPTimePickerView!
    
    @IBOutlet weak var timePickerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textInputView: TPTextInputView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePickerView.viewDelegate = self
        
    }
}

extension TrainingProgrammViewController2: TPTimePickerViewDelegate {
    func tpTimePickerViewConstraintAndRelatedViewToAnimateHeightChange(_ sender: TPTimePickerView) -> (NSLayoutConstraint, UIView)? {
        (timePickerHeightConstraint, view)
    }
    
    func tpTimePickerView(_ sender: TPTimePickerView, openStatusChanged isOpened: Bool) {
        
    }
    
    func tpTimePickerView(_ sender: TPTimePickerView, selectedTimeChanged time: Date) {
        
    }
}
