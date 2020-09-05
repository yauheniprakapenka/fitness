//
//  TPAddToTrainingListView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/2/20.
//

import UIKit

public protocol TPAddToTrainingListItemContentViewDelegate: class {
    func tpAddToTrainingListItemContentView(_ sender: TPAddToTrainingListItemContentView, checkboxStatusChanged isChecked: Bool)
}

public class TPAddToTrainingListItemContentView: UIView {
    // MARK: - Views
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var checkboxView: TPSquaredCheckboxView!
    
    // MARK: - Constraints
    @IBOutlet public weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet public weak var rightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    public weak var viewDelegate: TPAddToTrainingListItemContentViewDelegate?
    public var isChecked: Bool {
        get {
            return checkboxView.isChecked
        }
        set {
            checkboxView.isChecked = newValue
        }
    }
    public var text: String? {
        get {
            return nameLabel.text
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        ininCommon()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        ininCommon()
    }
    
    private func ininCommon() {
        let content = loadFromNib()
        content.translatesAutoresizingMaskIntoConstraints = false
        addSubview(content)
        content.constraintAllSidesToSuperview()
        checkboxView.viewDelegate = self
    }
}

// MARK: - TPSquaredCheckboxViewDelegate
extension TPAddToTrainingListItemContentView: TPSquaredCheckboxViewDelegate {
    public func tpSquaredCheckboxView(_ sender: TPSquaredCheckboxView, statusChanged isChecked: Bool) {
        viewDelegate?.tpAddToTrainingListItemContentView(self, checkboxStatusChanged: isChecked)
    }
}
