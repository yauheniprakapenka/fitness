//
//  FindTrainerViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FindTrainerViewController: UIViewController {
    
    let titleLabel = FLabel(textAligment: .center, fontSize: 18, weight: .semibold, color: .black, message: "Поиск тренера")
    let findButton = FSFSymbolButton(sfSymbol: SFSymbolEnum.magnifyingglass.rawValue)
    let backButton = FSFSymbolButton(sfSymbol: SFSymbolEnum.chevronBackward.rawValue)
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Поиск тренера"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
    }
    
    @objc private func searchButtonTapped() {
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        navigationItem.rightBarButtonItem = nil
        searchBar.becomeFirstResponder()
    }
    
}

extension FindTrainerViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("search button tapped")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("cancel button tapped")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
