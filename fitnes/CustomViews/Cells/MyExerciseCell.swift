//
//  MyExerciseCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 03.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class MyExerciseCell: UICollectionViewCell {
    
    var data: ExercisesModel? {
        didSet {
            guard let data = data else { return }
            logoImage.image = data.image
            exerciseNameLabel.text = data.exerciseName
            kindInventoryLabel.text = data.kindInventory
        }
    }
    
    let exerciseNameLabel = FTitleLabel(textAligment: .left, fontSize: 14, weight: .bold, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), message: "")
    let kindInventoryLabel = FTitleLabel(textAligment: .left, fontSize: 16, weight: .regular, color: .black, message: "")
 
    
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
        contentView.addSubview(exerciseNameLabel)
        contentView.addSubview(kindInventoryLabel)
        
        exerciseNameLabel.translatesAutoresizingMaskIntoConstraints = false
        kindInventoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            logoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: contentView.frame.height/2),
            
            exerciseNameLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 16),
            exerciseNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            exerciseNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            

            kindInventoryLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 8),
            kindInventoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }
    
    private func configureUI() {
        exerciseNameLabel.numberOfLines = 2
    }
}
