//
//  TPAddSectionViewHolder.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/5/20.
//

import UIKit
import CommonViews

private extension TPAddSectionViewHolder {
    enum Const {
        static let titleLabelDecoration: Decoration<UILabel> = { label in
            label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            label.textColor = Asset.TrainingProgramm.CommonColors.tpBlackText.color
        }
        static let buttonSize: CGFloat = 40
        static let buttonRadius: CGFloat = 20
        static let buttonLeftOffset: CGFloat = 10
    }
}

class TPAddSectionViewHolder {
    weak var title: UILabel!
    weak var addButton: UIButton!
    
    init(superview: UIView) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.decorator.apply(Const.titleLabelDecoration)
        superview.addSubview(label)
        let leftRightOffset = TPFormControllerUtils.offsetLeftRightAllFields
        label.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leftRightOffset).isActive = true
        label.text = "Добавить секцию"
        label.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: -2 * TPFormControllerUtils.offsetLeftRightAllFields - Const.buttonSize - Const.buttonLeftOffset).isActive = true
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Asset.TrainingProgramm.CommonIcons.tpPlusIcon.image, for: .normal)
        button.setTitle(nil, for: .normal)
        superview.addSubview(button)
        button.widthAnchor.constraint(equalToConstant: Const.buttonSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: Const.buttonSize).isActive = true
        button.layer.cornerRadius = Const.buttonRadius
        button.backgroundColor = Asset.TrainingProgramm.CommonColors.trainingProgrammBlueAccent.color
        button.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: Const.buttonLeftOffset).isActive = true
        title = label
        addButton = button
    }
    
    var topAnchor: NSLayoutYAxisAnchor {
        get {
            return title.topAnchor
        }
    }
    var bottomAnchor: NSLayoutYAxisAnchor {
        get {
            return title.bottomAnchor
        }
    }
}
