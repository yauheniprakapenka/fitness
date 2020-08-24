//
//  CreateAbonementViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 15.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

protocol AddContactDelegate: class {
    func addContact(contact: AbonementModel)
}

class CreateAbonementViewController: UIViewController {
    
    let saveButton = UIButton()
    
    weak var delegate: AddContactDelegate?
    
    let logoImageView = UIImageView()
    
    let nameLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: "Название абонемента")
    let nameTextField = FTextField(placeholderText: "Например, вечерние занятия", placeholderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    let costLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: "Стоимость, бел руб")
    let costTextField = FTextField(placeholderText: "Например, 60 бел руб", placeholderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    let durationLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: "Длительность")
    let daysLeftButton = UIButton()
    
    let visitLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: "Количество посещений")
    let visitTextField = FTextField(placeholderText: "12 посещений", placeholderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    private var selectedDayDuration: UInt8 = 0
    private var selectedColor: String = ""
    
    let abonementColorLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: "Цвет абонемента")
    private let fViewColors = FViewColors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigation()
        
        configureLogoImageView()
        
        configureNameLabel()
        configureNameTextField()
        
        configureCostLabel()
        configureCostTextField()
        
        configureDurationLabel()
        configureDurationButton()
        
        configureVisitLabel()
        configureVisitTextField()
        
        configureAbonementColorLabel()
        configureFViewColors()
        configureTapGestureFViewColors()
        
        KeyboardHandler.shared.dismissKeyboard(view: view)
    }
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = #imageLiteral(resourceName: "fitnes-woman-2")
        
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    private func configureNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30).isActive = true
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
        costTextField.keyboardType = .numberPad
    }
    
    private func configureDurationLabel() {
        view.addSubview(durationLabel)
        durationLabel.topAnchor.constraint(equalTo: costTextField.bottomAnchor, constant: 20).isActive = true
        durationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        durationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureDurationButton() {
        view.addSubview(daysLeftButton)
        daysLeftButton.translatesAutoresizingMaskIntoConstraints = false
        daysLeftButton.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 10).isActive = true
        daysLeftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        daysLeftButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        daysLeftButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        daysLeftButton.setTitle("    Например, 1 месяц", for: .normal)
        daysLeftButton.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        daysLeftButton.backgroundColor = .clear
        daysLeftButton.contentHorizontalAlignment = .left
        
        daysLeftButton.layer.cornerRadius = 5
        daysLeftButton.layer.borderWidth = 1
        daysLeftButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        daysLeftButton.addTarget(self, action: #selector(daysLeftButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func daysLeftButtonTapped() {
        showActionSheet()
    }
    
    private func configureVisitLabel() {
        view.addSubview(visitLabel)
        visitLabel.topAnchor.constraint(equalTo: daysLeftButton.bottomAnchor, constant: 20).isActive = true
        visitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        visitLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureVisitTextField() {
        view.addSubview(visitTextField)
        visitTextField.topAnchor.constraint(equalTo: visitLabel.bottomAnchor, constant: 10).isActive = true
        visitTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        visitTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        visitTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        visitTextField.keyboardType = .numberPad
    }
    
    private func configureAbonementColorLabel() {
        view.addSubview(abonementColorLabel)
        abonementColorLabel.topAnchor.constraint(equalTo: visitTextField.bottomAnchor, constant: 20).isActive = true
        abonementColorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        abonementColorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureFViewColors() {
        view.addSubview(fViewColors)
        fViewColors.translatesAutoresizingMaskIntoConstraints = false
        fViewColors.topAnchor.constraint(equalTo: abonementColorLabel.bottomAnchor, constant: 20).isActive = true
        fViewColors.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        fViewColors.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        fViewColors.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func configureTapGestureFViewColors() {
        let blueViewTap = UITapGestureRecognizer(target: self, action: #selector(blueViewTapped))
        fViewColors.blueView.addGestureRecognizer(blueViewTap)
        
        let pinkViewTap = UITapGestureRecognizer(target: self, action: #selector(pinkViewTapped))
        fViewColors.pinkView.addGestureRecognizer(pinkViewTap)
        
        let orangeViewTap = UITapGestureRecognizer(target: self, action: #selector(orangeViewTapped))
        fViewColors.orangeView.addGestureRecognizer(orangeViewTap)
    }
    
    @objc
    private func blueViewTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        selectedColor = "blue"
        fViewColors.shaowChechmark(view: .blueView)
    }
    
    @objc
    private func pinkViewTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        selectedColor = "pink"
        fViewColors.shaowChechmark(view: .pinkView)
    }
    
    @objc
    private func orangeViewTapped() {
        HapticFeedback.shared.makeHapticFeedback(type: .light)
        selectedColor = "orange"
        fViewColors.shaowChechmark(view: .orangeView)
    }
    
    // MARK: - Configure navigation
    
    private func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Новый абонемент"
        
        let cancelButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        
        let saveutton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(showDaysLeftActionSheet))
        navigationItem.rightBarButtonItem = saveutton
    }
    
    @objc
    private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func showDaysLeftActionSheet() {
        let newAbonement = AbonementModel(abonementName: nameTextField.text ?? "",
                                          cost: costTextField.text ?? "",
                                          color: selectedColor,
                                          countVisit: UInt8(visitTextField.text!) ?? 0,
                                          daysLeft: selectedDayDuration)
        
        delegate?.addContact(contact: newAbonement)
    }
    
    private func showActionSheet() {
        let dayInMonth: UInt8 = 30
        
        let alert = UIAlertController(title: "Длительность занятий", message: "Выберите длительность занятий для этого абонемента", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "1 месяц", style: .default, handler: { _ in
            self.daysLeftButton.setTitle("    1 месяц", for: .normal)
            self.selectedDayDuration = 1 * dayInMonth
        }))
        
        alert.addAction(UIAlertAction(title: "3 месяца", style: .default, handler: { _ in
            self.daysLeftButton.setTitle("    3 месяца", for: .normal)
            self.selectedDayDuration = 3 * dayInMonth
        }))
        
        alert.addAction(UIAlertAction(title: "6 месяцев", style: .default, handler: { _ in
            self.daysLeftButton.setTitle("    6 месяцев", for: .normal)
            self.selectedDayDuration = 6 * dayInMonth
        }))
        
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel))
        
        present(alert, animated: true)
    }
    
}
