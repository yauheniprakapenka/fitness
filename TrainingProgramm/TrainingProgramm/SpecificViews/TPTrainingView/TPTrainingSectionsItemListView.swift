//
//  TPEmomSectionTableView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/5/20.
//

import UIKit

public protocol TPTrainingSectionsItemListViewDelegate: class {
    func tpTrainingSectionsItemListViewItems(_ sender: TPTrainingSectionsItemListView) -> [String]
    
}

private extension TPTrainingSectionsItemListView {
    enum Const {
        static let collapsedItemHeight: CGFloat = 284
    }
}

public class TPTrainingSectionsItemListView: UIStackView {
    // MARK: - Properties
    public weak var viewDelegate: TPTrainingSectionsItemListViewDelegate?
    
    private var heightConstraints: [NSLayoutConstraint] = []
    private var exercises = [TPExercise]()
    
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
    
    // MARK: - Main Interface
    public func configure(with exercises: [TPExercise]) {
        self.exercises = exercises
        refreshData()
    }
    
    public func refreshData() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
        heightConstraints = []
        guard let items = viewDelegate?.tpTrainingSectionsItemListViewItems(self) else {
            return
        }
        
        for (index, _) in items.enumerated() {
            let userData: [AnyHashable: Any] = ["Index": index]
            let view = TPTrainingSectionItemContentView()
            view.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(view)
            view.userData = userData
            view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            view.configure(with: exercises)
            let heightConstraint = view.heightAnchor.constraint(equalToConstant: Const.collapsedItemHeight)
            heightConstraint.isActive = true
            heightConstraints.append(heightConstraint)
            view.viewDelegate = self
        }
    }
}

extension TPTrainingSectionsItemListView: TPTrainingSectionItemContentViewDelegate {
    public func tpTrainingSectionItemContentView(_ sender: TPTrainingSectionItemContentView, modelUpdated model: TPTrainingSectionItem, emptyFields: [TPTrainingSectionItemContentView.Field], notValidFields: [TPTrainingSectionItemContentView.Field], userData: [AnyHashable : Any]?) {
        
    }
    
    public func tpTrainingSectionItemContentWillNeedAnimateHeightChange(_ sender: TPTrainingSectionItemContentView, heightDelta: CGFloat, animationDuration: TimeInterval, userData: [AnyHashable : Any]?) {}
}
