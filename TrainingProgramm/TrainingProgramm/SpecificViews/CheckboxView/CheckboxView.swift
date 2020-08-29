//
//  CheckboxView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/29/20.
//

import UIKit
import CommonViews

private extension CheckboxView {
    enum Const {
        static let checkedColor = Asset.TrainingProgramm.CommonColors.trainingProgrammBlueAccent.color
        static let uncheckedColor = Asset.TrainingProgramm.CheckboxView.Colors.trainingProgrammCheckboxViewUnchecked.color
        static let animDuration = 0.3
    }
}

public protocol CheckboxViewDelegate: class {
    func checkboxView(_ sender: CheckboxView, statusChangedTo checked: Bool)
}

@IBDesignable
public class CheckboxView: UIViewExtended {
    // MARK: - Properties
    var isChecked: Bool = false {
        didSet {
            animateUpdateAppearance()
        }
    }
    
    public override var frame: CGRect {
        didSet {
            cornerRadius = min(frame.width, frame.height) / 2
        }
    }
    
    weak var viewDelegate: CheckboxViewDelegate?
    
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
        let imageView = UIImageView(
            image: Asset.TrainingProgramm.CheckboxView.trainingProgrammCheckboxIcon.image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.constraintAllSidesToSuperview(insets: .allSides(by: 7))
        updateAppearance()
        cornerRadius = min(frame.width, frame.height) / 2
        let tapRegognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapRegognizer)
    }
    
    // MARK: - Actions and Action Callbacks
    @objc
    func handleTap() {
        isChecked = !isChecked
        viewDelegate?.checkboxView(self, statusChangedTo: isChecked)
    }
    
    // MARK: - Other
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        isChecked = true
        updateAppearance()
    }
}

// MARK: - Private Methods
private extension CheckboxView {
    func animateUpdateAppearance() {
        UIView.animate(withDuration: Const.animDuration) {
            self.updateAppearance()
        }
    }
    
    func updateAppearance() {
        backgroundColor = isChecked ? Const.checkedColor : Const.uncheckedColor
    }
}
