//
//  TPTextInputView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/30/20.
//

import UIKit
import CommonViews

public protocol TPTextInputViewDelegate: class {
    func tpTextInputViewDidBeginEditing(_ sender: TPTextInputView)
    func tpTextInputViewDidEndEditing(_ sender: TPTextInputView)
    func tpTextInputViewTextChanged(_ sender: TPTextInputView, changedText: String?)
}

@IBDesignable
public class TPTextInputView: UIView {
    // MARK: - Properties
    private weak var viewContent: UIViewExtended!
    @IBOutlet private weak var textField: UITextField!
    
    public var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    public var placeholderText: String? {
        get {
            return textField.placeholder
        }
        set {
            textField.placeholder = newValue
        }
    }
    
    public weak var viewDelegate: TPTextInputViewDelegate?
    
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
        let contentView = loadFromNib() as! UIViewExtended
        backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constraintAllSidesToSuperview()
    }
    
    // MARK: - Actions and Action Callbacks
    
    @IBAction func handleValueChanged(_ sender: Any) {
        viewDelegate?.tpTextInputViewTextChanged(self, changedText: textField.text)
    }
}

// MARK: - UITextFieldDelegate
extension TPTextInputView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        viewDelegate?.tpTextInputViewDidBeginEditing(self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        viewDelegate?.tpTextInputViewDidEndEditing(self)
    }
}
