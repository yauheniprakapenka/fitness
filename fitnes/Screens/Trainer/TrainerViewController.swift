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
    let abonementsViewController = AbonementsViewController()
    
    let calendarButton = FButtonSimple(title: "Календарь", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 16)
    let titleLabel = FLabel(fontSize: 18, weight: .regular, color: .gray, message: "Профиль тренера")
    let backButton = FButtonSimple(title: "Выйти", titleColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), size: 16)
    
    let headerView = UIView()
    let itemsView = UIView()
    let myExerciseView = UIView()
    let abonementsView = UIView()
    
    let trainingViewController = TrainingViewController()
    let trainingView = UIView()
    
    var trainerAbonements: [AbonementModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollView()
        configureBackButton()
        configureCalendarButton()
        configureTitleLabel()
        configureHeaderLayout()
        configureItemsView()
        configureTraining()
        configureExercise()
        configureAbonements()
        
        AddChildVC()
    }
 
    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: UIScreen.main.bounds.height * 1.45)
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
    
    private func configureTraining() {
        scrollView.addSubview(trainingView)
        trainingView.translatesAutoresizingMaskIntoConstraints = false
        trainingView.topAnchor.constraint(equalTo: itemsView.bottomAnchor, constant: 10).isActive = true
        trainingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        trainingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trainingView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func configureExercise() {
        scrollView.addSubview(myExerciseView)
        myExerciseView.translatesAutoresizingMaskIntoConstraints = false
        myExerciseView.topAnchor.constraint(equalTo: trainingView.bottomAnchor, constant: 100).isActive = true
        myExerciseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        myExerciseView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myExerciseView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func configureAbonements() {
        scrollView.addSubview(abonementsView)
        abonementsView.translatesAutoresizingMaskIntoConstraints = false
        abonementsView.topAnchor.constraint(equalTo: myExerciseView.bottomAnchor, constant: 100).isActive = true
        abonementsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        abonementsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        abonementsView.heightAnchor.constraint(equalToConstant: 200).isActive = true
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
    
    private func AddChildVC() {
        view.backgroundColor = .white
        
        // headerViewController
        
        let headerViewController = HeaderViewController()
        self.add(childVC: headerViewController, to: self.headerView)
        headerViewController.nameLabel.text = "Кристина Птицами"
        
        // itemsTrainerViewController
        
        let itemsTrainerViewController = ItemsTrainerViewController()
        self.add(childVC: itemsTrainerViewController, to: self.itemsView)
        itemsTrainerViewController.createButton.setTitle("Добавить тренировку", for: .normal)
        itemsTrainerViewController.createButton.addTarget(self, action: #selector(addTrainingButtonTapped), for: .touchUpInside)
        
        // trainingViewController
        
        self.add(childVC: trainingViewController, to: self.trainingView)
        trainingViewController.moreButton.addTarget(self, action: #selector(moreButtonTrainingTapped), for: .touchUpInside)
        
        // ExercisesViewController
        
        self.add(childVC: ExercisesViewController(), to: self.myExerciseView)
        
        // abonementsViewController
        
        self.add(childVC: abonementsViewController, to: self.abonementsView)
        abonementsViewController.titleLabel.text = "Созданные мной абонементы"
        abonementsViewController.abonements = trainerAbonements
        abonementsViewController.emptyAbonementImageView.image = #imageLiteral(resourceName: "empty-abonement-trainer")
        abonementsViewController.createButton.setTitle("Создать", for: .normal)
        abonementsViewController.createButton.addTarget(self, action: #selector(createAbonementButtonTapped), for: .touchUpInside)
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
            self.abonementsViewController.abonements = self.trainerAbonements
            self.abonementsViewController.reloadData()
            print(self.trainerAbonements.count)
        }
    }
}
