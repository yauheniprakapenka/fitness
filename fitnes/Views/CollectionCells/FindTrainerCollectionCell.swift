//
//  FindTrainerCollectionCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FindTrainerCollectionCell: UICollectionViewCell {

    var data: FindTrainerModel? {
        didSet {
            guard let data = data else { return }
            avatarImage.image = data.image
            trainerNameLabel.text = data.name
            costLabel.text = data.cost
        }
    }

    let trainerNameLabel = FLabel(textAligment: .left, fontSize: 14, weight: .regular, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), message: "")
    let costLabel = FLabel(textAligment: .left, fontSize: 16, weight: .regular, color: .black, message: "")

    fileprivate let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        trainerNameLabel.numberOfLines = 2
    }

    private func configureLayout() {
        contentView.addSubview(avatarImage)
        contentView.addSubview(trainerNameLabel)
        contentView.addSubview(costLabel)

        trainerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        avatarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: contentView.frame.height/2).isActive = true

        trainerNameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 16).isActive = true
        trainerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        trainerNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        costLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        costLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        costLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
    }
}