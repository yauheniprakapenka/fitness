//
//  TrainingDescriptionSectionHeaderView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/16/20.
//

import UIKit

public class TrainingDescriptionSectionHeaderView: UIView {
    // MARK: - Views
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
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
        let xibView = loadFromNib()
        xibView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(xibView)
        xibView.constraintAllSidesToSuperview()
    }
}
