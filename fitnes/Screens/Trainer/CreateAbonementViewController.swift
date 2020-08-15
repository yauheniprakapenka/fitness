//
//  CreateAbonementViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 15.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class CreateAbonementViewController: UIViewController {
    
    let nameLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: "Название абонемента")
    let nameTextField = FTextField(placeholderText: "Введите название абонемента", placeholderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    let costLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: "Стоимость")
    let costTextField = FTextField(placeholderText: "Введите стоимость абонемента", placeholderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    let durationLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: "Длительность")
    let durationTextField = FTextField(placeholderText: "Введите длительность абонемента", placeholderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    let visitLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: "Посещения")
    let visitTextField = FTextField(placeholderText: "Введите количество посещений", placeholderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigation()
        
        configureNameLabel()
        configureNameTextField()
        
        configureCostLabel()
        configureCostTextField()
        
        configureDurationLabel()
        configureDurationTextField()
        
        configureVisitLabel()
        configureVisitTextField()
    }
    
    private func configureNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureCostLabel() {
        view.addSubview(costLabel)
        costLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        costLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        costLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureCostTextField() {
        view.addSubview(costTextField)
        costTextField.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 10).isActive = true
        costTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        costTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        costTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureDurationLabel() {
        view.addSubview(durationLabel)
        durationLabel.topAnchor.constraint(equalTo: costTextField.bottomAnchor, constant: 20).isActive = true
        durationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        durationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureDurationTextField() {
        view.addSubview(durationTextField)
        durationTextField.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 10).isActive = true
        durationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        durationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        durationTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureVisitLabel() {
        view.addSubview(visitLabel)
        visitLabel.topAnchor.constraint(equalTo: durationTextField.bottomAnchor, constant: 20).isActive = true
        visitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        visitLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureVisitTextField() {
        view.addSubview(visitTextField)
        visitTextField.topAnchor.constraint(equalTo: visitLabel.bottomAnchor, constant: 10).isActive = true
        visitTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        visitTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        visitTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK: - Configure navigation
    
    private func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Новый абонемент"
        
        let cancelButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        
        let saveutton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveutton
    }
    
    @objc
    private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func saveButtonTapped() {
        dismiss(animated: true)
    }
}
