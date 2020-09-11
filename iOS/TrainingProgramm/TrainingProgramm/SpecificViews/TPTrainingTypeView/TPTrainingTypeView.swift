//
//  TrainingTypeView.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/26/20.
//

import UIKit

public extension TPTrainingTypeView {
    enum TrainingType: String, CaseIterable {
        case emom, amrap, forTime, rest
    }
}

public protocol TPTrainingTypeViewDelegate: class {
    func tpTrainingTypeView(sender: TPTrainingTypeView, didSelectTrainingType trainingType: TPTrainingTypeView.TrainingType)
}

@IBDesignable
public class TPTrainingTypeView: UIStackView {
    // MARK: - Properties
    public private(set) var selectedType: TrainingType?
    
    weak var viewDelegate: TPTrainingTypeViewDelegate?
    
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
            let view = TPTrainingProgramSelectableItemView()
            view.text = type.rawValue.uppercased()
            view.viewDelegate = self
            addArrangedSubview(view)
        }
    }
    
    // MARK: - Main Interface
    public func select(trainingType: TrainingType) {
        selectedType = trainingType
        guard let selectedIndex = TrainingType.allCases.firstIndex(of: trainingType) else {
            return
        }
        for (index, view) in arrangedSubviews.enumerated() {
            if let selectableItem = view as? TPTrainingProgramSelectableItemView {
                
                selectableItem.isSelected = index == selectedIndex
            }
        }
    }
    
    // MARK: - Other
    public override func prepareForInterfaceBuilder() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
        defaultPrepareForInterfaceBuilder()
    }
}

extension TPTrainingTypeView: TPSelectableItemViewDelegate {
    public func tpSelectableItemViewShouldChangeSelection(sender: TPSelectableItemView) -> Bool {
        guard let selectedType = selectedType else { return true }
        if let viewIndex = arrangedSubviews.firstIndex(of: sender),
           let typeIndex = TrainingType.allCases.firstIndex(of: selectedType) {
            return viewIndex != typeIndex
        }
        return true
    }
    
    public func tpSelectableItemView(sender: TPSelectableItemView, selectionChanged isSelected: Bool) {
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
            if let selectableItem = view as? TPTrainingProgramSelectableItemView {
                selectableItem.isSelected = false
            }
        }
        viewDelegate?.tpTrainingTypeView(sender: self, didSelectTrainingType: selectedType!)
    }
}
