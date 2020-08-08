//
//  TrainingPlaceView.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class TrainingPlaceView: UIView {
    
    let placeImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureTrainingPlaceView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTrainingPlaceView() {
        addSubview(placeImageView)
        
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        placeImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        placeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        placeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        placeImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2).isActive = true
        
        placeImageView.contentMode = .scaleAspectFill
        placeImageView.clipsToBounds = true
    }
}
