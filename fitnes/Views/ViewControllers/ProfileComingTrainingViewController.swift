//
//  ComingTrainingViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 29.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct ComingTrainingModel {
    var title: String
    var image: UIImage
    var count: String
    var street: String
    var date: String
    var time: String
}

class ProfileComingTrainingViewController: UIViewController {
    
    let comingTrainingsLabel = FTitleLabel(textAligment: .left, fontSize: 17, weight: .bold, color: #colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.1333333333, alpha: 1), message: "")
    let moreButton = FSimpleButton(title: "Все", titleColor: #colorLiteral(red: 0.2787401974, green: 0.3830315471, blue: 0.9142643213, alpha: 1), size: 14)
    
    let comingTraining = [
        ComingTrainingModel(title: "Название тренировки", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8"), count: "15", street: "Ул. Немига", date: "23.08", time: "12:00"),
        ComingTrainingModel(title: "Название тренировки", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8"), count: "12", street: "Ул. Кирова", date: "23.08", time: "12:00"),
        ComingTrainingModel(title: "Название тренировки", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8"), count: "6", street: "Ул. Советская", date: "23.08", time: "12:00"),
        ComingTrainingModel(title: "Название тренировки", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8"), count: "3", street: "Ул. Ленина", date: "23.08", time: "12:00"),
        ComingTrainingModel(title: "Название тренировки", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8"), count: "1", street: "Ул. Поллеская", date: "23.08", time: "12:00")
    ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ComingTrainingCollectionCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureUIElements()
        configureMoreButton()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureLayout() {
        view.addSubview(comingTrainingsLabel)
        view.addSubview(moreButton)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            comingTrainingsLabel.topAnchor.constraint(equalTo: view.topAnchor),
            comingTrainingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            comingTrainingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            moreButton.bottomAnchor.constraint(equalTo: comingTrainingsLabel.bottomAnchor),
            moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            collectionView.topAnchor.constraint(equalTo: comingTrainingsLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func configureUIElements() {
        comingTrainingsLabel.text = "Ближайшие тренировки"
        collectionView.backgroundColor = .white
    }
    
    private func configureMoreButton() {
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    @objc func moreButtonTapped() {
        print("button tapped")
    }
}

extension ProfileComingTrainingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2.5, height: 300)// collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comingTraining.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ComingTrainingCollectionCell
        cell.data = self.comingTraining[indexPath.row]
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
