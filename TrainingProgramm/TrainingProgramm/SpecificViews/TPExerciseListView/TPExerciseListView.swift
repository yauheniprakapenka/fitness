//
//  ExerciseListView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/30/20.
//

// swiftlint:disable nesting

import UIKit

public protocol TPExerciseListViewDelegate: class {
    func tpExerciseListViewItems(_ sender: TPExerciseListView) -> [TPExerciseListView.ItemViewModel]
    func tpExerciseListView(_ sender: TPExerciseListView, didTapVideoPreviewAtIndex index: Int)
    func tpExerciseListView(_ sender: TPExerciseListView, didChangeCheckboxStatusAtIndex index: Int, status: Bool)
}

public extension TPExerciseListView {
    struct ItemViewModel {
        public enum ItemState {
            case normal
            case active
            case completed
        }
        
        var itemState: ItemState
        var isCheckboxVisible: Bool
        var contentViewModel: TPExerciseItemContentView.ViewModel
        
        public init(isCheckboxVisible: Bool,
                    itemState: ItemState,
                    contentViewModel: TPExerciseItemContentView.ViewModel) {
            self.isCheckboxVisible = isCheckboxVisible
            self.itemState = itemState
            self.contentViewModel = contentViewModel
        }
    }
}

public class TPExerciseListView: UITableView {
    // MARK: - Properties
    public weak var viewDelegate: TPExerciseListViewDelegate?
    
    // MARK: - Initialization
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initCommon()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        rowHeight = UITableView.automaticDimension
        dataSource = self
        register(TPExerciseListItemView.self, forCellReuseIdentifier: TPExerciseListItemView.description())
        tableFooterView = UIView()
        separatorStyle = .none
        allowsSelection = false
        clipsToBounds = true
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
}

// MARK: - UITableViewDataSource
extension TPExerciseListView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewDelegate?.tpExerciseListViewItems(self).count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = dequeueReusableCell(withIdentifier: TPExerciseListItemView.description(), for: indexPath) as? TPExerciseListItemView,
            let item = viewDelegate?.tpExerciseListViewItems(self)[indexPath.row]
            else {
                return UITableViewCell()
        }
        cell.configire(with: item,
                       delegate: self,
                       userData: ["Index": indexPath.row])
        return cell
    }
}

// MARK: - ExerciseItemContentViewDelegate
extension TPExerciseListView: TPExerciseItemContentViewDelegate {
    public func tpExerciseItemContentView(_ sender: TPExerciseItemContentView, checkboxStatusChanged status: Bool, userData: [AnyHashable : Any]?) {
        guard let index = (userData as? [String: Any])?["Index"] as? Int else { return }
        viewDelegate?.tpExerciseListView(self, didChangeCheckboxStatusAtIndex: index, status: status)
    }
    
    public func tpExerciseItemContentViewPreviewTapped(_ sender: TPExerciseItemContentView, userData: [AnyHashable : Any]?) {
        guard let index = (userData as? [String: Any])?["Index"] as? Int else { return }
        viewDelegate?.tpExerciseListView(self, didTapVideoPreviewAtIndex: index)
    }
}
