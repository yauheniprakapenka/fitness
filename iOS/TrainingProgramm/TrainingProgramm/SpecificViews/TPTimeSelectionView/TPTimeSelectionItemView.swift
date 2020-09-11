//
//  TimeSelectionViewCell.swift
//  TrainingProgramm
//
//  Created by Vitali on 8/30/20.
//

import UIKit

public class TPTimeSelectionItemView: UICollectionViewCell {
    // MARK: - Properties
    private weak var cellContentView: TPTimeSelectionContentView!
    
    public override var isSelected: Bool {
        didSet {
            cellContentView.isSelected = isSelected
        }
    }
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCommon()
        
    }
    
    private func initCommon() {
        let content = TPTimeSelectionContentView()
        addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.constraintAllSidesToSuperview()
        content.isUserInteractionEnabled = false
        cellContentView = content
    }
    
    // MARK: - Main Interface
    func configure(with item: String) {
        cellContentView.text = item
    }
}
