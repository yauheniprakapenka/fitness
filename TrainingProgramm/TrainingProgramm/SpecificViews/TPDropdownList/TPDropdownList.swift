//
//  TPDropdownList.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/1/20.
//

import UIKit

public protocol TPDropdownListDelegate: class {
    func tpDropdownList(_ sender: TPDropdownList, openStatusChanged isOpened: Bool)
    func tpDropdownList(_ sender: TPDropdownList, selectedItemAtIndex index: Int)
    func tpDropdownListItems(_ sender: TPDropdownList) -> [String]
    func tpDropdownListConstraintAndRelativeViewToAnimateHeightChange(_ sender: TPDropdownList) -> (NSLayoutConstraint, UIView)?
    func tpDropdownListDidBeginEditing(_ sender: TPDropdownList)
    func tpDropdownListDidEndEditing(_ sender: TPDropdownList, byReturn: Bool)
    func tpDropdowList(_ sender: TPDropdownList, textChanged text: String?)
    func tpDropdownListShouldReturn(_ sender: TPDropdownList) -> Bool
}

@IBDesignable
public class TPDropdownList: UIView {
    
    // MARK: - Views
    @IBOutlet weak var textInputView: TPTextInputView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: - Constraints
    @IBOutlet public  weak var inputViewLeftConstraint: NSLayoutConstraint!
    @IBOutlet public weak var inputViewRightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    public weak var viewDelegate: TPDropdownListDelegate?
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        let content = loadFromNib()
        content.translatesAutoresizingMaskIntoConstraints = false
        addSubview(content)
        content.constraintAllSidesToSuperview()
        textInputView.viewDelegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
}

// MARK: - TPTextInputViewDelegate
extension TPDropdownList: TPTextInputViewDelegate {
    public func tpTextInputViewShouldReturn(_ sender: TPTextInputView) -> Bool {
        return viewDelegate?.tpDropdownListShouldReturn(self) ?? true
    }
    
    public func tpTextInputViewDidBeginEditing(_ sender: TPTextInputView) {
        viewDelegate?.tpDropdownListDidBeginEditing(self)
    }
    
    public func tpTextInputViewDidEndEditing(_ sender: TPTextInputView, byReturn: Bool) {
        viewDelegate?.tpDropdownListDidEndEditing(self, byReturn: byReturn)
    }
    
    public func tpTextInputViewTextChanged(_ sender: TPTextInputView, changedText: String?) {
        viewDelegate?.tpDropdowList(self, textChanged: changedText)
    }
}

// MARK: - UIPickerViewDataSource
extension TPDropdownList: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewDelegate?.tpDropdownListItems(self).count ?? 0
    }
}

extension TPDropdownList: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewDelegate?.tpDropdownListItems(self)[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if let item = viewDelegate?.tpDropdownListItems(self)[row] {
            textInputView.text = item
        }
        
        viewDelegate?.tpDropdownList(self, selectedItemAtIndex: row)
    }
}
