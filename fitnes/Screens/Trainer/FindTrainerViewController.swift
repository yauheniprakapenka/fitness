//
//  FindTrainerViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FindTrainerViewController: UIViewController {

    let searchBar = UISearchBar()
    
    var filteredFindTrainerModel = [TrainerModel]()
    var isFilterMode = false
    
    let findTrainerModel: [TrainerModel] = [
        TrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.34"), trainerName: "Александр Овечкин", cost: "1 занятие - 6 руб.", schoolImage: #imageLiteral(resourceName: "school1"), trainingPlace: "Стадион СОШ №12, ул. Ленина 21"),
        TrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.43"), trainerName: "Юлия Ефимова", cost: "1 занятие - 8 руб.", schoolImage: #imageLiteral(resourceName: "school1"), trainingPlace: "Ул. Хатаевича 30, Школа 50"),
        TrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.27.36"), trainerName: "Алексей Загитов", cost: "1 занятие - 5 руб.", schoolImage: #imageLiteral(resourceName: "school1"), trainingPlace: "Стадион СОШ №27, ул. Ленина 11"),
        TrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.27"), trainerName: "Алексей Ягудин", cost: "1 занятие - 11 руб.", schoolImage: #imageLiteral(resourceName: "school72"), trainingPlace: "Стадион СОШ №60, ул. Советская 2"),
        TrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.29.10"), trainerName: "Мария Колесникова", cost: "1 занятие - 9 руб.", schoolImage: #imageLiteral(resourceName: "school3"), trainingPlace: "Стадион СОШ №15, ул. Полесская 55"),
        TrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.21"), trainerName: "Вячеслав Малафеев", cost: "1 занятие - 7 руб.", schoolImage: #imageLiteral(resourceName: "school72"), trainingPlace: "Стадион СОШ №34, ул. Хатаевича 25"),
        TrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.59-1"), trainerName: "Инна Малинова", cost: "1 занятие - 8 руб.", schoolImage: #imageLiteral(resourceName: "school3"), trainingPlace: "Стадион СОШ №44, ул. Ланге 17")
    ]

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(FindTrainerCollectionCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureCollectionView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureNavigation() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Поиск тренера"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
        
        let cancelButton = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
    }
    
    @objc private func searchButtonTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        navigationItem.rightBarButtonItem = nil
        searchBar.becomeFirstResponder()
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension FindTrainerViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 160, height: 300)// collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return isFilterMode ? filteredFindTrainerModel.count : findTrainerModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FindTrainerCollectionCell
        
        cell.data = isFilterMode ? self.filteredFindTrainerModel[indexPath.row] : self.findTrainerModel[indexPath.row]
        
        cell.backgroundColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 8.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath

        return cell
    }
}

extension FindTrainerViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("search button tapped")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("cancel button tapped")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTrainer: TrainerModel?
        
        if isFilterMode {
            print(filteredFindTrainerModel[indexPath.row])
            selectedTrainer = filteredFindTrainerModel[indexPath.row]
        } else {
            print(findTrainerModel[indexPath.row])
             selectedTrainer = findTrainerModel[indexPath.row]
        }
        
        let vc = TrainerFromSearchViewController()
        vc.trainer = selectedTrainer
        present(vc, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFindTrainerModel = findTrainerModel.filter({$0.trainerName.lowercased().contains(searchText.lowercased())})
        isFilterMode = true
        
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        searchBar.showsCancelButton = false
        
        isFilterMode = false
        collectionView.reloadData()
    }
}
