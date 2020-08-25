//
//  AthleteQRAbonementViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 17.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class AthleteQRAbonementViewController: UIViewController {
    
    var abonement: AbonementModel!
    
    let backButton = UIButton()
    let qrImageView = UIImageView()
    
    let abonementNameLabel = FLabel(fontSize: 34, weight: .semibold, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), message: "Не указано")
    let costLabel = FLabel(fontSize: 22, weight: .regular, color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), message: "Не указано")
    
    let trainingRemaingCountLabel = FLabel(fontSize: 56, weight: .semibold, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), message: "Не указано")
    let trainingRemaingMessageLabel = FLabel(fontSize: 22, weight: .light, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), message: "Не указано")
    
//    let fAlertView = FAlertView(backgroundImage: #imageLiteral(resourceName: "fat-girl"), confirmButtonText: "Купить")
    
    let circleView = UIView()
    let messageInCirceViewLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        configureBackButton()
        
        configureAbonementNameLabel()
        configureCostLabel()
        configureTrainingRemaingMessage()
        configureTrainingLeftNumber()
        configureQrImageView()
        
        configureCircleButton()
    }
    
    private func configureBackButton() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), for: .normal)
        
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        backButton.addTarget(self, action: #selector(backButtonTapepd), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapepd() {
        dismiss(animated: true)
    }
    
    private func configureAbonementNameLabel() {
        view.addSubview(abonementNameLabel)
        abonementNameLabel.text = abonement.abonementName
        abonementNameLabel.numberOfLines = 2
        
        abonementNameLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30).isActive = true
        abonementNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        abonementNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureCostLabel() {
        view.addSubview(costLabel)
        costLabel.text = abonement.cost
        
        costLabel.topAnchor.constraint(equalTo: abonementNameLabel.bottomAnchor, constant: 10).isActive = true
        costLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        costLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureTrainingLeftNumber() {
        view.addSubview(trainingRemaingCountLabel)
        trainingRemaingCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trainingRemaingCountLabel.bottomAnchor.constraint(equalTo: trainingRemaingMessageLabel.topAnchor, constant: -20).isActive = true
        trainingRemaingCountLabel.text = String(abonement.countVisit)
    }
    
    private func configureTrainingRemaingMessage() {
        view.addSubview(trainingRemaingMessageLabel)
        trainingRemaingMessageLabel.text = "Осталось\nтренировок"
        trainingRemaingMessageLabel.numberOfLines = 2
        trainingRemaingMessageLabel.textAlignment = .center
        
        trainingRemaingMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trainingRemaingMessageLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
    
    @objc
    private func cancelButtonTapped() {
//        fAlertView.removeFromSuperview()
    }
    
    @objc
    private func confirmButtonTapped() {
        let vc = AthleteViewController()
        vc.athleteAbonement.insert(abonement, at: 0)
        vc.reloadData()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func configureQrImageView() {
        view.addSubview(qrImageView)
        
        let size: CGFloat = 200
        
        qrImageView.contentMode = .scaleAspectFit
        qrImageView.translatesAutoresizingMaskIntoConstraints = false
        
        qrImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        qrImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        qrImageView.heightAnchor.constraint(equalToConstant: size).isActive = true
        qrImageView.widthAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    @objc
    private func generateQR() {
        let image = QRGenerator.shared.generateQRCode(string: "Hello World")
        qrImageView.image = image
    }
    
}

// MARK: - Configure Circle button

extension AthleteQRAbonementViewController {
    
    private func configureCircleButton() {
        configureNcircleView()
        configureNessageInCirceViewLabel()
    }
    
    private func configureNcircleView() {
        view.addSubview(circleView)
        
        let size: CGFloat = 200
        let radius: CGFloat = size / 2
        
        circleView.backgroundColor = .white
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.clipsToBounds = true
        circleView.layer.cornerRadius = radius
        
        circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: size).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: size).isActive = true
        
        circleView.layer.borderColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        circleView.layer.borderWidth = 10
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(circleViewTapped))
        circleView.addGestureRecognizer(tap)
        circleView.isUserInteractionEnabled = true
    }
    
    @objc
    private func circleViewTapped() {
        circleView.removeFromSuperview()
        generateQR()
    }
    
    private func configureNessageInCirceViewLabel() {
        circleView.addSubview(messageInCirceViewLabel)
        messageInCirceViewLabel.translatesAutoresizingMaskIntoConstraints = false
        messageInCirceViewLabel.text = "Нажмите, чтобы\nсоздать QR-код"
        messageInCirceViewLabel.textAlignment = .center
        messageInCirceViewLabel.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        messageInCirceViewLabel.numberOfLines = 2
        messageInCirceViewLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        messageInCirceViewLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        messageInCirceViewLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
    }
}
