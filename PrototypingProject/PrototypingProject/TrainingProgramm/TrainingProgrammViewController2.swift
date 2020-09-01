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
    
    @IBOutlet weak var checkboxView: TPSquaredCheckboxView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textInputView.viewDelegate = self
        timePickerView.viewDelegate = self
        dropdownList.viewPickerDelegate = self
        checkboxView.viewDelegate = self
    }
}

extension TrainingProgrammViewController2: TPTextInputViewDelegate {
    func tpTextInputViewShouldReturn(_ sender: TPTextInputView) -> Bool {
        return true
    }
    
    func tpTextInputViewDidBeginEditing(_ sender: TPTextInputView) {
        
    }
    
    func tpTextInputViewDidEndEditing(_ sender: TPTextInputView, byReturn: Bool) {
        
    }
    
    func tpTextInputViewTextChanged(_ sender: TPTextInputView, changedText: String?) {
        
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

extension TrainingProgrammViewController2: TPDropdownListPickerDelegate {
    func tpDropdownList(_ sender: TPDropdownList, selectedTextInputItem item: String?) {}
    func tpDropdownList(_ sender: TPDropdownList, openStatusChanged isOpened: Bool) {}
    
    func tpDropdownList(_ sender: TPDropdownList, selectedItemAtIndex index: Int) {}
    
    func tpDropdownListItems(_ sender: TPDropdownList) -> [String] {
        return TrainingExcercisesStubData.trainingInventoryDropdown
    }
    
    func tpDropdownListConstraintAndRelativeViewToAnimateHeightChange(_ sender: TPDropdownList) -> (NSLayoutConstraint, UIView)? {
        return (dropdownListHeightConstraint, view)
    }
}

extension TrainingProgrammViewController2: TPSquaredCheckboxViewDelegate {
    func tpSquaredCheckboxView(_ sender: TPSquaredCheckboxView, statusChanged isChecked: Bool) {
        
    }
}
