//
//  GenderViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 13.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class GenderViewController: UIViewController {
    
    // MARK: - Private methods
    
    private let stackView = UIStackView()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundImageView()
        configureStackView()
        configureLeftButton()
        configureRightButton()
    }
}

// MARK: - Private methods

private extension GenderViewController {
    
    func configureBackgroundImageView() {
        let backgroundImageView = UIImageView()
        view.addSubview(backgroundImageView)
        backgroundImageView.image = #imageLiteral(resourceName: "gender")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureLeftButton() {
        let leftButton = UIButton()
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(leftButton)
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
    }
    
    func configureRightButton() {
        let rightButton = UIButton()
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(rightButton)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Private actions

private extension GenderViewController {
    
    @objc
    func leftButtonTapped() {
        
        let gender = AthelteProfileModel(description: nil,
                                         userDataString: GenderEnum.female.rawValue,
                                         userDataInt: nil,
                                         userDataDouble: nil,
                                         apiName: "sex",
                                         typeData: .string)
        
        NetworkManager.shared.putUser(bodyData: gender) {
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
    }
    
    @objc
    func rightButtonTapped() {
        
        let gender = AthelteProfileModel(description: nil,
                                         userDataString: GenderEnum.male.rawValue,
                                         userDataInt: nil,
                                         userDataDouble: nil,
                                         apiName: "sex",
                                         typeData: .string)
        
        NetworkManager.shared.putUser(bodyData: gender) {
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
    }
}
