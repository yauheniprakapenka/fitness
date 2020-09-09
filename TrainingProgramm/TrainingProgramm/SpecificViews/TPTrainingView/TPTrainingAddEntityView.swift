//
//  TPTrainingAddEntityView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/6/20.
//

import UIKit
import CommonViews

public protocol TPTrainingAddEntityViewDelegate: class {
    func tpTrainingAddEntityViewButtonDidTap(_ sender: TPTrainingAddEntityView, userData: [AnyHashable: Any]?)
}

public extension TPTrainingAddEntityView {
    enum State {
        case grayText
        case blackText
    }
}

private extension TPTrainingAddEntityView {
    enum Const {
        static let titleLabelDecoration: Decoration<UILabel> = { label in
            label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            label.textColor = Asset.TrainingProgramm.CommonColors.tpBlackText.color
        }
        static let buttonSize: CGFloat = 40
        static let buttonRadius: CGFloat = 20
        static let buttonLeftOffset: CGFloat = 10
        static let offsetLeftRightAllFields: CGFloat = 25
        static let grayTextColor = Asset.TrainingProgramm.CommonColors.trainingProgrammSelectableItemUnselectedText.color
        static let blackTextColor = Asset.TrainingProgramm.CommonColors.tpBlackText.color
    }
}
 
@IBDesignable
public class TPTrainingAddEntityView: UIView {
    private weak var titleLabel: UILabel!
    private weak var button: UIButton!
    
    public var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    public var colorState: State = .blackText {
        didSet {
            switch colorState {
            case .blackText:
                titleLabel.textColor = Const.blackTextColor
            case .grayText:
                titleLabel.textColor = Const.grayTextColor
            }
        }
    }
    public var userData: [AnyHashable: Any]?
    public weak var viewDelegate: TPTrainingAddEntityViewDelegate?
    
    public var topConstraint: NSLayoutConstraint!
    public var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        ininCommon()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        ininCommon()
    }
    
    private func ininCommon() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.decorator.apply(Const.titleLabelDecoration)
        addSubview(label)
        let leftRightOffset = Const.offsetLeftRightAllFields
        topConstraint = label.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        topConstraint.isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftRightOffset).isActive = true
        label.text = "Добавить секцию"
        label.widthAnchor.constraint(equalTo: widthAnchor, constant: -2 * Const.offsetLeftRightAllFields - Const.buttonSize - Const.buttonLeftOffset).isActive = true
        bottomConstraint = label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        bottomConstraint.isActive = true
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Asset.TrainingProgramm.CommonIcons.tpPlusIcon.image, for: .normal)
        button.setTitle(nil, for: .normal)
        addSubview(button)
        button.widthAnchor.constraint(equalToConstant: Const.buttonSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: Const.buttonSize).isActive = true
        button.layer.cornerRadius = Const.buttonRadius
        button.backgroundColor = Asset.TrainingProgramm.CommonColors.trainingProgrammBlueAccent.color
        button.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: Const.buttonLeftOffset).isActive = true
        titleLabel = label
        self.button = button
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    }
    
    @objc
    private func handleButtonTap() {
        viewDelegate?.tpTrainingAddEntityViewButtonDidTap(self, userData: userData)
    }
}
