//
//  ChatViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 09.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct ChatModel {
    var isOutgoing: Bool
    var message: String
}

class ChatViewController: UIViewController {
    
    let tableView = UITableView()
    
    let chatTextField = FTextField()
    let backButton = FSimpleButton(title: "Назад", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 16)
    
    let headerView = HorisontalLineView()
    
    var selectedTrainer: FindTrainerModel?
    let trainerNameLabel = FLabel(textAligment: .center, fontSize: 12, weight: .regular, color: .gray, message: "")
    
    let avatarImageView = UIImageView()
    
    var chatModel: [ChatModel] = [
        ChatModel(isOutgoing: true, message: "Добрый вечер Юля! Мы с вами уже сегодня общались. Могу я получить программу тренировки qr коду?"),
        ChatModel(isOutgoing: false, message: "Добрый вечер! Вот программа. Сканируйте код и отмечайте выполненные задания")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureHeaderView()
        
        configureBackButton()
        configureAvatarImageView()
        configureTrainerNameLabel()
        
        configureChatTextField()
        configureTableView()
        
        print(selectedTrainer)
    }
    
    private func configureHeaderView() {
        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        headerView.backgroundColor = #colorLiteral(red: 0.959921658, green: 0.9648196101, blue: 0.9689807296, alpha: 1)
    }
    
    private func configureTrainerNameLabel() {
        headerView.addSubview(trainerNameLabel)
        trainerNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10).isActive = true
        trainerNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trainerNameLabel.text = selectedTrainer?.trainerName
    }
    
    private func configureBackButton() {
        headerView.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 45).isActive = true
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func configureAvatarImageView() {
        headerView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 40).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        avatarImageView.image = selectedTrainer?.avatarImage
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 35
        avatarImageView.contentMode = .scaleAspectFit
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    private func configureChatTextField() {
        view.addSubview(chatTextField)
        chatTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        chatTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chatTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chatTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        chatTextField.placeholder = "Сообщение"
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: chatTextField.topAnchor, constant: -60).isActive = true
        
        tableView.register(ChatCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ChatViewController: UITableViewDelegate {
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatCell
        cell.isOutgoing = chatModel[indexPath.row].isOutgoing
        cell.messageLabel.text = chatModel[indexPath.row].message
        
        return cell
    }
}

class ChatCell: UITableViewCell {
    
    var isOutgoing = true
    let messageLabel = FLabel(textAligment: .left, fontSize: 17, weight: .regular, color: .black, message: "")
    let backgroundMessageView = UIView()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        configureBackgroundMessageView()
        configureMessageLabel()
    }
    
    private func configureBackgroundMessageView() {
        addSubview(backgroundMessageView)
        backgroundMessageView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundMessageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        backgroundMessageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        backgroundMessageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundMessageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundMessageView.layer.cornerRadius = 10
        
        if isOutgoing {
            backgroundMessageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 160).isActive = true
            backgroundMessageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            backgroundMessageView.backgroundColor = #colorLiteral(red: 0, green: 0.8082893491, blue: 0.2883248627, alpha: 1)
        } else {
            backgroundMessageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            backgroundMessageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -160).isActive = true
            backgroundMessageView.backgroundColor = #colorLiteral(red: 0.9090023637, green: 0.9137477279, blue: 0.9223148823, alpha: 1)
        }
    }
    
    private func configureMessageLabel() {
        backgroundMessageView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: backgroundMessageView.topAnchor).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: backgroundMessageView.bottomAnchor).isActive = true
        if isOutgoing {
            messageLabel.leadingAnchor.constraint(equalTo: backgroundMessageView.leadingAnchor, constant: 8).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: backgroundMessageView.trailingAnchor, constant: -8).isActive = true
            messageLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            messageLabel.leadingAnchor.constraint(equalTo: backgroundMessageView.leadingAnchor, constant: 8).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: backgroundMessageView.trailingAnchor, constant: -8).isActive = true
            messageLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        messageLabel.numberOfLines = 0
    }
}
