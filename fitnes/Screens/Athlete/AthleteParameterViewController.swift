//
//  AthleteParameterViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 07.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class AthleteParameterViewController: UIViewController {
    
    let titleLabel = FLabel(textAligment: .center, fontSize: 18, weight: .semibold, color: .black, message: "Мои параметры")
    let cancelButton = FSimpleButton(title: "Отмена", titleColor: .gray, size: 14)
    let saveButton = FSimpleButton(title: "Сохранить", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 14)
    
    var scrollView: UIScrollView!
    
    let fioLabel = FLabel(textAligment: .left, fontSize: 16, weight: .semibold, color: .black, message: "ФИО")
    let fioTextField = FTextField(placeholderText: "ФИО")
    
    let phoneLabel = FLabel(textAligment: .left, fontSize: 16, weight: .semibold, color: .black, message: "Телефон")
    let phoneTextField = FTextField(placeholderText: "Телефон")
    
    let indicatorLabel = FLabel(textAligment: .left, fontSize: 16, weight: .semibold, color: .black, message: "Показатели")
    let indicatorTextField = FTextField(placeholderText: "Показатели")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureScrollView()
        configureTitleLabel()
        configureCancelButton()
        configureSaveButton()
        
        configureFioLabel()
        configureFioTextField()
        configurePhoneLabel()
        configurePhoneTextField()
        configureIndicatorLabel()
        configureIndicatorTextField()
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: UIScreen.main.bounds.height * 3.2)
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
    
    private func configureFioLabel() {
        scrollView.addSubview(fioLabel)
        fioLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60).isActive = true
        fioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        fioLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
    }
    
    private func configureFioTextField() {
        scrollView.addSubview(fioTextField)
        
        fioTextField.topAnchor.constraint(equalTo: fioLabel.bottomAnchor, constant: 20).isActive = true
        fioTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        fioTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        fioTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configurePhoneLabel() {
        scrollView.addSubview(phoneLabel)
        
        phoneLabel.topAnchor.constraint(equalTo: fioTextField.bottomAnchor, constant: 40).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configurePhoneTextField() {
        scrollView.addSubview(phoneTextField)
        
        phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 20).isActive = true
        phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureIndicatorLabel() {
        scrollView.addSubview(indicatorLabel)
        
        indicatorLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 40).isActive = true
        indicatorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureIndicatorTextField() {
           scrollView.addSubview(indicatorTextField)
           
           indicatorTextField.topAnchor.constraint(equalTo: indicatorLabel.bottomAnchor, constant: 20).isActive = true
           indicatorTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
           indicatorTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
           indicatorTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
       }
    
}
