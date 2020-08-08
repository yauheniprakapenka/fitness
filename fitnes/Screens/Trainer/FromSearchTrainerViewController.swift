//
//  FromSearchTrainerViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FromSearchTrainerViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var selectedTrainer: FindTrainerModel?
    
    let headerView = UIView()
    let itemsView = UIView()
    let comingTrainingView = UIView()
    
    let trainingPlaceView = TrainingPlaceView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureScrollView()
        configureHeaderLayout()
        AddChildVC()
        configureItemsView()
        configureComingTrainingView()
        
        configureTrainingPlaceView()
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: UIScreen.main.bounds.height + 1000)
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureHeaderLayout() {
        scrollView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func configureItemsView() {
        scrollView.addSubview(itemsView)
        itemsView.translatesAutoresizingMaskIntoConstraints = false
        itemsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20).isActive = true
        itemsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        itemsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        itemsView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func configureComingTrainingView() {
        scrollView.addSubview(comingTrainingView)
        comingTrainingView.translatesAutoresizingMaskIntoConstraints = false
        comingTrainingView.topAnchor.constraint(equalTo: itemsView.bottomAnchor, constant: 20).isActive = true
        comingTrainingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        comingTrainingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        comingTrainingView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func configureTrainingPlaceView() {
        scrollView.addSubview(trainingPlaceView)
        trainingPlaceView.topAnchor.constraint(equalTo: comingTrainingView.bottomAnchor, constant: 110).isActive = true
        trainingPlaceView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trainingPlaceView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trainingPlaceView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        trainingPlaceView.trainingPlaceImageView.image = selectedTrainer?.schoolImage
        trainingPlaceView.trainingPlaceLabel.text = selectedTrainer?.trainingPlace
    }
    
    private func AddChildVC() {
        view.backgroundColor = .white
        let headerViewController = HeaderViewController()
        
        self.add(childVC: headerViewController, to: self.headerView)
        headerViewController.nameLabel.text = selectedTrainer?.name
        headerViewController.avatarImageView.image = selectedTrainer?.avatarImage
        
        let itemsTrainerViewController = ItemsTrainerViewController()
        self.add(childVC: itemsTrainerViewController, to: self.itemsView)
        itemsTrainerViewController.createButton.setTitle("Написать", for: .normal)
        itemsTrainerViewController.createButton.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
        
        self.add(childVC: ComingTrainingViewController(), to: self.comingTrainingView)
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc private func writeButtonTapped() {
        print("Привет")
//        let vc = TrainerAddExerciseViewController()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
    }
}
