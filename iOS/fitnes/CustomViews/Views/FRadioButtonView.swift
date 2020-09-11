//
//  FRadioButton.swift
//  fitnes
//
//  Created by yauheni prakapenka on 05.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class FRadioButtonView: UIView {
    
    // MARK: - Properties
    
    private let vStackView = UIStackView()
    private let trainerContainerView = UIView()
    private let athleteContainerView = UIView()
    private let trainerWhiteCircleView = UIView()
    private let athleteWhiteCircleView = UIView()
    private let trainerVioletCircleView = UIView()
    private let athleteVioletCircleView = UIView()
    private let athleteLabel = FLabel(fontSize: 16, weight: .regular, color: .white, message: "Я атлет")
    private let trainerLabel = FLabel(fontSize: 16, weight: .regular, color: .white, message: "Я тренер")
    
    var currentRole: RoleEnum = .athlete
    
    // MARK: - Initializes
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureTrainerContainerView()
        configureAthleteContainerView()
        configureVStackView()
        configureActiveVioletView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension FRadioButtonView {
    
    func configureVStackView() {
        addSubview(vStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        vStackView.spacing = 8
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: self.topAnchor),
            vStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        vStackView.addArrangedSubview(trainerContainerView)
        vStackView.addArrangedSubview(athleteContainerView)
    }
    
    func configureTrainerContainerView() {
        configureContainerView(containerView: trainerContainerView)
        configureWhiteCircleView(whiteView: trainerWhiteCircleView, containerView: trainerContainerView)
        configureVioletCircleView(violetView: trainerVioletCircleView, whiteView: trainerWhiteCircleView)
        configureTapGesture(containerView: trainerContainerView)
        configureRoleLabel(label: trainerLabel, containerView: trainerContainerView, leadingAnchor: trainerWhiteCircleView)
    }
    
    func configureAthleteContainerView() {
        configureContainerView(containerView: athleteContainerView)
        configureWhiteCircleView(whiteView: athleteWhiteCircleView, containerView: athleteContainerView)
        configureVioletCircleView(violetView: athleteVioletCircleView, whiteView: athleteWhiteCircleView)
        configureTapGesture(containerView: athleteContainerView)
        configureRoleLabel(label: athleteLabel, containerView: athleteContainerView, leadingAnchor: athleteWhiteCircleView)
    }
    
    func configureContainerView(containerView: UIView) {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        containerView.isUserInteractionEnabled = true
    }
    
    func configureWhiteCircleView(whiteView: UIView, containerView: UIView) {
        containerView.addSubview(whiteView)
        
        let size: CGFloat = 24
        
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = size / 2
        whiteView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            whiteView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            whiteView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            whiteView.heightAnchor.constraint(equalToConstant: size),
            whiteView.widthAnchor.constraint(equalToConstant: size)
        ])
    }
    
    func configureVioletCircleView(violetView: UIView, whiteView: UIView) {
        whiteView.addSubview(violetView)
        
        let size2: CGFloat = 15
        
        violetView.translatesAutoresizingMaskIntoConstraints = false
        violetView.backgroundColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        violetView.layer.cornerRadius = size2 / 2
        violetView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            violetView.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            violetView.centerYAnchor.constraint(equalTo: whiteView.centerYAnchor),
            violetView.heightAnchor.constraint(equalToConstant: size2),
            violetView.widthAnchor.constraint(equalToConstant: size2)
        ])
    }
    
    func configureTapGesture(containerView: UIView) {
        switch containerView {
        case trainerContainerView:
            let tap = UITapGestureRecognizer(target: self, action: #selector(trainerContainerViewTap))
            containerView.addGestureRecognizer(tap)
        case athleteContainerView:
            let tap = UITapGestureRecognizer(target: self, action: #selector(athleteContainerViewTap))
            containerView.addGestureRecognizer(tap)
        default:
            print("missing container view")
        }
    }
    
    func configureRoleLabel(label: UILabel, containerView: UIView, leadingAnchor: UIView) {
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor.trailingAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func hideVioletCircleView() {
        trainerVioletCircleView.alpha = 0
        athleteVioletCircleView.alpha = 0
    }
    
    func configureActiveVioletView() {
        hideVioletCircleView()
        
        switch currentRole {
        case .athlete:
            athleteVioletCircleView.alpha = 1
        case .trainer:
            trainerVioletCircleView.alpha = 1
        }
    }
    
    // MARK: - Actions
    
    @objc
    func trainerContainerViewTap(containerView: UIView) {
        currentRole = .trainer
        configureActiveVioletView()
    }
    
    @objc
    func athleteContainerViewTap() {
        currentRole = .athlete
        configureActiveVioletView()
    }
}
