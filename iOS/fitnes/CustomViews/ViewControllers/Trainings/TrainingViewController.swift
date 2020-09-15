//
//  ProfileMyTrainingViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 02.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import Common

private extension TrainingViewController {
    enum Const {
        static let emptyViewMessage = "Вы еще не добавили ни одной тренировки"
    }
}

extension TrainingViewController {
    enum State {
        case empty
        case normal
        case error(message: String)
    }
}

class TrainingViewController: UIViewController {
    
    let myTrainingsLabel = FLabel(fontSize: 17, weight: .bold, color: #colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.1333333333, alpha: 1), message: "")
    let createButton = FButtonSimple(title: "Создать", titleColor: #colorLiteral(red: 0.2787401974, green: 0.3830315471, blue: 0.9142643213, alpha: 1), size: 14)
    
    var viewModel: TrainingsViewModel?
    var state: State = .normal {
        didSet {
            configureState()
        }
    }
    private var trainings: [TrainingModel] = []
    weak var activityIndicator: ActivityIndicatorProtocol?
    private var contentInset: UIEdgeInsets
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MyTrainingCollectionCell.self, forCellWithReuseIdentifier: "MyTrainingCell")
        return cv
    }()
    
    private let emptyListView: EmptyListView = {
       let view = EmptyListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.messageText = Const.emptyViewMessage
        view.buttonTitle = "Добавить"
        view.image = UIImage(named: "exercisesListView_noExercises")!
        view.buttonTextColor = UIColor(named: "fitness_BlueAccent")!
        view.messageColor = UIColor(named: "fitness_BlackText")!
        return view
    }()
    
    init(contentInset: UIEdgeInsets = .zero) {
        self.contentInset = contentInset
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        contentInset = .zero
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureUIElements()
        configureCreateElements()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = contentInset
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        viewModel?.onTrainingListChanged = { [weak self] trainings in
            self?.trainings = trainings
            self?.collectionView.reloadData()
            self?.state = trainings.isEmpty ? .empty : .normal
        }
        viewModel?.onLoadingStatusChanged = { [weak self] isLoading in
            if isLoading {
                self?.activityIndicator?.startIndicator()
            } else {
                self?.activityIndicator?.stopIndicator()
            }
        }
        viewModel?.onError = { [weak self] message in
            self?.state = .error(message: message ?? "Неизвестная ошибка")
        }
        
        viewModel?.viewPrepared()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    private func configureLayout() {
        view.addSubview(myTrainingsLabel)
        view.addSubview(createButton)
        view.addSubview(collectionView)
        view.addSubview(emptyListView)
        myTrainingsLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            myTrainingsLabel.topAnchor.constraint(equalTo: view.topAnchor),
            myTrainingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: contentInset.left),
            myTrainingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -contentInset.right),
            
            createButton.bottomAnchor.constraint(equalTo: myTrainingsLabel.bottomAnchor),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            collectionView.topAnchor.constraint(equalTo: myTrainingsLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1),
            emptyListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyListView.topAnchor.constraint(equalTo: myTrainingsLabel.bottomAnchor, constant: 20),
            emptyListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureUIElements() {
        myTrainingsLabel.text = "Мои тренировки"
        collectionView.backgroundColor = .white
    }
    
    private func configureState() {
        switch state {
        case .normal:
            collectionView.isHidden = false
            createButton.isHidden = false
            emptyListView.isHidden = true
        case .empty:
            collectionView.isHidden = true
            createButton.isHidden = true
            emptyListView.isHidden = false
            emptyListView.buttonHidden = false
            emptyListView.messageText = Const.emptyViewMessage
        case .error(message: let message):
            collectionView.isHidden = true
            createButton.isHidden = false
            emptyListView.isHidden = false
            emptyListView.buttonHidden = true
            emptyListView.messageText = message
        }
    }
    
    private func configureCreateElements() {
        emptyListView.onActionButtonTapped = handleCreateTapped
        createButton.addTarget(self, action: #selector(handleCreateTapped), for: .touchUpInside)
    }
    
    @objc
    private func handleCreateTapped() {
        viewModel?.createTrainingTapped()
    }
    
}

extension TrainingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2.5, height: 300)// collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trainings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTrainingCell", for: indexPath) as! MyTrainingCollectionCell
        cell.data = self.trainings[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 8.0
        cell.layer.shadowOpacity = 0.1
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.trainingSelected(index: indexPath.item)
    }
}
