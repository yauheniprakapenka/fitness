//
//  TPTextInputView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/30/20.
//

import UIKit
import CommonViews

public protocol TPTextInputViewDelegate: class {
    func tpTextInputViewShouldReturn(_ sender: TPTextInputView) -> Bool
    func tpTextInputViewDidBeginEditing(_ sender: TPTextInputView)
    func tpTextInputViewDidEndEditing(_ sender: TPTextInputView, byReturn: Bool)
    func tpTextInputViewTextChanged(_ sender: TPTextInputView, changedText: String?)
}

public extension TPTextInputView {
    enum State {
        case normal
        case error
    }
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
    
    @IBInspectable
    public var placeholderText: String? {
        get {
            return textField.placeholder
        }
        set {
            textField.placeholder = newValue
        }
    }
    
    public var state: State = .normal {
        didSet {
            switch state {
            case .normal:
                textField.textColor = normalStateTextColor
            case .error:
                textField.textColor = errorStateTextColor
            }
        }
    }
    
    public var isEditable: Bool {
        get {
            return textField.isEnabled
        }
        set {
            textField.isEnabled = newValue
        }
    }
    
    public weak var viewDelegate: TPTextInputViewDelegate?
    
    @IBOutlet private weak var textFieldLeftConstraint: NSLayoutConstraint!
    @IBOutlet private weak var textFieldRightConstraint: NSLayoutConstraint!
    
    private var endEditingByReturn: Bool = false
    private var normalStateTextColor: UIColor = .black
    private var errorStateTextColor: UIColor = .red
    
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
        sendSubviewToBack(contentView)
        contentView.constraintAllSidesToSuperview()
        textField.addTarget(self, action: #selector(handleValueChanged(_:)), for: .editingChanged)
        normalStateTextColor = textField.textColor ?? normalStateTextColor
    }
    
    // MARK: - Actions and Action Callbacks
    
    @objc
    func handleValueChanged(_ sender: Any) {
        viewDelegate?.tpTextInputViewTextChanged(self, changedText: textField.text)
    }
    
    // MARK: - Other
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        textField.placeholder = placeholderText
    }
    
    public override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension TPTextInputView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        viewDelegate?.tpTextInputViewDidBeginEditing(self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        let endedByReturn = endEditingByReturn
        endEditingByReturn = false
        viewDelegate?.tpTextInputViewDidEndEditing(self, byReturn: endedByReturn)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let shouldReturn = viewDelegate?.tpTextInputViewShouldReturn(self) ?? true
        if shouldReturn {
            endEditingByReturn = true
            textField.resignFirstResponder()
        }
        return shouldReturn
    }
}

public extension TPTextInputView {
    @IBInspectable
    var leftInset: CGFloat {
        get {
            return textFieldLeftConstraint.constant
        }
        set {
            textFieldLeftConstraint.constant = newValue
        }
    }
    
    @IBInspectable
    var rightInset: CGFloat {
        get {
            return textFieldRightConstraint.constant
        } set {
            textFieldRightConstraint.constant = newValue
        }
    }
}
