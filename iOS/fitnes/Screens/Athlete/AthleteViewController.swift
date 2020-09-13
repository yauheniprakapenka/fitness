//
//  AthleteViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 07.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class AthleteViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let headerView = UIView()
    private let itemsView = UIView()
    private let comingTrainingView = UIView()
    private let trainingView = UIView()
    private let abonementsView = UIView()
    private let headerVC = HeaderViewController()
    private let abonementsViewController = AbonementsViewController()
    private let activityIndicator = FActivityIndicator()
    private let profileButton = FButtonWithSFSymbol(sfSymbol: .docRichtext, color: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 28)
    private  var scrollView: UIScrollView!

    // MARK: - Public properties
    
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
        
        updateProfileModel()
        configureScrollViewLayout()
        configureProfileButton()
        configureHeader()
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
        configureProfileData()
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
                let vc = ProfileViewController()
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
        self.activityIndicator.startAnimate()
        
        NetworkManager.shared.getUsers {
            self.activityIndicator.stopAnimate()
            
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: FindTrainerViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
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
    
    func configureProfileData() {
        SetAvatarImage.shared.set(imageView: headerVC.avatarImageView)
        SetProfileName.shared.set(label: headerVC.nameLabel)
        SetProflleDescription.shared.set(label: headerVC.descriptionLabel)
    }
    
    func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
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
    
    func configureProfileButton() {
        scrollView.addSubview(profileButton)
        profileButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
    
    func configureHeader() {
        scrollView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80).isActive = true
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
        
        self.add(childVC: headerVC, to: self.headerView)
        headerVC.nameLabel.text = "Безымянный атлет"
        headerVC.descriptionLabel.text = "У меня все получится!"
        SetAvatarImage.shared.set(imageView: headerVC.avatarImageView)
        
        let itemsAthleteVC = ItemsAthleteViewController()
        self.add(childVC: itemsAthleteVC, to: self.itemsView)
        itemsAthleteVC.actionButton.setTitle("Найти тренера", for: .normal)
        itemsAthleteVC.actionButton.addTarget(self, action: #selector(findTrainerButtonTapped), for: .touchUpInside)
        
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
