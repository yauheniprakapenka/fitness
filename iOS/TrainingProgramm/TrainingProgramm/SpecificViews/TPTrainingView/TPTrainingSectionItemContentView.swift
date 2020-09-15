//
//  TPEmomSectionItemContentView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/5/20.
//

import UIKit
import CommonViews

public protocol TPTrainingSectionItemContentViewDelegate: class {
    func tpTrainingSectionItemContentWillNeedAnimateHeightChange(
        _ sender: TPTrainingSectionItemContentView,
        heightDelta: CGFloat,
        animationDuration: TimeInterval,
        userData: [AnyHashable: Any]?)
    
    func tpTrainingSectionItemContentView(
        _ sender: TPTrainingSectionItemContentView,
        modelUpdated model: TPTrainingSectionItem,
        emptyFields: [TPTrainingSectionItemContentView.Field],
        notValidFields: [TPTrainingSectionItemContentView.Field],
        userData: [AnyHashable: Any]?)
}

public extension TPTrainingSectionItemContentView {
    enum Field: CaseIterable {
        case profileValue
        case koeff
        case exerciseName
        case defaultWeightMan
        case defaultWeightWoman
        case repeats
        case distance
    }
}

private extension TPTrainingSectionItemContentView {
    enum Const {
        static let titleLabelDecoration: Decoration<UILabel> = { label in
            label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            label.textColor = Asset.TrainingProgramm.CommonColors.tpBlackText.color
        }
        static let offsetTopTitleFirst: CGFloat = 38
        static let offsetTopTitleOthers: CGFloat = 25
        static let offsetTopInputFields: CGFloat = 15
        static let offsetLeftRightAllFields: CGFloat = 25
        static let offsetInnerSpaceTwoViews: CGFloat = 15
        static let inputFieldRowHeight: CGFloat = 50
        static let pickerFieldHeight: CGFloat = 55
    }
}

@IBDesignable
public class TPTrainingSectionItemContentView: UIView {
    // MARK: - Views
    private weak var nibContnetView: UIView!
    @IBOutlet weak var exercisePickerView: TPDropdownList!
    @IBOutlet weak var profileValuePickerView: TPDropdownList!
    @IBOutlet weak var koefficientInputView: TPTextInputView!
    @IBOutlet weak var weightMan: TPTextInputView!
    @IBOutlet weak var weightWoman: TPTextInputView!
    @IBOutlet weak var repeatsInputView: TPTextInputView!
    @IBOutlet weak var distanceInputView: TPTextInputView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Constraints
    @IBOutlet weak var exercisePickerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileValueHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var firstRowHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondRowHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdRowHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    public weak var viewDelegate: TPTrainingSectionItemContentViewDelegate?
    public var userData: [AnyHashable: Any]?
    public var titleText: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    public private(set) var model: TPTrainingSectionItem!
    public private(set) var exercises: [TPExercise] = []
    public private(set) var profileValues: [String] = []
    private var emptyFields: [Field] = []
    private var notValidFields: [Field] = []
    
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
        let view = loadFromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.constraintAllSidesToSuperview()
        nibContnetView = view
        exercisePickerView.viewPickerDelegate = self
        exercisePickerView.enableCustomInput = false
        profileValuePickerView.viewPickerDelegate = self
        profileValuePickerView.enableCustomInput = false
        emptyFields = Field.allCases
        model = TPTrainingSectionItem()
        koefficientInputView.viewDelegate = self
        weightMan.viewDelegate = self
        weightWoman.viewDelegate = self
        repeatsInputView.viewDelegate = self
        distanceInputView.viewDelegate = self
    }
    
    // MARK: - Main Interface
    public func configure(with exercises: [TPExercise]) {
        self.exercises = exercises
    }
    
    public func configure(with profileValues: [String]) {
        self.profileValues = profileValues
    }
    
    public func configure(with model: TPTrainingSectionItem) {
        emptyFields = []
        notValidFields = []
        
        if
            let exerciseId = model.exerciseId,
            let index = exercises.firstIndex(where: { $0.id == exerciseId }) {
            
            exercisePickerView.select(itemAt: index)
        } else {
            emptyFields.append(.profileValue)
        }
        
        if let profileValue = model.profileValue,
           let index = profileValues.firstIndex(of: profileValue) {
            profileValuePickerView.select(itemAt: index)
        } else {
            emptyFields.append(.profileValue)
        }
        if let koefficient = model.koeff {
            koefficientInputView.text = "\(koefficient * 100)"
        } else {
            emptyFields.append(.koeff)
        }
        if let weightMan = model.defaultForMan {
            self.weightMan.text = "\(weightMan)"
        } else {
            emptyFields.append(.defaultWeightMan)
        }
        if let weightWoman = model.defaultForWoman {
            self.weightWoman.text = "\(weightWoman)"
        } else {
            emptyFields.append(.defaultWeightWoman)
        }
        if let repeats = model.repeats {
            repeatsInputView.text = "\(repeats)"
        } else {
            emptyFields.append(.repeats)
        }
        if let distanceMeters = model.distanceMeters {
            distanceInputView.text = "\(distanceMeters)"
        } else {
            emptyFields.append(.distance)
        }
    }
}

// MARK: - Private Methods
private extension TPTrainingSectionItemContentView {
    func getFloatValue(_ text: String?) -> Float? {
        return Float(text ?? "")
    }
    func getIntValue(_ text: String?) -> Int? {
        return Int(text ?? "")
    }
    
    func getStringValue(_ text: String?) -> String? {
        return text
    }
    
    func removeEmptyField(_ field: Field) {
        if let index = emptyFields.firstIndex(of: field) {
            emptyFields.remove(at: index)
        }
    }
    func removeNotValidField(_ field: Field) {
        if let index = notValidFields.firstIndex(of: field) {
            notValidFields.remove(at: index)
        }
    }
    
    func getAndValidateValue<T>(textField: TPTextInputView, functionToCheck: (String?) -> T?, field: Field) -> T? {
        
        let text = textField.text
        let nilOrEmpty = text?.isEmpty ?? true
        if nilOrEmpty {
            removeNotValidField(field)
            emptyFields.append(field)
            return nil
        } else {
            if let value = functionToCheck(text) {
                textField.state = .normal
                removeEmptyField(field)
                removeNotValidField(field)
                return value
            } else {
                textField.state = .error
                removeEmptyField(field)
                notValidFields.append(field)
                return nil
            }
        }
        
    }
}

// MARK: - TPDropdownListPickerDelegate
extension TPTrainingSectionItemContentView: TPDropdownListPickerDelegate {
    public func tpDropdownListNeedAnimateHeight(_ sender: TPDropdownList, heightDelta: CGFloat, animationDuration: TimeInterval) {
        switch sender {
        case exercisePickerView:
            UIView.animate(withDuration: animationDuration, animations: {
                self.exercisePickerViewHeightConstraint.constant += heightDelta
                let inputFieldsHeight: CGFloat = heightDelta > 0 ? 0 : Const.inputFieldRowHeight
                let pickerViewHeight: CGFloat = heightDelta > 0 ? 0 : Const.pickerFieldHeight
                self.profileValueHeightConstraint.constant = pickerViewHeight
                self.firstRowHeightConstraint.constant = inputFieldsHeight
                self.secondRowHeightConstraint.constant = inputFieldsHeight
                let alpha: CGFloat = heightDelta > 0 ? 0 : 1
                [self.profileValuePickerView, self.koefficientInputView, self.weightMan, self.weightWoman].forEach { view in
                    view?.alpha = alpha
                }
                self.nibContnetView.layoutIfNeeded()
            })
        case profileValuePickerView:
            UIView.animate(withDuration: animationDuration, animations: {
                self.profileValueHeightConstraint.constant += heightDelta
                let inputFieldsHeight: CGFloat = heightDelta > 0 ? 0 : Const.inputFieldRowHeight
                self.firstRowHeightConstraint.constant = inputFieldsHeight
                self.secondRowHeightConstraint.constant = inputFieldsHeight
                let alpha: CGFloat = heightDelta > 0 ? 0 : 1
                [self.koefficientInputView, self.weightWoman, self.weightMan].forEach { view in
                    view?.alpha = alpha
                }
                self.nibContnetView.layoutIfNeeded()
            })
        default:
            preconditionFailure()
        }
        viewDelegate?.tpTrainingSectionItemContentWillNeedAnimateHeightChange(self, heightDelta: heightDelta, animationDuration: animationDuration, userData: userData)
    }
    
    public func tpDropdownList(_ sender: TPDropdownList, openStatusChanged isOpened: Bool) {
        
    }
    
    public func tpDropdownList(_ sender: TPDropdownList, selectedItemAtIndex index: Int) {
        switch sender {
        case profileValuePickerView:
            model.profileValue = profileValues[index]
        case exercisePickerView:
            model.exerciseId = exercises[index].id
        default:
            preconditionFailure()
        }
        viewDelegate?.tpTrainingSectionItemContentView(self, modelUpdated: model, emptyFields: emptyFields, notValidFields: notValidFields, userData: userData)
    }
    
    public func tpDropdownList(_ sender: TPDropdownList, selectedTextInputItem item: String?) {
        
    }
    
    public func tpDropdownListItems(_ sender: TPDropdownList) -> [String] {
        switch sender {
        case profileValuePickerView:
            return profileValues
        case exercisePickerView:
            return exercises.map { $0.name ?? "Без имени" }
        default:
            preconditionFailure()
        }
    }
}

extension TPTrainingSectionItemContentView: TPTextInputViewDelegate {
    public func tpTextInputViewShouldReturn(_ sender: TPTextInputView) -> Bool {
        return true
    }
    
    public func tpTextInputViewDidBeginEditing(_ sender: TPTextInputView) {
        sender.state = .normal
        if exercisePickerView.isOpened {
            exercisePickerView.isOpened = false
        }
        if profileValuePickerView.isOpened {
            profileValuePickerView.isOpened = false
        }
    }
    
    public func tpTextInputViewDidEndEditing(_ sender: TPTextInputView, byReturn: Bool) {
        
        switch sender {
        case koefficientInputView:
            model.koeff = getAndValidateValue(textField: sender, functionToCheck: getFloatValue(_:), field: .koeff)
        case weightMan:
            model.defaultForMan = getAndValidateValue(textField: sender, functionToCheck: getFloatValue(_:), field: .defaultWeightMan)
        case weightWoman:
            model.defaultForWoman = getAndValidateValue(textField: sender, functionToCheck: getFloatValue(_:), field: .defaultWeightWoman)
        case repeatsInputView:
            model.repeats = getAndValidateValue(textField: sender, functionToCheck: getIntValue(_:), field: .repeats)
        case distanceInputView:
            model.distanceMeters = getAndValidateValue(textField: sender, functionToCheck: getIntValue(_:), field: .distance)
        default:
            return
        }
        viewDelegate?.tpTrainingSectionItemContentView(self, modelUpdated: model, emptyFields: emptyFields, notValidFields: notValidFields, userData: userData)
    }
    
    public func tpTextInputViewTextChanged(_ sender: TPTextInputView, changedText: String?) {
    }
}
