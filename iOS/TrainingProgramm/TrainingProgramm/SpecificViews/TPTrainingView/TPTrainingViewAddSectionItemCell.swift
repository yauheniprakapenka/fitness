//
//  TPTrainingViewAddSectionItemCell.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/7/20.
//

import UIKit

public class TPTrainingViewAddSectionItemCell: UITableViewCell {
    // MARK: - Properties
    private weak var cellContentView: TPTrainingAddEntityView!
    
    // MARK: - Initialization
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCommon()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        let content = TPTrainingAddEntityView()
        content.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(content)
        content.constraintAllSidesToSuperview()
        cellContentView = content
    }
    
    // MARK: - Main Interface
    public func configure(withTitle title: String, viewDelegate: TPTrainingAddEntityViewDelegate, userData: [AnyHashable: Any]?) {
        cellContentView.viewDelegate = viewDelegate
        cellContentView.userData = userData
        cellContentView.title = title
        cellContentView.colorState = .grayText
    }
}
