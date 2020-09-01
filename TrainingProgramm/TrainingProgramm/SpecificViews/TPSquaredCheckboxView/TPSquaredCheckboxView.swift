//
//  TPSquaredCheckboxView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/1/20.
//

import UIKit
import CommonViews

public protocol TPSquaredCheckboxViewDelegate: class {
    func tpSquaredCheckboxView(_ sender: TPSquaredCheckboxView, statusChanged isChecked: Bool)
}

private extension TPSquaredCheckboxView {
    enum Const {
        static let checkedColor = Asset.TrainingProgramm.CommonColors.trainingProgrammBlueAccent.color
        static let uncheckedColor = UIColor.clear
        static let borderColor = Asset.TrainingProgramm.CommonColors.tpGrayBorder.color
        static let cornerRadius: CGFloat = 6
        static let animDuration = 0.3
    }
}

public class TPSquaredCheckboxView: UIViewExtended {
    // MARK: - Properties
    private weak var imageView: UIImageView!
    public weak var viewDelegate: TPSquaredCheckboxViewDelegate?
    
    public var isChecked: Bool = false {
        didSet {
            animateUpdateAppearance()
        }
    }
    
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
        imageView.constraintAllSidesToSuperview(insets: .allSides(by: 3))
        self.imageView = imageView
        cornerRadius = Const.cornerRadius
        updateAppearance()
        let tapRegognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapRegognizer)
    }
    
    // MARK: - Actions and Action Callbacks
    @objc
    func handleTap() {
        isChecked = !isChecked
        viewDelegate?.tpSquaredCheckboxView(self, statusChanged: isChecked)
    }
    
    // MARK: - Other
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        isChecked = Bool.random()
        updateAppearance()
    }
}

// MARK: - Private Methods
private extension TPSquaredCheckboxView {
    func animateUpdateAppearance() {
        UIView.animate(withDuration: Const.animDuration) {
            self.updateAppearance()
        }
    }
    
    func updateAppearance() {
        backgroundColor = isChecked ? Const.checkedColor : Const.uncheckedColor
        borderColor = Const.borderColor
        borderWidth = isChecked ? 0 : 1
        imageView.alpha = isChecked ? 1 : 0
    }
}
