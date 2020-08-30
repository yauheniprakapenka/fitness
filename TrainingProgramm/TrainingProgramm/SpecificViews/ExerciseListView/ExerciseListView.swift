//
//  ExerciseListView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/30/20.
//

// swiftlint:disable nesting

import UIKit

public protocol ExerciseListViewDelegate: class {
    func exerciseListViewItems(_ sender: ExerciseListView) -> [ExerciseListView.ItemViewModel]
    func exerciseListView(_ sender: ExerciseListView, didTapVideoPreviewAtIndex index: Int)
    func exerciseListView(_ sender: ExerciseListView, didChangeCheckboxStatusAtIndex index: Int, status: Bool)
}

public extension ExerciseListView {
    struct ItemViewModel {
        public enum ItemState {
            case normal
            case active
            case completed
        }
        
        var itemState: ItemState
        var isCheckboxVisible: Bool
        var contentViewModel: ExerciseItemContentView.ViewModel
        
        public init(isCheckboxVisible: Bool,
                    itemState: ItemState,
                    contentViewModel: ExerciseItemContentView.ViewModel) {
            self.isCheckboxVisible = isCheckboxVisible
            self.itemState = itemState
            self.contentViewModel = contentViewModel
        }
    }
}

public class ExerciseListView: UITableView {
    // MARK: - Properties
    public weak var viewDelegate: ExerciseListViewDelegate?
    
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
        register(ExerciseListItemView.self, forCellReuseIdentifier: ExerciseListItemView.description())
        tableFooterView = UIView()
        separatorStyle = .none
        allowsSelection = false
        clipsToBounds = true
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
}

// MARK: - UITableViewDataSource
extension ExerciseListView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewDelegate?.exerciseListViewItems(self).count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = dequeueReusableCell(withIdentifier: ExerciseListItemView.description(), for: indexPath) as? ExerciseListItemView,
            let item = viewDelegate?.exerciseListViewItems(self)[indexPath.row]
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
extension ExerciseListView: ExerciseItemContentViewDelegate {
    public func exerciseItemContentView(_ sender: ExerciseItemContentView, checkboxStatusChanged status: Bool, userData: [AnyHashable : Any]?) {
        guard let index = (userData as? [String: Any])?["Index"] as? Int else { return }
        viewDelegate?.exerciseListView(self, didChangeCheckboxStatusAtIndex: index, status: status)
    }
    
    public func exerciseItemContentViewPreviewTapped(_ sender: ExerciseItemContentView, userData: [AnyHashable : Any]?) {
        guard let index = (userData as? [String: Any])?["Index"] as? Int else { return }
        viewDelegate?.exerciseListView(self, didTapVideoPreviewAtIndex: index)
    }
}
