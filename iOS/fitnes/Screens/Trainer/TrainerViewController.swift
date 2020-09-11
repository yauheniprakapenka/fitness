//
//  UserInfoViewControllers.swift
//  testsst
//
//  Created by yauheni prakapenka on 29.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

private extension TrainerViewController {
    enum Const {
        static let horizontalListInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

class TrainerViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    let abonementsVC = AbonementsViewController()
    let trainingVC = TrainingViewController(contentInset: Const.horizontalListInsets)
    let profileButton = FButtonWithSFSymbol(sfSymbol: "person", color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), size: 28)
//    let titleLabel = FLabel(fontSize: 18, weight: .regular, color: .gray, message: "Профиль тренера")
    let calendarButton = FButtonSimple(title: "Календарь", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 16)
    let activityIndicator = FActivityIndicator()
//    let backButton = FButtonSimple(title: "Выйти", titleColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), size: 16)
    
    let headerView = UIView()
    let itemsView = UIView()
    let exerciseView = UIView()
    let trainingView = UIView()
    var placeView = UIView()
    let abonementView = UIView()
    
    var trainerAbonements: [AbonementModel] = []
    var place: PlaceModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollView()
        configureProfileButton()
//        configureBackButton()
        configureCalendarButton()
        
//        configureTitleLabel()
        
        configureHeaderView()
        configureItemsView()
        configureTrainingView()
        configureExerciseView()
        configurePlaceView()
        configureAbonementsView()
        
        addChildVC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.resizeContentSizeToFitChilds()
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.showsVerticalScrollIndicator = false
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
        calendarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        calendarButton.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
    }
    
//    private func configureBackButton() {
//        scrollView.addSubview(backButton)
//        backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
//        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//
//        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
//    private func configureTitleLabel() {
//        scrollView.addSubview(titleLabel)
//        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
//        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//    }
    
    func configureProfileButton() {
        scrollView.addSubview(profileButton)
        profileButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
    
    private func configureHeaderView() {
        scrollView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 40).isActive = true
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
    
    private func configureTrainingView() {
        scrollView.addSubview(trainingView)
        trainingView.translatesAutoresizingMaskIntoConstraints = false
        trainingView.topAnchor.constraint(equalTo: itemsView.bottomAnchor, constant: 10).isActive = true
        trainingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        trainingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trainingView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func configureExerciseView() {
        scrollView.addSubview(exerciseView)
        exerciseView.translatesAutoresizingMaskIntoConstraints = false
        exerciseView.topAnchor.constraint(equalTo: trainingView.bottomAnchor, constant: 110).isActive = true
        exerciseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        exerciseView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        exerciseView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func configurePlaceView() {
        scrollView.addSubview(placeView)
        placeView.translatesAutoresizingMaskIntoConstraints = false
        
        placeView.topAnchor.constraint(equalTo: exerciseView.bottomAnchor, constant: 130).isActive = true
        placeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        placeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        placeView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        displayState()
    }
    
    private func displayState() {
        if let place = place {
            let contentView = FViewContentPlace()
            addPlaceView(view: contentView)
            contentView.placeImageView.image = place.photo
            contentView.addressLabel.text = place.address
            
            let contentViewTap = UITapGestureRecognizer(target: self, action: #selector(contentPlaceTapped))
            contentView.addGestureRecognizer(contentViewTap)
            
            return
        }
        
        let blankView = FViewBlankPlace()
        addPlaceView(view: blankView)
        
        let blackViewTap = UITapGestureRecognizer(target: self, action: #selector(blankPlaceTapped))
        blankView.addGestureRecognizer(blackViewTap)
    }
    
    private func addPlaceView(view: UIView) {
        placeView.addSubview(view)
        view.topAnchor.constraint(equalTo: placeView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: placeView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: placeView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: placeView.bottomAnchor).isActive = true
    }
    
    @objc
    private func blankPlaceTapped() {
        let vc = SetPlaceViewController()
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc
    private func contentPlaceTapped() {
        let vc = SetPlaceViewController()
        vc.delegate = self
        vc.place = place
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
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
    
    private func configureAbonementsView() {
        scrollView.addSubview(abonementView)
        abonementView.translatesAutoresizingMaskIntoConstraints = false
        abonementView.topAnchor.constraint(equalTo: placeView.bottomAnchor, constant: 40).isActive = true
        abonementView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        abonementView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        abonementView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc
    func moreButtonTrainingTapped() {
        print(#function)
    }
    
    @objc
    func calendarButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        let nav = UINavigationController(rootViewController: CalendarViewController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc
    func addTrainingButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        print("button tapped")
    }
    
    @objc
    func createAbonementButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        
        let vc = CreateAbonementViewController()
        vc.delegate = self
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    // MARK: - Add Child VC
    
    private func addChildVC() {
        view.backgroundColor = .white
        
        // headerVC
        
        let headerViewController = HeaderViewController()
        self.add(childVC: headerViewController, to: self.headerView)
        headerViewController.nameLabel.text = "Кристина Птицами"
        
        // itemsTrainerVC
        
        let itemsTrainerViewController = ItemsTrainerViewController()
        self.add(childVC: itemsTrainerViewController, to: self.itemsView)
        itemsTrainerViewController.createButton.setTitle("Добавить тренировку", for: .normal)
        itemsTrainerViewController.createButton.addTarget(self, action: #selector(addTrainingButtonTapped), for: .touchUpInside)
        
        // trainingVC
        
        self.add(childVC: trainingVC, to: self.trainingView)
        trainingVC.moreButton.addTarget(self, action: #selector(moreButtonTrainingTapped), for: .touchUpInside)
        
        // ExercisesVC
        
        self.add(childVC: ExercisesViewController(contentInset: Const.horizontalListInsets), to: self.exerciseView)
        
        // abonementsVC
        
        self.add(childVC: abonementsVC, to: self.abonementView)
        abonementsVC.titleLabel.text = "Созданные мной абонементы"
        abonementsVC.abonements = trainerAbonements
        abonementsVC.emptyAbonementImageView.image = #imageLiteral(resourceName: "empty-abonement-trainer")
        abonementsVC.createButton.setTitle("Создать", for: .normal)
        abonementsVC.createButton.addTarget(self, action: #selector(createAbonementButtonTapped), for: .touchUpInside)
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

extension TrainerViewController: AddContactDelegate {
    
    func addContact(contact: AbonementModel) {
        self.dismiss(animated: true) {
            self.trainerAbonements.insert(contact, at: 0)
            self.abonementsVC.abonements = self.trainerAbonements
            self.abonementsVC.reloadData()
            print(self.trainerAbonements.count)
        }
    }
}

extension TrainerViewController: SetPlaceVСDelegate {
    
    func addPlace(place: PlaceModel?) {
        self.dismiss(animated: true) {
            self.place = place
            
            self.displayState()
        }
        
    }
}
