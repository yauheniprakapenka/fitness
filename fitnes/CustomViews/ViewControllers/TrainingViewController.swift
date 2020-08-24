//
//  ProfileMyTrainingViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 02.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {
    
    let myTrainingsLabel = FLabel(fontSize: 17, weight: .bold, color: #colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.1333333333, alpha: 1), message: "")
    let moreButton = FButtonSimple(title: "Все", titleColor: #colorLiteral(red: 0.2787401974, green: 0.3830315471, blue: 0.9142643213, alpha: 1), size: 14)
    
    var trainingModel = [
        TrainingModel(title: "Как Сталлоне", image: #imageLiteral(resourceName: "Screenshot 08-12-2020 23.44.00"), kind: "Amrap", count: "15 упражнений"),
        TrainingModel(title: "Аэробная", image: #imageLiteral(resourceName: "Screenshot 08-12-2020 23.43.45"), kind: "For time", count: "11 упражнений"),
        TrainingModel(title: "Быстрее ветра", image: #imageLiteral(resourceName: "Screenshot 08-12-2020 23.45.49"), kind: "Amrap", count: "15 упражнений"),
        TrainingModel(title: "Велосипед", image: #imageLiteral(resourceName: "Screenshot 08-12-2020 23.44.58"), kind: "For time", count: "11 упражнений")
    ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MyTrainingCollectionCell.self, forCellWithReuseIdentifier: "MyTrainingCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureUIElements()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    private func configureLayout() {
        view.addSubview(myTrainingsLabel)
        view.addSubview(moreButton)
        view.addSubview(collectionView)
        myTrainingsLabel.textAlignment = .left
        
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
    
}

extension TrainingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2.5, height: 300)// collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trainingModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTrainingCell", for: indexPath) as! MyTrainingCollectionCell
        cell.data = self.trainingModel[indexPath.row]
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
