//
//  ProfileExercisesViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 03.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct ExercisesModel {
    var image: UIImage
    var exerciseName: String
    var kindInventory: String
}

class ExercisesViewController: UIViewController {
    
    let exerciseLabel = FLabel(fontSize: 17, weight: .bold, color: .black, message: "")
    let moreButton = FButtonSimple(title: "Все", titleColor: #colorLiteral(red: 0.2787401974, green: 0.3830315471, blue: 0.9142643213, alpha: 1), size: 14)
    
    let exercisesModel = [
        ExercisesModel(image: #imageLiteral(resourceName: "scott-webb-U5kQvbQWoG0-unsplash"), exerciseName: "Будь Арни", kindInventory: "Гантели"),
        ExercisesModel(image: #imageLiteral(resourceName: "scott-webb-U5kQvbQWoG0-unsplash"), exerciseName: "Сталлоне", kindInventory: "Скакалка"),
        ExercisesModel(image: #imageLiteral(resourceName: "scott-webb-U5kQvbQWoG0-unsplash"), exerciseName: "Бабочка", kindInventory: "Штанга"),
        ExercisesModel(image: #imageLiteral(resourceName: "scott-webb-U5kQvbQWoG0-unsplash"), exerciseName: "Сталь", kindInventory: "Брусья")
    ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MyExerciseCollectionCell.self, forCellWithReuseIdentifier: "MyExerciseCell")
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
        view.addSubview(exerciseLabel)
        view.addSubview(moreButton)
        view.addSubview(collectionView)
        
        exerciseLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        exerciseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        exerciseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        exerciseLabel.textAlignment = .left
        
        moreButton.bottomAnchor.constraint(equalTo: exerciseLabel.bottomAnchor).isActive = true
        moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func configureUIElements() {
        exerciseLabel.text = "Упражнения"
        collectionView.backgroundColor = .white
    }
    
    private func configureMoreButton() {
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    @objc func moreButtonTapped() {
        print("button tapped")
    }
}

extension ExercisesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2.5, height: 300)// collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        exercisesModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyExerciseCell", for: indexPath) as! MyExerciseCollectionCell
        cell.data = self.exercisesModel[indexPath.row]
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
