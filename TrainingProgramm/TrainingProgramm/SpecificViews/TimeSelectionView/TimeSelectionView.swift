//
//  TimeSelectionView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/30/20.
//

import UIKit

public protocol TimeSelectionViewDelegate: class {
    func timeSelectionViewItems(_ sender: TimeSelectionView) -> [String]
    func timeSelectionView(_ sender: TimeSelectionView, didSelectItemAtIndex index: Int)
}

private extension TimeSelectionView {
    enum Const {
        static let itemsSize = CGSize(width: 35, height: 35)
        static let itemSpacing: CGFloat = 20
    }
}

public class TimeSelectionView: UICollectionView {
    // MARK: - Properties
    public weak var viewDelegate: TimeSelectionViewDelegate?
    
    // MARK: - Initialization
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initCommon()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = Const.itemsSize
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Const.itemSpacing
        collectionViewLayout = layout
        register(TimeSelectionItemView.self, forCellWithReuseIdentifier: TimeSelectionItemView.description())
        delegate = self
        dataSource = self
        allowsSelection = true
    }
    
    // MARK: - Main Interface
    public func refreshData() {
        reloadData()
    }
    public func select(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        selectItem(at: indexPath, animated: true, scrollPosition: .init())
        for selected in indexPathsForSelectedItems ?? [] where selected != indexPath {
            deselectItem(at: selected, animated: true)
        }
    }
    
    // MARK: - Other
    public override func prepareForInterfaceBuilder() {
        defaultPrepareForInterfaceBuilder()
    }
}

// MARK: - UICollectionViewDataSource
extension TimeSelectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewDelegate?.timeSelectionViewItems(self).count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let item = viewDelegate?.timeSelectionViewItems(self)[indexPath.item],
            let cell = dequeueReusableCell(withReuseIdentifier: TimeSelectionItemView.description(), for: indexPath) as? TimeSelectionItemView else {
            return UICollectionViewCell()
        }
        cell.configure(with: item)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension TimeSelectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewDelegate?.timeSelectionView(self, didSelectItemAtIndex: indexPath.item)
        for selected in indexPathsForSelectedItems ?? [] where selected != indexPath {
            deselectItem(at: selected, animated: true)
        }
    }
}
