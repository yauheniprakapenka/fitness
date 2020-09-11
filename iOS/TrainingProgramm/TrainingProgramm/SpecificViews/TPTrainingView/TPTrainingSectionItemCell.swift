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
                          exercises: [TPExercise],
                          viewDelegate: TPTrainingSectionItemContentViewDelegate,
                          userData: [AnyHashable: Any]) {
        
        cellContentView.titleText = title
        cellContentView.viewDelegate = viewDelegate
        cellContentView.userData = userData
        cellContentView.configure(with: exercises)
        cellContentView.configure(with: sectionItem)
    }
}
