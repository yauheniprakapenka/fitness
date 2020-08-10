//
//  HeaderViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 29.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class HeaderViewController: UIViewController {
    
    let avatarImageView = FAvatarImageView(frame: .zero)
    let nameLabel = FLabel(fontSize: 20, weight: .regular, color: #colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.1333333333, alpha: 1), message: "")
    let descriptionLabel = FLabel(fontSize: 13, weight: .light, color: #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), message: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureUIElements()
    }

    private func configureLayout() {
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 22),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 14),
        ])
    }
    
    private func configureUIElements() {
        avatarImageView.image = #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8")
        nameLabel.text = "\(profileInfoModel.firstName) \(profileInfoModel.lastName)"
        descriptionLabel.text = "А ну-ка быстро бросай булку хлеба"
    }
}

