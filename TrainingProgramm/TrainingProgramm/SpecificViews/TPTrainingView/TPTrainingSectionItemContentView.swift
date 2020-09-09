//
//  TPEmomSectionItemContentView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/5/20.
//

import UIKit
import CommonViews

public protocol TPTrainingSectionItemContentViewDelegate: class {
    func tpTrainingSectionItemContentViewHeightConstarintAndViewToAnimate(_ sender: TPTrainingSectionItemContentView, userData: [AnyHashable: Any]?) -> (NSLayoutConstraint, UIView)?
    
    func tpTrainingSectionItemContentView(_ sender: TPTrainingSectionItemContentView, modelUpdated model: TPTrainingSectionItem, emptyFields: [TPTrainingSectionItemContentView.Field], notValidFields: [TPTrainingSectionItemContentView.Field], userData: [AnyHashable: Any]?)
}

public extension TPTrainingSectionItemContentView {
    enum Field: CaseIterable{
        case profileValue
        case koeff
        case exerciseName
        case defaultWeightMan
        case defaultWeightWoman
        case repeats
        case distance
    }
}

public extension TPTrainingSectionItemContentView {
    struct ViewData {
        public var exerciseName: String?
        public var koeff: Int?
        public var defaultWeightMan: Int?
        public var defaultWeightWoman: Int?
        public var repeats: Int?
        public var distance: Int?
        
        public init(
            exerciseName: String?,
            koeff: Int?,
            defaultWeightMan: Int?,
            defaultWeightWoman: Int?,
            repeats: Int?,
            distance: Int?
        ) {
            self.exerciseName = exerciseName
            self.koeff = koeff
            self.defaultWeightMan = defaultWeightMan
            self.defaultWeightWoman = defaultWeightWoman
            self.repeats = repeats
            self.distance = distance
        }
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
    }
}

@IBDesignable
public class TPTrainingSectionItemContentView: UIView {
    // MARK: - Views
    private weak var nibContnetView: UIView!
    @IBOutlet weak var exercisePickerView: TPDropdownList!
    @IBOutlet weak var profileValueInputView: TPTextInputView!
    @IBOutlet weak var koefficientInputView: TPTextInputView!
    @IBOutlet weak var weightMan: TPTextInputView!
    @IBOutlet weak var weightWoman: TPTextInputView!
    @IBOutlet weak var repeatsInputView: TPTextInputView!
    @IBOutlet weak var distanceInputView: TPTextInputView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Constraints
    @IBOutlet weak var exercisePickerViewHeightConstraint: NSLayoutConstraint!
    
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
        emptyFields = Field.allCases
        model = TPTrainingSectionItem()
        profileValueInputView.viewDelegate = self
        koefficientInputView.viewDelegate = self
        weightMan.viewDelegate = self
        weightWoman.viewDelegate = self
        repeatsInputView.viewDelegate = self
        distanceInputView.viewDelegate = self
    }
    
    // MARK: - Main Interface
    public func configure(with model: TPTrainingSectionItem) {
        emptyFields = []
        notValidFields = []
        if let profileValue = model.profileValue {
            profileValueInputView.text = "\(profileValue)"
        } else {
            emptyFields.append(.profileValue)
        }
        if let koefficient = model.koeff {
            koefficientInputView.text = "\(koefficient * 100)"
        } else {
            emptyFields.append(.koeff)
        }
        if let weightMan = model.weightForManKg {
            self.weightMan.text = "\(weightMan)"
        } else {
            emptyFields.append(.defaultWeightMan)
        }
        if let weightWoman = model.weightForWomanKg {
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

private extension TPTrainingSectionItemContentView {
    func getFloatValue(_ text: String?) -> Float? {
        return Float(text ?? "")
    }
    func getIntValue(_ text: String?) -> Int? {
        return Int(text ?? "")
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

extension TPTrainingSectionItemContentView: TPDropdownListPickerDelegate {
    public func tpDropdownList(_ sender: TPDropdownList, openStatusChanged isOpened: Bool) {
        
    }
    
    public func tpDropdownList(_ sender: TPDropdownList, selectedItemAtIndex index: Int) {
        
    }
    
    public func tpDropdownList(_ sender: TPDropdownList, selectedTextInputItem item: String?) {
        
    }
    
    public func tpDropdownListItems(_ sender: TPDropdownList) -> [String] {
        return ["One", "Two", "Three"]
    }
    
    public func tpDropdownListConstraintAndRelativeViewToAnimateHeightChange(_ sender: TPDropdownList) -> [(NSLayoutConstraint, UIView)] {
        if let parentItems = viewDelegate?.tpTrainingSectionItemContentViewHeightConstarintAndViewToAnimate(self, userData: userData) {
            return [(exercisePickerViewHeightConstraint, nibContnetView), parentItems]
        } else {
            fatalError("Enclosing view must provide constraints to animate heigth")
        }
    }
}

extension TPTrainingSectionItemContentView: TPTextInputViewDelegate {
    public func tpTextInputViewShouldReturn(_ sender: TPTextInputView) -> Bool {
        return true
    }
    
    public func tpTextInputViewDidBeginEditing(_ sender: TPTextInputView) {
        sender.state = .normal
    }
    
    public func tpTextInputViewDidEndEditing(_ sender: TPTextInputView, byReturn: Bool) {
        
        switch sender {
        case profileValueInputView:
            model.profileValue = getAndValidateValue(textField: sender, functionToCheck: getFloatValue(_:), field: .profileValue)
        case koefficientInputView:
            model.koeff = getAndValidateValue(textField: sender, functionToCheck: getFloatValue(_:), field: .koeff)
        case weightMan:
            model.weightForManKg = getAndValidateValue(textField: sender, functionToCheck: getFloatValue(_:), field: .defaultWeightMan)
        case weightWoman:
            model.weightForWomanKg = getAndValidateValue(textField: sender, functionToCheck: getFloatValue(_:), field: .defaultWeightWoman)
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
