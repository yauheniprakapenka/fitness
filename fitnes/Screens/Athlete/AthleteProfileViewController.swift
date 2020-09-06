//
//  AthleteParameterViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 07.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

private extension AthleteProfileViewController {
    enum Const {
        static let avatarTopAnchor: CGFloat = 120
        static let tableViewTopAnchor: CGFloat = 40
        static let leftRightMargin: CGFloat = 25
        static let screenSizeHeight: CGFloat = UIScreen.main.bounds.height
        static let imageSize: CGFloat = Const.screenSizeHeight / 6
    }
}

class AthleteProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    let avatarImageView = UIImageView()
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureNavigationBar()
        configureBackNavigationButton()
        configureAvatarImageView()
        configureTableView()
    }
}

// MARK: - Private actions

private extension AthleteProfileViewController {
    
    @objc
    private func backButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - Private methods

private extension AthleteProfileViewController {
    
    func configureView() {
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func configureBackNavigationButton() {
        let backButton = UIBarButtonItem(title: "Вернуться", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem  = backButton
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.4548649788, green: 0.4549226761, blue: 0.4548452497, alpha: 1)
    }
    
    func configureAvatarImageView() {
        view.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.image = #imageLiteral(resourceName: "Screenshot 08-12-2020 23.44.58")
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = Const.imageSize / 2
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Const.avatarTopAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: Const.imageSize),
            avatarImageView.widthAnchor.constraint(equalToConstant: Const.imageSize)
        ])
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Const.tableViewTopAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargin),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.leftRightMargin),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.register(ProfileAthleteCell.self, forCellReuseIdentifier: "cell")
        
        tableView.rowHeight = 60
    }
}

extension AthleteProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        athelteProfileModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileAthleteCell
        cell.data = athelteProfileModel[indexPath.row]
        return cell
    }
}
