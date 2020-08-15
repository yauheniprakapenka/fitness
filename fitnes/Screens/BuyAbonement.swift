//
//  BuyAbonement.swift
//  fitnes
//
//  Created by yauheni prakapenka on 12.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class BuyAbonement: UIViewController {
    
    var abonement: AbonementModel!
    
    let headerContainerView = UIView()
    
    let textureImageView = UIImageView()
    let backgroundImageView = UIImageView()
    
    let buyButton = UIButton()
    let nameLabel = FLabel(fontSize: 34, weight: .semibold, color: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), message: "Не указано")
    let costLabel = FLabel(fontSize: 22, weight: .regular, color: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), message: "Не указано")
    
    let trainingLeftNumber = FLabel(fontSize: 72, weight: .bold, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), message: "Не указано")
    let trainingLeftText = FLabel(fontSize: 24, weight: .semibold, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), message: "Не указано")
    
    let fAlertView = FAlertView(backgroundImage: #imageLiteral(resourceName: "fat-girl"), confirmButtonText: "Купить")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9694514871, green: 0.9644967914, blue: 0.9688283801, alpha: 1)
        
        configureBackgraoundView()
        
        configureHeaderView()
        configureTextureImageView()
        
        configureBuyButton()
        
        configureCostLabel()
        configureNameLabel()
        
        configureTrainingLeftNumber()
        configureTrainingLeftText()
    }
    
    private func configureBackgraoundView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = #imageLiteral(resourceName: "texture2")
        backgroundImageView.alpha = 0.2
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureHeaderView() {
        view.addSubview(headerContainerView)
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        headerContainerView.backgroundColor = #colorLiteral(red: 0.3690207899, green: 0.2840400338, blue: 0.6159453988, alpha: 1)
        headerContainerView.layer.cornerRadius = 25
        headerContainerView.clipsToBounds = true
        headerContainerView.layer.borderWidth = 1
        headerContainerView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        headerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        headerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        headerContainerView.heightAnchor.constraint(equalToConstant: 260).isActive = true
    }
    
    private func configureTextureImageView() {
        headerContainerView.addSubview(textureImageView)
        textureImageView.translatesAutoresizingMaskIntoConstraints = false
        textureImageView.image = #imageLiteral(resourceName: "texture2")
        
        textureImageView.topAnchor.constraint(equalTo: headerContainerView.topAnchor).isActive = true
        textureImageView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor).isActive = true
        textureImageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor).isActive = true
        textureImageView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor).isActive = true
    }
    
    private func configureBuyButton() {
        view.addSubview(buyButton)
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.layer.cornerRadius = 25
        buyButton.backgroundColor = #colorLiteral(red: 0.9124824405, green: 0.3163054287, blue: 0.4536244273, alpha: 1)
        buyButton.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
        buyButton.setTitle("КУПИТЬ", for: .normal)
        
        buyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buyButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func buyButtonTapped() {
        view.addSubview(fAlertView)
        fAlertView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        fAlertView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fAlertView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        fAlertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        fAlertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        fAlertView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        fAlertView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    private func configureNameLabel() {
        headerContainerView.addSubview(nameLabel)
        nameLabel.text = abonement.name
        
        nameLabel.bottomAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: -30).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureCostLabel() {
        headerContainerView.addSubview(costLabel)
        costLabel.text = abonement.cost
        
        costLabel.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: -20).isActive = true
        costLabel.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 20).isActive = true
        costLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureTrainingLeftNumber() {
        view.addSubview(trainingLeftNumber)
        trainingLeftNumber.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trainingLeftNumber.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        trainingLeftNumber.text = String(abonement.trainingLeft)
    }
    
    private func configureTrainingLeftText() {
        view.addSubview(trainingLeftText)
        trainingLeftText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trainingLeftText.topAnchor.constraint(equalTo: trainingLeftNumber.bottomAnchor, constant: 20).isActive = true
        trainingLeftText.text = "ТРЕНИРОВОК"
    }
    
    @objc
    private func cancelButtonTapped() {
        fAlertView.removeFromSuperview()
    }
    
    @objc
    private func confirmButtonTapped() {
        let vc = AthleteViewController()
        vc.athleteAbonement.insert(abonement, at: 0)
        vc.reloadData()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
