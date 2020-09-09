//
//  ProfileCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ProfileAthleteCell: UITableViewCell {
    
    // MARK: - Public properties
    
    let descriptionLabel = UILabel()
    let userDataLabel = UILabel()
    
    var data: AthelteProfileModel? {
        didSet {
            guard let athleteData = data else { return }
            
            if let description = athleteData.description {
                descriptionLabel.text = description
            }
            
            if let stringData = athleteData.userDataString {
                
                if stringData.isEmpty {
                    userDataLabel.text = "Не указано"
                    userDataLabel.textColor = #colorLiteral(red: 0.2012411571, green: 0.711050549, blue: 0.6543387656, alpha: 1)
                    return
                }
                
                userDataLabel.text = stringData
                userDataLabel.textColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
                return
            }
            
            if let intData = athleteData.userDataInt {
                userDataLabel.text = String(intData)
                userDataLabel.textColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
                return
            }
            
            userDataLabel.text = "Не указано"
            userDataLabel.textColor = #colorLiteral(red: 0.2012411571, green: 0.711050549, blue: 0.6543387656, alpha: 1)
        }
    }
    
    // MARK: - Cell life cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        descriptionLabel.text = ""
        userDataLabel.text = ""
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
        descriptionLabel.numberOfLines = 3
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
        userDataLabel.textAlignment = .right
        userDataLabel.font = userDataLabel.font.withSize(14)
        userDataLabel.numberOfLines = 2
        
        let widthAnchor: CGFloat = (self.bounds.width / 2) - 4
        
        NSLayoutConstraint.activate([
            userDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userDataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            userDataLabel.widthAnchor.constraint(equalToConstant: widthAnchor)
        ])
    }
}
