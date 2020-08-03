//
//  ProfileMyTrainingViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 02.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct MyTrainingModel {
    var title: String
    var image: UIImage
    var kind: String
    var count: String
}

class ProfileMyTrainingViewController: UIViewController {
    
    let myTrainingsLabel = FTitleLabel(textAligment: .left, fontSize: 17, weight: .bold, color: #colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.1333333333, alpha: 1))
    let moreButton = SimpleButton(title: "Все", titleColor: #colorLiteral(red: 0.2787401974, green: 0.3830315471, blue: 0.9142643213, alpha: 1), size: 14)
    
    let myTrainingModel = [
        MyTrainingModel(title: "Название тренировки", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8"), kind: "Amrap", count: "15 упражнений"),
        MyTrainingModel(title: "Название тренировки", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8"), kind: "For time", count: "11 упражнений"),
        MyTrainingModel(title: "Название тренировки", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8"), kind: "Amrap", count: "1 упражнений"),
        MyTrainingModel(title: "Название тренировки", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8"), kind: "Amrap", count: "5 упражнений")
    ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MyTrainingCell.self, forCellWithReuseIdentifier: "MyTrainingCell")
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
        view.addSubview(myTrainingsLabel)
        view.addSubview(moreButton)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            myTrainingsLabel.topAnchor.constraint(equalTo: view.topAnchor),
            myTrainingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myTrainingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            moreButton.bottomAnchor.constraint(equalTo: myTrainingsLabel.bottomAnchor),
            moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            collectionView.topAnchor.constraint(equalTo: myTrainingsLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func configureUIElements() {
        myTrainingsLabel.text = "Мои тренировки"
        collectionView.backgroundColor = .white
    }
    
    private func configureMoreButton() {
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    @objc func moreButtonTapped() {
        print("button tapped")
    }
}

extension ProfileMyTrainingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2.5, height: 300)// collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myTrainingModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTrainingCell", for: indexPath) as! MyTrainingCell
        cell.data = self.myTrainingModel[indexPath.row]
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
