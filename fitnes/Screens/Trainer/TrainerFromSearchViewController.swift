//
//  FromSearchTrainerViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class TrainerFromSearchViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var selectedTrainer: TrainerModel?
    
    let titleLabel = FLabel(fontSize: 18, weight: .regular, color: .gray, message: "Профиль тренера")
    let moreButton = FSimpleButton(title: "Календарь", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 16)
    
    let headerView = UIView()
    let itemsView = UIView()
    let comingTrainingView = UIView()
    let trainingPlaceView = TrainingPlaceView()
    let myAbonementsView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureScrollView()
        configureTitleLabel()
        configureMoreButton()
        configureHeaderLayout()
        
        AddChildVC()
        
        configureItemsView()
        configureComingTrainingView()
        configureTrainingPlaceView()
        configureMyAbonements()
        
        print(selectedTrainer)
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: UIScreen.main.bounds.height * 1.3)
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func configureMoreButton() {
        scrollView.addSubview(moreButton)
        moreButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        moreButton.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
    }
    
    @objc func calendarButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(kind: 5)
        let nav = UINavigationController(rootViewController: CalendarViewController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    private func configureHeaderLayout() {
        scrollView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 20).isActive = true
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
        trainingPlaceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        trainingPlaceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        trainingPlaceView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        trainingPlaceView.trainingPlaceImageView.image = selectedTrainer?.schoolImage
        trainingPlaceView.descriptionPlaceLabel.text = selectedTrainer?.trainingPlace
        
        trainingPlaceView.mapButton.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
    }
    
    @objc private func mapButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(kind: 4)
        let vc = MapViewController()
        vc.selectedTrainer = selectedTrainer
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func configureMyAbonements() {
        scrollView.addSubview(myAbonementsView)
        myAbonementsView.translatesAutoresizingMaskIntoConstraints = false
        myAbonementsView.topAnchor.constraint(equalTo: trainingPlaceView.bottomAnchor, constant: 40).isActive = true
        myAbonementsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        myAbonementsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myAbonementsView.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    @objc private func writeButtonTapped() {
        let vc = ChatViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.selectedTrainer = selectedTrainer
        present(vc, animated: true)
    }
    
    private func AddChildVC() {
        view.backgroundColor = .white
        let headerViewController = HeaderViewController()
        
        self.add(childVC: headerViewController, to: self.headerView)
        headerViewController.nameLabel.text = selectedTrainer?.trainerName
        headerViewController.avatarImageView.image = selectedTrainer?.avatarImage
        
        let itemsTrainerViewController = ItemsTrainerViewController()
        self.add(childVC: itemsTrainerViewController, to: self.itemsView)
        itemsTrainerViewController.createButton.setTitle("Написать", for: .normal)
        itemsTrainerViewController.createButton.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
        
        self.add(childVC: ComingTrainingViewController(), to: self.comingTrainingView)
        
        let abonementsViewController = AbonementsViewController()
        self.add(childVC: abonementsViewController, to: self.myAbonementsView)
        abonementsViewController.titleLabel.text = "Приобрести абонемент"
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}
