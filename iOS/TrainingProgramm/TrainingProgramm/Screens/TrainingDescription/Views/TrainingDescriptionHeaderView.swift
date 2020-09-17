//
//  TrainingDescriptionHeaderView.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/16/20.
//

import UIKit

public class TrainingDescriptionHeaderView: UIView {
    // MARK: - Views
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeContainerStackView: UIStackView!
    @IBOutlet weak var timeStartTitleLabel: UILabel!
    @IBOutlet weak var timeStartValueLabel: UILabel!
    
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
        let view = loadFromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.constraintAllSidesToSuperview()
    }
}
