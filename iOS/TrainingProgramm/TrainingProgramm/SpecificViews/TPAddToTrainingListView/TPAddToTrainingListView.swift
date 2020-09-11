//
//  TPAddToTrainingListView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/2/20.
//

import UIKit

public protocol TPAddToTrainingListViewDelegate: class {
    func tpAddToTrainingListViewItems(_ sender: TPAddToTrainingListView) -> [(String, Bool)]
    func tpAddToTrainingListView(_ sender: TPAddToTrainingListView, checboxStatusChanged isChecked: Bool, atIndex index: Int)
}

private extension TPAddToTrainingListView {
    enum Const {
        static let itemHeight: CGFloat = 42
    }
}

public class TPAddToTrainingListView: UIStackView {
    
    // MARK: - Properties
    public weak var viewDelegate: TPAddToTrainingListViewDelegate?
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        axis = .vertical
        distribution = .fill
    }
    
    public var leftOffset: CGFloat = 0
    public var rightOffset: CGFloat = 0
    
    // MARK: - Main Interface
    public func refreshData() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
        guard let items = viewDelegate?.tpAddToTrainingListViewItems(self) else {
            return
        }
        for (title, isChecked) in items {
            let view = TPAddToTrainingListItemContentView()
            view.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(view)
            view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            view.heightAnchor.constraint(equalToConstant: Const.itemHeight).isActive = true
            view.text = title
            view.isChecked = isChecked
            view.viewDelegate = self
            view.leftConstraint.constant = leftOffset
            view.rightConstraint.constant = rightOffset
        }
    }
}

// MARK: - TPAddToTrainingListItemContentViewDelegate
extension TPAddToTrainingListView: TPAddToTrainingListItemContentViewDelegate {
    public func tpAddToTrainingListItemContentView(_ sender: TPAddToTrainingListItemContentView, checkboxStatusChanged isChecked: Bool) {
        if let index = arrangedSubviews.firstIndex(of: sender) {
            viewDelegate?.tpAddToTrainingListView(self, checboxStatusChanged: isChecked, atIndex: index)
        }
    }
}
