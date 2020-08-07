//
//  AbonementsViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 07.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct AbonementModel {
    var name: String
    var cost: String
    var color: String
}

class AbonementsViewController: UIViewController {
    
    let myAbonementsLabel = FLabel(textAligment: .left, fontSize: 17, weight: .bold, color: .black, message: "Мои абонементы")
    
    let myAbonementsModel = [
        AbonementModel(name: "Индивидуальный тренировочный план", cost: "$ 100", color: "blue"),
        AbonementModel(name: "Пробный недельный абонемент", cost: "$ 200", color: "pink"),
        AbonementModel(name: "Индивидуальный тренировочный план", cost: "$ 400", color: "blue"),
    ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MyAbonementsCollectionCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureUIElements()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureLayout() {
        view.addSubview(myAbonementsLabel)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            myAbonementsLabel.topAnchor.constraint(equalTo: view.topAnchor),
            myAbonementsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myAbonementsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: myAbonementsLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 160) //collectionView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func configureUIElements() {
        collectionView.backgroundColor = .white
    }
}

extension AbonementsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 150)// collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myAbonementsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyAbonementsCollectionCell
        cell.data = self.myAbonementsModel[indexPath.row]
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
