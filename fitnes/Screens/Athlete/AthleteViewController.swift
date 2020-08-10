//
//  AthleteViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 07.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class AthleteViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    let moreButton = FSFSymbolButton(sfSymbol: SFSymbolEnum.ellipsis.rawValue)
    let titleLabel = FLabel(fontSize: 18, weight: .regular, color: .gray, message: "Профиль атлета")
    let backButton = FSimpleButton(title: "Выйти", titleColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), size: 16)
    
    let headerView = UIView()
    let itemsView = UIView()
    let comingTrainingView = UIView()
    let myTrainingView = UIView()
    let myAbonementsView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollViewLayout()
        configureBackButton()
        configureMoreButton()
        configureTitleLabel()
        configureHeaderLayout()
        configureItemsLayout()
        configureComingTraininLayout()
        configureMyTrainingLayout()
        configureMyAbonements()
        
        AddChildVC()
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
    
    private func configureScrollViewLayout() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: UIScreen.main.bounds.height * 1.5)
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
    
    private func configureTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
    
    private func configureMyAbonements() {
        scrollView.addSubview(myAbonementsView)
        myAbonementsView.translatesAutoresizingMaskIntoConstraints = false
        myAbonementsView.topAnchor.constraint(equalTo: myTrainingView.bottomAnchor, constant: 100).isActive = true
        myAbonementsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        myAbonementsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myAbonementsView.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    private func AddChildVC() {
        view.backgroundColor = .white
        self.add(childVC: HeaderViewController(), to: self.headerView)
        
        let itemsAthleteViewController = ItemsAthleteViewController()
        self.add(childVC: itemsAthleteViewController, to: self.itemsView)
        itemsAthleteViewController.actionButton.setTitle("Найти тренера", for: .normal)
        itemsAthleteViewController.actionButton.addTarget(self, action: #selector(findTrainerButtonTapped), for: .touchUpInside)
        
        self.add(childVC: ComingTrainingViewController(), to: self.comingTrainingView)
        self.add(childVC: TrainingViewController(), to: self.myTrainingView)
        self.add(childVC: AbonementsViewController(), to: self.myAbonementsView)
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    @objc func moreButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(kind: 5)
        
        let vc = AthleteParameterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func findTrainerButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(kind: 5)
        
        let nav = UINavigationController(rootViewController: FindTrainerViewController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
}
