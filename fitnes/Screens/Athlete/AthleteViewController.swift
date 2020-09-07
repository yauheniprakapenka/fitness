//
//  AthleteViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 07.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class AthleteViewController: UIViewController {
    
    // MARK: - Properties
    
    var scrollView: UIScrollView!
    let headerView = UIView()
    let itemsView = UIView()
    let comingTrainingView = UIView()
    let trainingView = UIView()
    let abonementsView = UIView()
    let abonementsViewController = AbonementsViewController()
    let activityIndicator = FActivityIndicator()
    let findTrainerButton = FButtonWithSFSymbol(sfSymbol: "person")
    let titleLabel = FLabel(fontSize: 18, weight: .regular, color: .gray, message: "Профиль атлета")
    let backButton = FButtonSimple(title: "Выйти", titleColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), size: 16)
    
    var athleteAbonement: [AbonementModel] = [
        AbonementModel(abonementName: "Вечерний",
                       cost: "3 мес - 55 руб",
                       color: "blue",
                       countVisit: 8,
                       daysLeft: 10)
    ]
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollViewLayout()
        configureBackButton()
        configureMoreButton()
        configureTitleLabel()
        configureHeaderLayout()
        configureItemsLayout()
        configureComingTraininLayout()
        configureTrainingLayout()
        configureAbonements()
        configureActivityIndicator()
        addChildVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        abonementsViewController.currentVC = .athletVC
    }
}

// MARK: - Actions

private extension AthleteViewController {
    
    @objc
    func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    func profileButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimate()
        }
        
        NetworkManager.shared.getUser {
            DispatchQueue.main.async {
                let vc = AthleteProfileViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
                self.activityIndicator.stopAnimate()
            }
            print(apiGetUserModel)
        }
    }
    
    @objc
    func findTrainerButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        
        let nav = UINavigationController(rootViewController: FindTrainerViewController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}

// MARK: - Public methods

extension AthleteViewController {
    
    func reloadData() {
        abonementsViewController.collectionView.reloadData()
    }
}

// MARK: - Private methods

private extension AthleteViewController {
    
    func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    func configureBackButton() {
        scrollView.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func configureScrollViewLayout() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: UIScreen.main.bounds.height * 1.5)
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureMoreButton() {
        scrollView.addSubview(findTrainerButton)
        findTrainerButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        findTrainerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        findTrainerButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
    
    func configureTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func configureHeaderLayout() {
        scrollView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: findTrainerButton.bottomAnchor, constant: 0).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    func configureItemsLayout() {
        scrollView.addSubview(itemsView)
        itemsView.translatesAutoresizingMaskIntoConstraints = false
        itemsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20).isActive = true
        itemsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        itemsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        itemsView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func configureComingTraininLayout() {
        scrollView.addSubview(comingTrainingView)
        comingTrainingView.translatesAutoresizingMaskIntoConstraints = false
        comingTrainingView.topAnchor.constraint(equalTo: itemsView.bottomAnchor, constant: 20).isActive = true
        comingTrainingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        comingTrainingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        comingTrainingView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func configureTrainingLayout() {
        scrollView.addSubview(trainingView)
        trainingView.translatesAutoresizingMaskIntoConstraints = false
        trainingView.topAnchor.constraint(equalTo: comingTrainingView.bottomAnchor, constant: 100).isActive = true
        trainingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        trainingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trainingView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func configureAbonements() {
        scrollView.addSubview(abonementsView)
        abonementsView.translatesAutoresizingMaskIntoConstraints = false
        abonementsView.topAnchor.constraint(equalTo: trainingView.bottomAnchor, constant: 100).isActive = true
        abonementsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        abonementsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        abonementsView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func addChildVC() {
        view.backgroundColor = .white
        
        let headerViewController = HeaderViewController()
        self.add(childVC: headerViewController, to: self.headerView)
        headerViewController.nameLabel.text = "Алина Волк"
        
        let itemsAthleteViewController = ItemsAthleteViewController()
        self.add(childVC: itemsAthleteViewController, to: self.itemsView)
        itemsAthleteViewController.actionButton.setTitle("Найти тренера", for: .normal)
        itemsAthleteViewController.actionButton.addTarget(self, action: #selector(findTrainerButtonTapped), for: .touchUpInside)
        
        self.add(childVC: ComingTrainingViewController(), to: self.comingTrainingView)
        self.add(childVC: TrainingViewController(), to: self.trainingView)
        
        self.add(childVC: abonementsViewController, to: self.abonementsView)
        abonementsViewController.abonements = athleteAbonement
        abonementsViewController.emptyAbonementImageView.image = #imageLiteral(resourceName: "empty-abonement-athlete")
        abonementsViewController.currentVC = .athletVC
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
