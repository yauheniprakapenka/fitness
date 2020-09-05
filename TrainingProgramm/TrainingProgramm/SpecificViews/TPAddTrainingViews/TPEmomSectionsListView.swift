//
//  TPEmomSectionTableView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/5/20.
//

import UIKit

public protocol TPEmomSectionsListViewDelegate: class {
    func tpEmomSectionsListViewItems(_ sender: TPEmomSectionsListView) -> [String]
    
}

private extension TPEmomSectionsListView {
    enum Const {
        static let collapsedItemHeight: CGFloat = 284
    }
}

public class TPEmomSectionsListView: UIStackView {
    // MARK: - Properties
    public weak var viewDelegate: TPEmomSectionsListViewDelegate?
    
    private var heightConstraints: [NSLayoutConstraint] = []
    
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
    public func refreshData() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
        heightConstraints = []
        guard let items = viewDelegate?.tpEmomSectionsListViewItems(self) else {
            return
        }
        
        for (index, _) in items.enumerated() {
            let userData: [AnyHashable: Any] = ["Index": index]
            let view = TPEmomSectionItemContentView()
            view.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(view)
            view.userData = userData
            view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            let heightConstraint = view.heightAnchor.constraint(equalToConstant: Const.collapsedItemHeight)
            heightConstraint.isActive = true
            heightConstraints.append(heightConstraint)
            view.viewDelegate = self
        }
    }
}

extension TPEmomSectionsListView: TPEmomSectionItemContentViewDelegate {
    public func tpEmomSectionItemContentViewHeightConstarintAndViewToAnimate(_ sender: TPEmomSectionItemContentView, userData: [AnyHashable : Any]?) -> (NSLayoutConstraint, UIView)? {
        guard let index = userData?["Index"] as? Int else {
            return nil
        }
        return (heightConstraints[index], self)
    }
}
