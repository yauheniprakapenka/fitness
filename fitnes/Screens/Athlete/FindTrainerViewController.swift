//
//  FindTrainerViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct FindTrainerModel {
    var avatarImage: UIImage
    var name: String
    var cost: String
    var schoolImage: UIImage
    var trainingPlace: String
}

class FindTrainerViewController: UIViewController {

    let searchBar = UISearchBar()
    
    var filteredFindTrainerModel = [FindTrainerModel]()
    var isFilterMode = false
    
    let findTrainerModel: [FindTrainerModel] = [
        FindTrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.34"), name: "Александр Овечкин", cost: "$130", schoolImage: #imageLiteral(resourceName: "school1"), trainingPlace: "Стадион СОШ №12, ул. Ленина 21"),
        FindTrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.43"), name: "Юлия Ефимова", cost: "$90", schoolImage: #imageLiteral(resourceName: "school50"), trainingPlace: "Стадион СОШ №55, ул. Кирова 55"),
        FindTrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.27.36"), name: "Алексей Загитов", cost: "$115", schoolImage: #imageLiteral(resourceName: "school1"), trainingPlace: "Стадион СОШ №27, ул. Ленина 11"),
        FindTrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.27"), name: "Алексей Ягудин", cost: "$80", schoolImage: #imageLiteral(resourceName: "school72"), trainingPlace: "Стадион СОШ №60, ул. Советская 2"),
        FindTrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.29.10"), name: "Мария Колесникова", cost: "$120", schoolImage: #imageLiteral(resourceName: "school3"), trainingPlace: "Стадион СОШ №15, ул. Полесская 55"),
        FindTrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.21"), name: "Вячеслав Малафеев", cost: "$130", schoolImage: #imageLiteral(resourceName: "school72"), trainingPlace: "Стадион СОШ №34, ул. Хатаевича 25"),
        FindTrainerModel(avatarImage: #imageLiteral(resourceName: "Screenshot 08-08-2020 14.28.59-1"), name: "Инна Малинова", cost: "$130", schoolImage: #imageLiteral(resourceName: "school3"), trainingPlace: "Стадион СОШ №44, ул. Ланге 17")
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
        CGSize(width: 160, height: 260)// collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return isFilterMode ? filteredFindTrainerModel.count : findTrainerModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FindTrainerCollectionCell
        
        cell.data = isFilterMode ? self.filteredFindTrainerModel[indexPath.row] : self.findTrainerModel[indexPath.row]
        
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

extension FindTrainerViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("search button tapped")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("cancel button tapped")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTrainer: FindTrainerModel?
        
        if isFilterMode {
            print(filteredFindTrainerModel[indexPath.row])
            selectedTrainer = filteredFindTrainerModel[indexPath.row]
        } else {
            print(findTrainerModel[indexPath.row])
             selectedTrainer = findTrainerModel[indexPath.row]
        }
        
        let vc = FromSearchTrainerViewController()
        vc.selectedTrainer = selectedTrainer
        present(vc, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFindTrainerModel = findTrainerModel.filter({$0.name.lowercased().contains(searchText.lowercased())})
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
