//
//  UserInfoViewControllers.swift
//  testsst
//
//  Created by yauheni prakapenka on 29.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let headerView = UIView()
    let itemsView = UIView()
    let comingTrainingView = UIView()
    let moreButton = MoreButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        layoutUI()
        configureUIElements()
        configureMoreButton()
    }
    
    private func configureVC() {
        view.backgroundColor = .white
    }
    
    private func layoutUI() {
        view.addSubview(moreButton)
        view.addSubview(headerView)
        view.addSubview(itemsView)
        view.addSubview(comingTrainingView)
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemsView.translatesAutoresizingMaskIntoConstraints = false
        comingTrainingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 160),

            itemsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            itemsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemsView.heightAnchor.constraint(equalToConstant: 100),

            comingTrainingView.topAnchor.constraint(equalTo: itemsView.bottomAnchor, constant: 20),
            comingTrainingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            comingTrainingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            comingTrainingView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureUIElements() {
        self.add(childVC: ProfileHeaderViewController(), to: self.headerView)
        self.add(childVC: ProfileItemsViewController(), to: self.itemsView)
        self.add(childVC: ProfileComingTrainingViewController(), to: self.comingTrainingView)
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    private func configureMoreButton() {
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    @objc func moreButtonTapped() {
        print("button tapped")
    }
}
