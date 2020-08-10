//
//  NewAddExerciseViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 05.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class TrainerAddExerciseViewController: UIViewController {
    
    var scrollView: UIScrollView!
    let tableView = UITableView()
    
    let titleLabel = FLabel(fontSize: 18, weight: .semibold, color: .black, message: "Новое упражнение")
    let cancelButton = FSimpleButton(title: "Отмена", titleColor: .gray, size: 14)
    let saveButton = FSimpleButton(title: "Сохранить", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 14)
    
    let nameLabel = FLabel(fontSize: 16, weight: .semibold, color: .black, message: "Название")
    let nameTextField = FTextField(placeholderText: "Введите название")
    
    let inventoryLabel = FLabel(fontSize: 16, weight: .semibold, color: .black, message: "Тип инвентаря")
    let inventoryTextField = FTextField(placeholderText: "Выберите инвентарь")
    
    let descriptionLabel = FLabel(fontSize: 16, weight: .semibold, color: .black, message: "Описание")
    let descriptionTextField = FTextField(placeholderText: "Введите краткое описание")
    
    let videoLabel = FLabel(fontSize: 16, weight: .semibold, color: .black, message: "Видео")
    let videoTextField = FTextField(placeholderText: "Вставьте ссылку")
    
    let addTrainingLabel = FLabel(fontSize: 16, weight: .semibold, color: .black, message: "Добавить тренировку")
    
    let myTraining: [TrainingExerciseModel] = [
        TrainingExerciseModel(name: "Тренировка 1", exercise: ExerciseModelNew(name: "имя 1", inventory: "инвентарь 1", description: "описание 1", video: "это видео 1")),
        TrainingExerciseModel(name: "Тренировка 2", exercise: ExerciseModelNew(name: "имя 2", inventory: "инвентарь 2", description: "описание 2", video: "это видео 2"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollView()
        configureTitleLabel()
        configureCancelButton()
        configureSaveButton()
        configureNameLabel()
        configureNameTextField()
        configureInventoryLabel()
        configureInventoryTextField()
        configureDescriptionLabel()
        configureDescriptionTextField()
        configureVideoLabel()
        configureVideoTextField()
        configureAddTrainingLabel()
        
        setupTableView()
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: UIScreen.main.bounds.height * 1.2)
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.backgroundColor = .white
    }
    
    private func configureTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    private func configureCancelButton() {
        scrollView.addSubview(cancelButton)
        cancelButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    private func configureSaveButton() {
        scrollView.addSubview(saveButton)
        saveButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped() {
        print(#function)
    }
    
    private func configureNameLabel() {
        scrollView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
    }
    
    private func configureNameTextField() {
        scrollView.addSubview(nameTextField)
        
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureInventoryLabel() {
        scrollView.addSubview(inventoryLabel)
        
        inventoryLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40).isActive = true
        inventoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureInventoryTextField() {
        scrollView.addSubview(inventoryTextField)
        
        inventoryTextField.topAnchor.constraint(equalTo: inventoryLabel.bottomAnchor, constant: 20).isActive = true
        inventoryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        inventoryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        inventoryTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureDescriptionLabel() {
        scrollView.addSubview(descriptionLabel)
        
        descriptionLabel.topAnchor.constraint(equalTo: inventoryTextField.bottomAnchor, constant: 40).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureDescriptionTextField() {
        scrollView.addSubview(descriptionTextField)
        
        descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        descriptionTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureVideoLabel() {
        scrollView.addSubview(videoLabel)
        
        videoLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 40).isActive = true
        videoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureVideoTextField() {
        scrollView.addSubview(videoTextField)
        
        videoTextField.topAnchor.constraint(equalTo: videoLabel.bottomAnchor, constant: 20).isActive = true
        videoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        videoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        videoTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureAddTrainingLabel() {
        scrollView.addSubview(addTrainingLabel)
        
        addTrainingLabel.topAnchor.constraint(equalTo: videoTextField.bottomAnchor, constant: 40).isActive = true
        addTrainingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
}

// MARK: - Setup Table View
extension TrainerAddExerciseViewController: UITableViewDelegate {
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = #colorLiteral(red: 0.9803171754, green: 0.9804343581, blue: 0.9802773595, alpha: 1)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: addTrainingLabel.bottomAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(TitleWithCheckboxCell.self, forCellReuseIdentifier: "cell")
    }
}

extension TrainerAddExerciseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTraining.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TitleWithCheckboxCell
        cell.selectionStyle = .none
        cell.nameLabel.text = myTraining[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
