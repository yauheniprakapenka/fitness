//
//  ExerciseListItemView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/30/20.
//

import UIKit

public class ExerciseListItemView: UITableViewCell {
    // MARK: - Properties
    private weak var cellContent: ExerciseItemContentView!
    
    // MARK: - Initialization
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        inintCommon()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        inintCommon()
    }
    
    private func inintCommon() {
        let cellContent = ExerciseItemContentView()
        cellContent.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellContent)
        cellContent.constraintAllSidesToSuperview()
        self.cellContent = cellContent
    }
    
    // MARK: - Main Interface
    public func configire(with model: ExerciseListView.ItemViewModel, delegate: ExerciseItemContentViewDelegate?, userData: [AnyHashable: Any]?) {
        cellContent.viewDelegate = delegate
        switch model.itemState {
        case .active:
            cellContent.state = .active
        case .normal:
            cellContent.state = .normal
        case .completed:
            cellContent.state = .completed
        }
        cellContent.isCheckboxHidden = !model.isCheckboxVisible
        cellContent.configure(with: model.contentViewModel, userData: userData)
    }
}
