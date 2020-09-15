//
//  FGithubView.swift
//  fitnes
//
//  Created by yauheni prakapenka on 13.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

// MARK: - Constants

private extension FGithubView {
    enum Const {
        static let heightAnchor: CGFloat = 20
        static let copyrightColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
}

class FGithubView: UIView {
    
    // MARK: - Private properties
    
    private let githubView = UIView()
    private let githubStackView = UIStackView()
    private let githubImageView = UIImageView()
    private let githubLabel = FLabel(fontSize: 14, weight: .regular, color: Const.copyrightColor, message: "Мы на Github")
    private let copyrightLabel = FLabel(fontSize: 14, weight: .regular, color: Const.copyrightColor, message: "Хакатон 2020 © Intervale")
    
    // MARK: - View life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureGithubStackView()
        configureGithubImageView()
        configureCopyrightLabel()
        configureGestureRecogniser()
    }
    
    // MARK: - Initializer
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension FGithubView {
    
    func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureGithubStackView() {
        githubStackView.translatesAutoresizingMaskIntoConstraints = false
        githubStackView.axis = .horizontal
        githubStackView.distribution = .fillProportionally
        githubStackView.spacing = 8
        
        addSubview(githubStackView)
        
        NSLayoutConstraint.activate([
            githubStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            githubStackView.widthAnchor.constraint(equalToConstant: 110),
            githubStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            githubStackView.heightAnchor.constraint(equalToConstant: Const.heightAnchor)
        ])
        
        githubStackView.addArrangedSubview(githubImageView)
        githubStackView.addArrangedSubview(githubLabel)
    }

    func configureGithubImageView() {
        githubImageView.translatesAutoresizingMaskIntoConstraints = false
        githubImageView.image = #imageLiteral(resourceName: "GitHub-Mark-120px-plus")
        
        NSLayoutConstraint.activate([
            githubImageView.heightAnchor.constraint(equalToConstant: Const.heightAnchor),
            githubImageView.widthAnchor.constraint(equalToConstant: Const.heightAnchor)
        ])
    }
    
    func configureCopyrightLabel() {
        addSubview(copyrightLabel)
        copyrightLabel.textAlignment = .center
       
        NSLayoutConstraint.activate([
            copyrightLabel.bottomAnchor.constraint(equalTo: githubStackView.topAnchor, constant: -10),
            copyrightLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            copyrightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func configureGestureRecogniser() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(githubViewTapped))
        self.addGestureRecognizer(tap)
    }
}

// MARK: - Private actions

private extension FGithubView {
    
    @objc
    func githubViewTapped() {
        HapticFeedback.shared.make(type: .rigid)
        
        if let url = URL(string: "https://github.com/yauheniprakapenka/Fitnes") {
            UIApplication.shared.open(url)
        }
    }
}
