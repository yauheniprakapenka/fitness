//
//  TPTrainingSectionItemCell.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/7/20.
//

import UIKit

public class TPTrainingSectionItemCell: UITableViewCell {
    // MARK: - Properties
    private weak var cellContentView: TPTrainingSectionItemContentView!
    
    // MARK: - Init
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCommon()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        let content = TPTrainingSectionItemContentView()
        content.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(content)
        content.constraintAllSidesToSuperview()
        cellContentView = content
    }
    
    // MARK: - Main Interface
    public func configure(withTitle title: String,
                          sectionItem: TPTrainingSectionItem,
                          viewDelegate: TPTrainingSectionItemContentViewDelegate,
                          userData: [AnyHashable: Any]) {
        
        cellContentView.titleText = title
        cellContentView.viewDelegate = viewDelegate
        cellContentView.userData = userData
        if let profileValue = sectionItem.profileValue {
            cellContentView.profileValueInputView.text = "\(profileValue)"
        }
        if let koefficient = sectionItem.koeff {
            cellContentView.koefficientInputView.text = "\(koefficient * 100)"
        }
        if let weightMan = sectionItem.weightForManKg {
            cellContentView.weightMan.text = "\(weightMan)"
        }
        if let weightWoman = sectionItem.weightForWomanKg {
            cellContentView.weightWoman.text = "\(weightWoman)"
        }
        if let repeats = sectionItem.repeats {
            cellContentView.repeatsInputView.text = "\(repeats)"
        }
        if let distanceMeters = sectionItem.distanceMeters {
            cellContentView.distanceInputView.text = "\(distanceMeters)"
        }
        
    }
}
