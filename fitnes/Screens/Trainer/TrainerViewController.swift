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
    
    let moreButton = FMoreButton()
    
    let headerView = UIView()
    let itemsView = UIView()
    let comingTrainingView = UIView()
    let myTrainingView = UIView()
    let myExerciseView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollViewLayout()
        configureMoreButton()
        configureHeaderLayout()
        configureItemsLayout()
        configureComingTraininLayout()
        configureMyTrainingLayout()
        configureMyExercise()
        AddChildVC()
    }
    
    private func configureScrollViewLayout() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: UIScreen.main.bounds.height + 1000)
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureMoreButton() {
        scrollView.addSubview(moreButton)
        moreButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    private func configureHeaderLayout() {
        scrollView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 0).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func configureItemsLayout() {
        scrollView.addSubview(itemsView)
        itemsView.translatesAutoresizingMaskIntoConstraints = false
        itemsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20).isActive = true
        itemsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        itemsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        itemsView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func configureComingTraininLayout() {
        scrollView.addSubview(comingTrainingView)
        comingTrainingView.translatesAutoresizingMaskIntoConstraints = false
        comingTrainingView.topAnchor.constraint(equalTo: itemsView.bottomAnchor, constant: 20).isActive = true
        comingTrainingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        comingTrainingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        comingTrainingView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func configureMyTrainingLayout() {
        scrollView.addSubview(myTrainingView)
        myTrainingView.translatesAutoresizingMaskIntoConstraints = false
        myTrainingView.topAnchor.constraint(equalTo: comingTrainingView.bottomAnchor, constant: 100).isActive = true
        myTrainingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        myTrainingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myTrainingView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func configureMyExercise() {
        scrollView.addSubview(myExerciseView)
        myExerciseView.translatesAutoresizingMaskIntoConstraints = false
        myExerciseView.topAnchor.constraint(equalTo: myTrainingView.bottomAnchor, constant: 100).isActive = true
        myExerciseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        myExerciseView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myExerciseView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func AddChildVC() {
        view.backgroundColor = .white
        self.add(childVC: ProfileHeaderViewController(), to: self.headerView)
        self.add(childVC: ProfileItemsViewController(), to: self.itemsView)
        self.add(childVC: ProfileComingTrainingViewController(), to: self.comingTrainingView)
        self.add(childVC: ProfileMyTrainingViewController(), to: self.myTrainingView)
        self.add(childVC: ProfileExercisesViewController(), to: self.myExerciseView)
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    @objc func moreButtonTapped() {
        print("button tapped")
    }
}
