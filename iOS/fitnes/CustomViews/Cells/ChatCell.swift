//
//  ChatCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 15.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    var isOutgoing = true
    let messageLabel = FLabel(fontSize: 17, weight: .regular, color: .black, message: "")
    let containerView = UIView()
    let messageImageView = UIImageView()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        configureBackgroundMessageView()
        configureMessageLabel()
        configureMessageImageView()
    }
    
    private func configureBackgroundMessageView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.layer.cornerRadius = 10
        
        if isOutgoing {
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 160).isActive = true
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            containerView.backgroundColor = #colorLiteral(red: 0, green: 0.8082893491, blue: 0.2883248627, alpha: 1)
        } else {
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -160).isActive = true
            containerView.backgroundColor = #colorLiteral(red: 0.9090023637, green: 0.9137477279, blue: 0.9223148823, alpha: 1)
        }
    }
    
    private func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        if isOutgoing {
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
            messageLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
            messageLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        messageLabel.numberOfLines = 0
    }
    
    private func configureMessageImageView() {
        guard let image = messageImageView.image else { return }
        
        containerView.addSubview(messageImageView)
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        messageImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        messageImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        messageImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        messageImageView.image = image
        messageImageView.contentMode = .scaleAspectFit
    }
}
