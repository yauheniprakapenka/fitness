//
//  TPTrainingViewAddSectionItemView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/6/20.
//

import UIKit

public class TPTrainingViewAddSectionItemView: UITableViewCell {
    weak var cellContentView: TPTrainingAddEntityView!
    
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
}
