//
//  UserInfoViewControllers.swift
//  testsst
//
//  Created by yauheni prakapenka on 29.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class TrainerViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    let calendarButton = FSimpleButton(title: "Календарь", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 16)
    let titleLabel = FLabel(fontSize: 18, weight: .regular, color: .gray, message: "Профиль тренера")
    let backButton = FSimpleButton(title: "Выйти", titleColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), size: 16)
    
    let headerView = UIView()
    let itemsView = UIView()
    
    let myExerciseView = UIView()
    
    let trainingViewController = TrainingViewController()
    let trainingView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollView()
        configureBackButton()
        configureCalendarButton()
        configureTitleLabel()
        configureHeaderLayout()
        configureItemsView()
        configureMyTrainingLayout()
        configureMyExercise()
        AddChildVC()
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: UIScreen.main.bounds.height * 1.8)
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureCalendarButton() {
        scrollView.addSubview(calendarButton)
        calendarButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        calendarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        calendarButton.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
    }
    
    private func configureBackButton() {
        scrollView.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    private func configureTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func configureHeaderLayout() {
        scrollView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
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
    
    private func configureMyTrainingLayout() {
        scrollView.addSubview(trainingView)
        trainingView.translatesAutoresizingMaskIntoConstraints = false
        trainingView.topAnchor.constraint(equalTo: itemsView.bottomAnchor, constant: 10).isActive = true
        trainingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        trainingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trainingView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func configureMyExercise() {
        scrollView.addSubview(myExerciseView)
        myExerciseView.translatesAutoresizingMaskIntoConstraints = false
        myExerciseView.topAnchor.constraint(equalTo: trainingView.bottomAnchor, constant: 100).isActive = true
        myExerciseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        myExerciseView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myExerciseView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func AddChildVC() {
        view.backgroundColor = .white
        self.add(childVC: HeaderViewController(), to: self.headerView)
        
        let itemsTrainerViewController = ItemsTrainerViewController()
        self.add(childVC: itemsTrainerViewController, to: self.itemsView)
        itemsTrainerViewController.createButton.setTitle("Новая тренировка", for: .normal)
        itemsTrainerViewController.createButton.addTarget(self, action: #selector(findTrainerButtonTapped), for: .touchUpInside)
        
        self.add(childVC: trainingViewController, to: self.trainingView)
        trainingViewController.moreButton.addTarget(self, action: #selector(moreButtonTrainingTapped), for: .touchUpInside)
        
        self.add(childVC: ExercisesViewController(), to: self.myExerciseView)
    }
    
    @objc func moreButtonTrainingTapped() {
        let newTrainingModel = TrainingModel(title: "11", image: #imageLiteral(resourceName: "photo-1476480862126-209bfaa8edc8"), kind: "22", count: "333")
//        trainingViewController.trainingModel.append()
        trainingViewController.trainingModel.insert(newTrainingModel, at: 0)
        trainingViewController.reloadData()
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    @objc func calendarButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(kind: 5)
        let nav = UINavigationController(rootViewController: CalendarViewController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
     @objc func findTrainerButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(kind: 5)
        print("button tapped")
        let vc = AddTrainingViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
