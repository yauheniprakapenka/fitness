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
        descriptionLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = descriptionLabel.font.withSize(14)
        
        let widthAnchor: CGFloat = (self.bounds.width / 2) - 4
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: widthAnchor),
        ])
    }
    
    func configureUserDataLabel() {
        addSubview(userDataLabel)
        userDataLabel.translatesAutoresizingMaskIntoConstraints = false
        userDataLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        userDataLabel.textAlignment = .right
        userDataLabel.font = userDataLabel.font.withSize(14)
        
        let widthAnchor: CGFloat = (self.bounds.width / 2) - 4
        
        NSLayoutConstraint.activate([
            userDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            userDataLabel.widthAnchor.constraint(equalToConstant: widthAnchor)
        ])
    }
}
