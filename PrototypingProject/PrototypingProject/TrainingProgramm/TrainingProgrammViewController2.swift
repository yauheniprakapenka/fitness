//
//  TrainingProgrammViewController2.swift
//  PrototypingProject
//
//  Created by Vitali on 8/31/20.
//

class TrainingProgrammViewController2: UIViewController {
    
    @IBOutlet weak var timePickerView: TPTimePickerView!
    
    @IBOutlet weak var timePickerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textInputView: TPTextInputView!
    
    @IBOutlet weak var dropdownList: TPDropdownList!
    @IBOutlet weak var dropdownListHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePickerView.viewDelegate = self
        dropdownList.viewDelegate = self
        
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

extension TrainingProgrammViewController2: TPDropdownListDelegate {
    func tpDropdownList(_ sender: TPDropdownList, openStatusChanged isOpened: Bool) {}
    
    func tpDropdownList(_ sender: TPDropdownList, selectedItemAtIndex index: Int) {}
    
    func tpDropdownListItems(_ sender: TPDropdownList) -> [String] {
        return TrainingExcercisesStubData.trainingInventoryDropdown
    }
    
    func tpDropdownListConstraintAndRelativeViewToAnimateHeightChange(_ sender: TPDropdownList) -> (NSLayoutConstraint, UIView)? {
        return (dropdownListHeightConstraint, view)
    }
    
    func tpDropdownListDidBeginEditing(_ sender: TPDropdownList) {}
    
    func tpDropdownListDidEndEditing(_ sender: TPDropdownList, byReturn: Bool) {}
    
    func tpDropdowList(_ sender: TPDropdownList, textChanged text: String?) {}
    
    func tpDropdownListShouldReturn(_ sender: TPDropdownList) -> Bool {
        return true
    }
}
