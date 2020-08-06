//
//  ProfileMyTrainingCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 02.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class MyTrainingCollectionCell: UICollectionViewCell {
    
    var data: MyTrainingModel? {
        didSet {
            guard let data = data else { return }
            logoImage.image = data.image
            trainingNameLabel.text = data.title
            kindLabel.text = data.kind
            countLabel.text = data.count
        }
    }
    
    let trainingNameLabel = FTitleLabel(textAligment: .left, fontSize: 14, weight: .regular, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), message: "")
    let kindLabel = FTitleLabel(textAligment: .left, fontSize: 16, weight: .regular, color: .black, message: "")
    let countLabel = FTitleLabel(textAligment: .left, fontSize: 14, weight: .regular, color: .gray, message: "")
    
    fileprivate let logoImage: UIImageView = {
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
    
    private func configureLayout() {
        contentView.addSubview(logoImage)
        contentView.addSubview(trainingNameLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(kindLabel)
        
        trainingNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        kindLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            logoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: contentView.frame.height/2),
            
            trainingNameLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 16),
            trainingNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            trainingNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            kindLabel.bottomAnchor.constraint(equalTo: countLabel.topAnchor, constant: -8),
            kindLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }
    
    private func configureUI() {
        trainingNameLabel.numberOfLines = 2
    }
}
