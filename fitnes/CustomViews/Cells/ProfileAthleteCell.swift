//
//  ProfileCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

private extension ProfileAthleteCell {
    enum Const {
        static let leftRightMargins: CGFloat = 20
    }
}

class ProfileAthleteCell: UITableViewCell {
    
    private let descriptionLabel = UILabel()
    private let userDataLabel = UILabel()
    
    var data: AthelteProfileModel? {
        didSet {
            guard let data = data else { return }
            
            if let description = data.description {
                descriptionLabel.text = description
            }
            
            if let userData = data.userData {
                userDataLabel.text = userData
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureDescriptionLabel()
        configureUserDataLabel()
    }
}

// MARK: - Private methods

private extension ProfileAthleteCell {
    
    func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = #colorLiteral(red: 0.6077951789, green: 0.6078702807, blue: 0.6077696681, alpha: 1)
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    func configureUserDataLabel() {
        addSubview(userDataLabel)
        userDataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
