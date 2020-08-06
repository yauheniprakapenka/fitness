//
//  CustomCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 29.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ComingTrainingCollectionCell: UICollectionViewCell {
    
    var data: ComingTrainingModel? {
        didSet {
            guard let data = data else { return }
            logoImage.image = data.image
            trainingNameLabel.text = data.title
            countLabel.text = data.count
            dateLabel.text = data.date
            streetlabel.text = data.street
            timeLabel.text = data.time
        }
    }
    
    let trainingNameLabel = FTitleLabel(textAligment: .left, fontSize: 14, weight: .regular, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), message: "")
    let circleView = CircleView(x: 105, y: 10, size: 32 , color: #colorLiteral(red: 0.0002395628253, green: 0.5160111189, blue: 0.9560294747, alpha: 1))
    let countLabel = FTitleLabel(textAligment: .center, fontSize: 18, weight: .regular, color: .white, message: "")
    let streetlabel = FTitleLabel(textAligment: .left, fontSize: 15, weight: .regular, color: .black, message: "")
    let dateLabel = FTitleLabel(textAligment: .left, fontSize: 14, weight: .regular, color: .gray, message: "")
    let timeLabel = FTitleLabel(textAligment: .left, fontSize: 14, weight: .regular, color: .gray, message: "")
    
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
        contentView.addSubview(circleView)
        circleView.addSubview(countLabel)
        contentView.addSubview(streetlabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        
        trainingNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            logoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: contentView.frame.height/2),
            
            trainingNameLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 16),
            trainingNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            trainingNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            countLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            streetlabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -8),
            streetlabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    private func configureUI() {
        trainingNameLabel.numberOfLines = 2
    }
}
