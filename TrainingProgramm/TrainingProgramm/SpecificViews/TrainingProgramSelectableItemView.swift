//
//  TrainingProgramSelectableItemView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/25/20.
//

import UIKit

private extension TrainingProgramSelectableItemView {
    enum Const {
        static let selectedColor = UIColor(named: "trainingProgramm_blueAccent", in: TrainingProgrammModule.bundle, compatibleWith: nil)!
        static let unselectedColor = UIColor.white
        static let selectedBorderColor = UIColor(named: "trainingProgramm_selectableItemBorderSelected", in: TrainingProgrammModule.bundle, compatibleWith: nil)!
        static let unselectedBorderColor = UIColor(named: "trainingProgramm_selectableItemBorderUnselected", in: TrainingProgrammModule.bundle, compatibleWith: nil)!
        static let selectedTextColor = UIColor.white
        static let unselectedTextColor = UIColor(named: "trainingProgramm_selectableItemUnselectedText", in: TrainingProgrammModule.bundle, compatibleWith: nil)!
        static let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

@IBDesignable
public class TrainingProgramSelectableItemView: SelectableItemView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        var appearance = Appearance()
        appearance.borderWidth = 1
        appearance.cornerRadius = 6
        appearance.selectedBorderColor = Const.selectedBorderColor
        appearance.unselectedBorderColor = Const.unselectedBorderColor
        appearance.selectedColor = Const.selectedColor
        appearance.unselectedColor = Const.unselectedColor
        appearance.selectedTextColor = Const.selectedTextColor
        appearance.unselectedTextColor = Const.unselectedTextColor
        appearance.edgeInsets = Const.insets
        self.appearance = appearance
    }
}
