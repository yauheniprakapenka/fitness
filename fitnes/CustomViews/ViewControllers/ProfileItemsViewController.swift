//
//  UserInfoItemsViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 29.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ProfileItemsViewController: UIViewController {
    
    let topHorisontalLineView = HorisontalLineView()
    let bottomHorisontalLineView = HorisontalLineView()
    let stackView = UIStackView()
    let programView = ItemView(message: "Программ", count: "15")
    let athleteView = ItemView(message: "Атлета", count: "123")
    let createButton = FButtonWithColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Создать")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureStackView()
        configureActionButton()
    }
    
    private func configureLayout() {
        view.addSubview(topHorisontalLineView)
        view.addSubview(stackView)
        view.addSubview(bottomHorisontalLineView)
        
        topHorisontalLineView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomHorisontalLineView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topHorisontalLineView.topAnchor.constraint(equalTo: view.topAnchor),
            topHorisontalLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topHorisontalLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topHorisontalLineView.heightAnchor.constraint(equalToConstant: 1),

            stackView.topAnchor.constraint(equalTo: topHorisontalLineView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 60),
            
            bottomHorisontalLineView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            bottomHorisontalLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomHorisontalLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomHorisontalLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        stackView.addArrangedSubview(programView)
        stackView.addArrangedSubview(athleteView)
        stackView.addArrangedSubview(createButton)
    }
    
    private func configureActionButton() {
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    
     @objc func createButtonTapped() {
        print("button tapped")
        let vc = TrainerAddExerciseViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
