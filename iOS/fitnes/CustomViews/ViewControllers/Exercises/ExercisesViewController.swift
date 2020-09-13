//
//  ProfileExercisesViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 03.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct ExercisesModel {
    var image: UIImage
    var exerciseName: String
    var kindInventory: String
}

extension ExercisesViewController {
    enum State {
        case empty
        case normal
    }
}

class ExercisesViewController: UIViewController {
    
    let exerciseLabel = FLabel(fontSize: 17, weight: .bold, color: .black, message: "")
    let createButton = FButtonSimple(title: "Создать", titleColor: #colorLiteral(red: 0.2787401974, green: 0.3830315471, blue: 0.9142643213, alpha: 1), size: 14)
    let activityIndicator = FActivityIndicator()
    
    private var exercises: [ExercisesModel] = []
    
    var viewModel: ExercisesViewModel?
    
    var state: State = .normal {
        didSet {
            configureState()
        }
    }
    
    let contentInset: UIEdgeInsets
    
    init(contentInset: UIEdgeInsets = .zero) {
        self.contentInset = contentInset
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        contentInset = .zero
        super.init(coder: coder)
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MyExerciseCollectionCell.self, forCellWithReuseIdentifier: "MyExerciseCell")
        return cv
    }()
    
    private let emptyListView: EmptyListView = {
       let view = EmptyListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.messageText = "Вы еще не добавили ни одного упражнения"
        view.buttonTitle = "Добавить"
        view.image = UIImage(named: "exercisesListView_noExercises")!
        view.buttonTextColor = UIColor(named: "fitness_BlueAccent")!
        view.messageColor = UIColor(named: "fitness_BlackText")!
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureUIElements()
        configureMoreButton()
        configureActivityIndicator()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = contentInset
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        configureState()
        
        viewModel?.onExercisesListChanged = { [weak self] exercises in
            self?.exercises = exercises
            self?.collectionView.reloadData()
        }
        viewModel?.onLoadingStatusChanged = { [weak self] status in
            if status {
                self?.activityIndicator.startAnimate()
            } else {
                self?.activityIndicator.stopAnimate()
            }
        }
        viewModel?.viewPrepared()
    }
    
    private func configureLayout() {
        view.addSubview(exerciseLabel)
        view.addSubview(createButton)
        view.addSubview(collectionView)
        view.addSubview(emptyListView)
        
        exerciseLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        exerciseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: contentInset.left).isActive = true
        exerciseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -contentInset.right).isActive = true
        exerciseLabel.textAlignment = .left
        
        createButton.bottomAnchor.constraint(equalTo: exerciseLabel.bottomAnchor).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1).isActive = true
        
        emptyListView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emptyListView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive  = true
        emptyListView.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 20).isActive = true
        emptyListView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureUIElements() {
        exerciseLabel.text = "Упражнения"
        collectionView.backgroundColor = .white
        emptyListView.onActionButtonTapped = createButtonTapped
    }
    
    private func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    private func configureMoreButton() {
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    
    @objc func createButtonTapped() {
        viewModel?.createExerciseTapped()
    }
}

private extension ExercisesViewController {
    func configureState() {
        switch state {
        case .normal:
            collectionView.isHidden = false
            createButton.isHidden = false
            emptyListView.isHidden = true
        case .empty:
            collectionView.isHidden = true
            createButton.isHidden = true
            emptyListView.isHidden = false
        }
    }
}

extension ExercisesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2.5, height: 300)// collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        exercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyExerciseCell", for: indexPath) as! MyExerciseCollectionCell
        cell.data = self.exercises[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 8.0
        cell.layer.shadowOpacity = 0.1
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
}
