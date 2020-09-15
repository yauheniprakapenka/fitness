//
//  FromSearchTrainerViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class TrainerFromSearchViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var scrollView: UIScrollView!
    private let profileButton = FButtonWithSFSymbol(sfSymbol: .docRichtext, color: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 28)
    private let calendarButton = FButtonSimple(title: "Расписание этого тренера", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 16)
    private let headerView = UIView()
    private let itemsView = UIView()
    private let comingTrainingView = UIView()
    private let abonementsView = UIView()
    private let placeView = FViewContentPlace()
    private let activityIndicator = FActivityIndicator()
    
    private let place = PlaceModel(address: "Ул. Кирова, 32",
                                   photo: #imageLiteral(resourceName: "kirova"),
                                   fileName: "",
                                   latitude: 52.44153252930357,
                                   longitude: 31.00078923354539)
    
    private var trainerAbonement = [
        AbonementModel(abonementName: "Индивидуальный план", cost: "4 месяца - 70 руб.", color: "blue", countVisit: 12, daysLeft: 5),
        AbonementModel(abonementName: "Безлимит Плюс", cost: "6 месяцев - 460 руб.", color: "pink", countVisit: 14, daysLeft: 44),
        AbonementModel(abonementName: "Пенсионный", cost: "1 месяц - 18 руб.", color: "orange", countVisit:8, daysLeft: 90)
    ]
    
    // MARK: - Public properties
    
    var trainer: TrainerModel?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureScrollView()
        configureCalendarButton()
        configureHeaderView()
        configureItemsView()
        configureComingTrainingView()
        configurePlaceView()
        configureAbonementsView()
        configureProfileButton()
        configureActivityIndicator()
        addChildVC()
    }
}

// MARK: - Private actions

private extension TrainerFromSearchViewController {
    
    @objc
    func writeButtonTapped() {
        let vc = ChatViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.selectedTrainer = trainer
        present(vc, animated: true)
    }
    
    @objc
    func placeViewTapped() {
        let vc = FindPlaceViewController()
        vc.trainer = trainer
        vc.place = place
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc
    func calendarButtonTapped() {
        HapticFeedback.shared.make(type: .light)
        let nav = UINavigationController(rootViewController: CalendarViewController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc
    func profileButtonTapped() {
        HapticFeedback.shared.make(type: .light)
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimate()
        }
        
        NetworkManager.shared.getUser(id: trainer?.id) {
            DispatchQueue.main.async {
                let vc = ProfileViewController()
                vc.isEditMode = false
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
                self.activityIndicator.stopAnimate()
            }
            print(apiGetUserModel)
        }
    }
}

// MARK: - Private methods

private extension TrainerFromSearchViewController {
    
    func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    func configureProfileButton() {
        scrollView.addSubview(profileButton)
        profileButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
    
    func configureCalendarButton() {
        scrollView.addSubview(calendarButton)
        calendarButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        calendarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        calendarButton.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
    }

    func configureHeaderView() {
        scrollView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: calendarButton.bottomAnchor, constant: 20).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    func configureItemsView() {
        scrollView.addSubview(itemsView)
        itemsView.translatesAutoresizingMaskIntoConstraints = false
        itemsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20).isActive = true
        itemsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        itemsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        itemsView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func configureComingTrainingView() {
        scrollView.addSubview(comingTrainingView)
        comingTrainingView.translatesAutoresizingMaskIntoConstraints = false
        comingTrainingView.topAnchor.constraint(equalTo: itemsView.bottomAnchor, constant: 20).isActive = true
        comingTrainingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        comingTrainingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        comingTrainingView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func configurePlaceView() {
        scrollView.addSubview(placeView)
        placeView.topAnchor.constraint(equalTo: comingTrainingView.bottomAnchor, constant: 110).isActive = true
        placeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        placeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        placeView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        placeView.placeImageView.image = place.photo
        placeView.addressLabel.text = place.address
        
        let placeViewTap = UITapGestureRecognizer(target: self, action: #selector(placeViewTapped))
        placeView.addGestureRecognizer(placeViewTap)
        placeView.isUserInteractionEnabled = true
    }
    
    func configureAbonementsView() {
        scrollView.addSubview(abonementsView)
        abonementsView.translatesAutoresizingMaskIntoConstraints = false
        abonementsView.topAnchor.constraint(equalTo: placeView.bottomAnchor, constant: 40).isActive = true
        abonementsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        abonementsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        abonementsView.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    func addChildVC() {
        view.backgroundColor = .white
        let headerViewController = HeaderViewController()
        
        self.add(childVC: headerViewController, to: self.headerView)
        headerViewController.nameLabel.text = trainer?.trainerName
        headerViewController.avatarImageView.image = trainer?.avatarImage
        
        let itemsTrainerViewController = ItemsTrainerViewController()
        self.add(childVC: itemsTrainerViewController, to: self.itemsView)
        itemsTrainerViewController.createButton.setTitle("Написать", for: .normal)
        itemsTrainerViewController.createButton.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
        
        self.add(childVC: ComingTrainingViewController(), to: self.comingTrainingView)
        
        let abonementsViewController = AbonementsViewController()
        self.add(childVC: abonementsViewController, to: self.abonementsView)
        abonementsViewController.titleLabel.text = "Приобрести абонемент"
        abonementsViewController.abonements = trainerAbonement
        abonementsViewController.currentVC = .trainerFormSearch
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: UIScreen.main.bounds.height * 1.3)
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
