//
//  TrainingTypeView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/26/20.
//

import UIKit

public extension TrainingTypeView {
    enum TrainingType: String, CaseIterable {
        case emom, amrap, forTime, rest
    }
}

public protocol TrainingTypeViewDelegate: class {
    func trainingTypeView(sender: TrainingTypeView, didSelectTrainingType trainingType: TrainingTypeView.TrainingType)
}

@IBDesignable
public class TrainingTypeView: UIStackView {
    // MARK: - Properties
    public private(set) var selectedType: TrainingType?
    
    weak var viewDelegate: TrainingTypeViewDelegate?
    
    // MARK: - Initialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
    }
    
    private func initCommon() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        distribution = .fillProportionally
        spacing = 12
        for type in TrainingType.allCases {
            let view = TrainingProgramSelectableItemView()
            view.text = type.rawValue.uppercased()
            view.viewDelegate = self
            addArrangedSubview(view)
        }
    }
}

extension TrainingTypeView: SelectableItemViewDelegate {
    public func selectableItemViewShouldChangeSelection(sender: SelectableItemView) -> Bool {
        guard let selectedType = selectedType else { return true }
        if let viewIndex = arrangedSubviews.firstIndex(of: sender),
           let typeIndex = TrainingType.allCases.firstIndex(of: selectedType) {
            return viewIndex != typeIndex
        }
        return true
    }
    
    public func selectableItemView(sender: SelectableItemView, selectionChanged isSelected: Bool) {
        guard
            let viewIndex = arrangedSubviews.firstIndex(of: sender),
            isSelected
            else {
                return
        }
        selectedType = TrainingType.allCases[viewIndex]
        for (index, view) in arrangedSubviews.enumerated() {
            if index == viewIndex {
                continue
            }
            if let selectableItem = view as? TrainingProgramSelectableItemView {
                selectableItem.isSelected = false
            }
        }
        viewDelegate?.trainingTypeView(sender: self, didSelectTrainingType: selectedType!)
    }
}
