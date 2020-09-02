//
//  TPDropdownList.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/1/20.
//

import UIKit

public protocol TPDropdownListPickerDelegate: class {
    func tpDropdownList(_ sender: TPDropdownList, openStatusChanged isOpened: Bool)
    func tpDropdownList(_ sender: TPDropdownList, selectedItemAtIndex index: Int)
    func tpDropdownList(_ sender: TPDropdownList,
                        selectedTextInputItem item: String?)
    func tpDropdownListItems(_ sender: TPDropdownList) -> [String]
    func tpDropdownListConstraintAndRelativeViewToAnimateHeightChange(_ sender: TPDropdownList) -> (NSLayoutConstraint, UIView)?
}
public protocol TPDropdownListTextInputDelegate: class {
    func tpDropdownListDidBeginEditing(_ sender: TPDropdownList)
    func tpDropdownListDidEndEditing(_ sender: TPDropdownList, byReturn: Bool)
    func tpDropdowList(_ sender: TPDropdownList, textChanged text: String?)
    func tpDropdownListShouldReturn(_ sender: TPDropdownList) -> Bool
}

private extension TPDropdownList {
    typealias StateUpdateCompletionHandler = () -> Void
}

private extension TPDropdownList {
    enum Const {
        static let animDurationCloseSizeChange = 0.2
        static let animDurationCloseFade = 0.2
        static let animDurationCloseIcon = animDurationCloseFade + animDurationCloseSizeChange
        static let animDurationOpen = 0.4
        static let itemPickerOpenedDefaultHeight: CGFloat = 144
    }
}

@IBDesignable
public class TPDropdownList: UIView {
    // MARK: - Views
    @IBOutlet private weak var textInputView: TPTextInputView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var pickerView: UIPickerView!
    
    // MARK: - Constraints
    @IBOutlet public weak var inputViewLeftConstraint: NSLayoutConstraint!
    @IBOutlet public weak var inputViewRightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    public weak var viewPickerDelegate: TPDropdownListPickerDelegate?
    public weak var viewTextInputDelegate: TPDropdownListTextInputDelegate?
    public var isOpened: Bool = false {
        didSet {
            updateToCurrentState(animated: true) {
                self.viewPickerDelegate?.tpDropdownList(self, openStatusChanged: self.isOpened)
            }
        }
    }
    public var placeholderText: String? {
        get {
            return textInputView.placeholderText
        }
        set {
            textInputView.placeholderText = newValue
        }
    }
    public var openedPickerAdditionalHeight: CGFloat = Const.itemPickerOpenedDefaultHeight
    public var selectedItem: String?
    
    private var textInputItem: String?
    
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
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleOpenCloseIconTap))
        iconImageView.addGestureRecognizer(recognizer)
        iconImageView.isUserInteractionEnabled = true
        updateToCurrentState(animated: false)
    }
    
    // MARK: - Main Interface
    func refreshData() {
        pickerView.reloadAllComponents()
    }
    
    public func select(itemAt index: Int) {
        let resolvedIndex = textInputItemValid ? index + 1 : index
        pickerView.selectRow(resolvedIndex, inComponent: 0, animated: true)
        let item = pickerView(pickerView, titleForRow: index, forComponent: 0)
        textInputView.text = item
        selectedItem = item
    }
    
    // MARK: - Action and Action Callbacks
    
    @objc
    private func handleOpenCloseIconTap() {
        isOpened = !isOpened
    }
}

private extension TPDropdownList {
    func updateIconToCurrentState() {
        iconImageView.transform = isOpened ? CGAffineTransform(rotationAngle: CGFloat(Double.pi)) : CGAffineTransform.identity
    }
    
    func updateFadeToCurrentState() {
        pickerView.alpha = isOpened ? 1 : 0
    }
    func updateResizeToCurrentState() {
        guard let (constraint, view) = viewPickerDelegate?.tpDropdownListConstraintAndRelativeViewToAnimateHeightChange(self) else {
            return
        }
        if isOpened {
            constraint.constant += openedPickerAdditionalHeight
        } else {
            constraint.constant -= openedPickerAdditionalHeight
        }
        view.layoutIfNeeded()
    }
    
    func updateToCurrentState(animated: Bool, completion completionHandler: StateUpdateCompletionHandler? = nil) {
        guard animated else {
            updateFadeToCurrentState()
            updateIconToCurrentState()
            updateResizeToCurrentState()
            completionHandler?()
            return
        }
        
        if isOpened {
            UIView.animate(withDuration: Const.animDurationOpen, animations: {
                self.updateFadeToCurrentState()
                self.updateResizeToCurrentState()
                self.updateIconToCurrentState()
            }, completion: { _ in
                completionHandler?()
            })
        } else {
            UIView.animate(withDuration: Const.animDurationCloseFade, animations: {
                self.updateFadeToCurrentState()
            }, completion: { _ in
                UIView.animate(withDuration: Const.animDurationCloseSizeChange, animations: {
                    self.updateResizeToCurrentState()
                }, completion: { _ in
                    completionHandler?()
                })
            })
            UIView.animate(withDuration: Const.animDurationCloseIcon) {
                self.updateIconToCurrentState()
                completionHandler?()
            }
        }
    }
}

// MARK: - TPTextInputViewDelegate
extension TPDropdownList: TPTextInputViewDelegate {
    public func tpTextInputViewShouldReturn(_ sender: TPTextInputView) -> Bool {
        let shouldReturn = viewTextInputDelegate?.tpDropdownListShouldReturn(self) ?? true
        return shouldReturn
    }
    
    public func tpTextInputViewDidBeginEditing(_ sender: TPTextInputView) {
        viewTextInputDelegate?.tpDropdownListDidBeginEditing(self)
    }
    
    public func tpTextInputViewDidEndEditing(_ sender: TPTextInputView, byReturn: Bool) {
        viewTextInputDelegate?.tpDropdownListDidEndEditing(self, byReturn: byReturn)
    }
    
    public func tpTextInputViewTextChanged(_ sender: TPTextInputView, changedText: String?) {
        //let changedfromNil = textInputItem == nil && changedText != nil
        //let changedToNil = textInputItem != nil && changedText == nil
        textInputItem = changedText
        selectedItem = textInputItem
        pickerView.reloadAllComponents()
        let currentSelected = pickerView.selectedRow(inComponent: 0)
        if currentSelected != 0 {
            pickerView.selectRow(0, inComponent: 0, animated: true)
        }
        viewTextInputDelegate?.tpDropdowList(self, textChanged: changedText)
    }
}

// MARK: - UIPickerViewDataSource
extension TPDropdownList: UIPickerViewDataSource {
    var textInputItemValid: Bool {
        return textInputItem != nil && !(textInputItem?.isEmpty ?? true)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let delegateItemsCount = viewPickerDelegate?.tpDropdownListItems(self).count ?? 0
        let textInputCount = textInputItemValid ? 1 : 0
        return delegateItemsCount + textInputCount
    }
}

extension TPDropdownList: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let delegateItems = viewPickerDelegate?.tpDropdownListItems(self) ?? []
        if textInputItemValid {
            let items = [textInputItem] + delegateItems
            return items[row]
        } else {
            return delegateItems[row]
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let items = viewPickerDelegate?.tpDropdownListItems(self)
        if textInputItemValid {
            if row == 0 {
                textInputView.text = textInputItem
                selectedItem = textInputView.text
                viewPickerDelegate?.tpDropdownList(self, selectedTextInputItem: textInputItem)
                
            } else {
                textInputView.text = items?[row - 1]
                selectedItem = textInputView.text
                viewPickerDelegate?.tpDropdownList(self, selectedItemAtIndex: row - 1)
            }
        } else {
            textInputView.text = items?[row]
            selectedItem = textInputView.text
            viewPickerDelegate?.tpDropdownList(self, selectedItemAtIndex: row)
        }
    }
}
