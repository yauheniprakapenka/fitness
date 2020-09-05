//
//  TPEmomSectionItemContentView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/5/20.
//

import UIKit
import CommonViews

public protocol TPEmomSectionItemContentViewDelegate: class {
    func tpEmomSectionItemContentViewHeightConstarintAndViewToAnimate(_ sender: TPEmomSectionItemContentView, userData: [AnyHashable: Any]?) -> (NSLayoutConstraint, UIView)?
}

public extension TPEmomSectionItemContentView {
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

private extension TPEmomSectionItemContentView {
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
public class TPEmomSectionItemContentView: UIView {
    // MARK: - Views
    private weak var nibContnetView: UIView!
    @IBOutlet weak var exercisePickerView: TPDropdownList!
    
    // MARK: - Constraints
    @IBOutlet weak var exercisePickerViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    public weak var viewDelegate: TPEmomSectionItemContentViewDelegate?
    public var userData: [AnyHashable: Any]?
    
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
        
    }
    
    //
}

extension TPEmomSectionItemContentView: TPDropdownListPickerDelegate {
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
        if let parentItems = viewDelegate?.tpEmomSectionItemContentViewHeightConstarintAndViewToAnimate(self, userData: userData) {
            return [(exercisePickerViewHeightConstraint, nibContnetView), parentItems]
        } else {
            fatalError("Enclosing view must provide constraints to animate heigth")
        }
    }
}
