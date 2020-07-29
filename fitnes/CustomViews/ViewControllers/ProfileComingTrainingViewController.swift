//
//  ComingTrainingViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 29.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct CustomData {
    var title: String
    var image: UIImage
}

class ProfileComingTrainingViewController: UIViewController {
    
    let comingTrainingsLabel = FTitleLabel(textAligment: .left, fontSize: 17, weight: .medium, color: #colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.1333333333, alpha: 1))
    
    let data = [
        CustomData(title: "One", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8")),
        CustomData(title: "Two", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8")),
        CustomData(title: "Three", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8")),
        CustomData(title: "Four", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8")),
        CustomData(title: "Five", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8"))
    ]
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCollectionCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        layoutUI()
        configureUIElements()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func addSubviews() {
        view.addSubview(comingTrainingsLabel)
    }
    
    private func layoutUI() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            comingTrainingsLabel.topAnchor.constraint(equalTo: view.topAnchor),
            comingTrainingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            comingTrainingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: comingTrainingsLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func configureUIElements() {
        comingTrainingsLabel.text = "Ближайшие тренировки"
    }
}

extension ProfileComingTrainingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2.5, height: 300)// collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionCell
        cell.data = self.data[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 8.0
        cell.layer.shadowOpacity = 0.1
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        
        return cell
    }
}
