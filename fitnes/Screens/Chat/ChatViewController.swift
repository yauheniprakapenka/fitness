//
//  ChatViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 09.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    let tableView = UITableView()
    
    let chatTextField = FTextField()
    
    private var timer: Timer?
    private var sendMessageCount = 0
    
    let backButton = FSimpleButton(title: "Назад", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 16)
    let sendButton = FButtonWithColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Отправить", size: 18)
    
    let headerView = HorisontalLineView()
    
    var selectedTrainer: TrainerModel?
    let trainerNameLabel = FLabel(fontSize: 12, weight: .regular, color: .gray, message: "")
    
    let avatarImageView = UIImageView()
    let messageImageView = UIImageView()
    
    var chatModel: [ChatModel] = [
        ChatModel(isOutgoing: true, messageText: "Это была отличная тренировка, ваша музыка вообще задавала ритм"),
        ChatModel(isOutgoing: false, messageText: "Музыка - это замечательный источник энергии и вдохновения")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureHeaderView()
        
        configureBackButton()
        configureAvatarImageView()
        configureTrainerNameLabel()
        
        configureSendButton()
        configureChatTextField()
        
        configureTableView()
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
    
    private func configureSendButton() {
        view.addSubview(sendButton)
        sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    @objc private func sendButtonTapped() {
        let senderMessage = chatTextField.text ?? ""
        chatModel.append(ChatModel(isOutgoing: true, messageText: senderMessage, messageImage: nil))
        tableView.reloadData()
        chatTextField.text = ""
        
        sendMessageCount += 1
        chatBotAnswer(scenario: sendMessageCount)
    }
    
    
    
    private func configureChatTextField() {
        view.addSubview(chatTextField)
        chatTextField.bottomAnchor.constraint(equalTo: sendButton.topAnchor).isActive = true
        chatTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chatTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chatTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        chatTextField.placeholder = "Сообщение"
        chatTextField.text = "Добрый вечер!\n\nСбросьте, пожалуйста, qr код с программой тренировки"
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
        cell.messageLabel.text = chatModel[indexPath.row].messageText
        
        if let image = chatModel[indexPath.row].messageImage {
            cell.messageImageView.image = image
        }
        
        return cell
    }
}

class ChatCell: UITableViewCell {
    
    var isOutgoing = true
    let messageLabel = FLabel(fontSize: 17, weight: .regular, color: .black, message: "")
    let containerView = UIView()
    let messageImageView = UIImageView()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        configureBackgroundMessageView()
        configureMessageLabel()
        configureMessageImageView()
    }
    
    private func configureBackgroundMessageView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.layer.cornerRadius = 10
        
        if isOutgoing {
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 160).isActive = true
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            containerView.backgroundColor = #colorLiteral(red: 0, green: 0.8082893491, blue: 0.2883248627, alpha: 1)
        } else {
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -160).isActive = true
            containerView.backgroundColor = #colorLiteral(red: 0.9090023637, green: 0.9137477279, blue: 0.9223148823, alpha: 1)
        }
    }
    
    private func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        if isOutgoing {
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
            messageLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
            messageLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        messageLabel.numberOfLines = 0
    }
    
    private func configureMessageImageView() {
        guard let image = messageImageView.image else { return }
        
        containerView.addSubview(messageImageView)
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        messageImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        messageImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        messageImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        messageImageView.image = image
        messageImageView.contentMode = .scaleAspectFit
    }
}

extension ChatViewController {
    private func chatBotAnswer(scenario: Int) {
        switch scenario {
        case 1:
            timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { (timer) in
                self.chatModel.append(ChatModel(isOutgoing: false, messageText: "Привет! Минутку.."))
                self.tableView.reloadData()
            })
            
            timer = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false, block: { (timer) in
                self.chatModel.append(ChatModel(isOutgoing: false, messageText: "", messageImage: #imageLiteral(resourceName: "testQR")))
                self.tableView.reloadData()
            })
        case 2:
            timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { (timer) in
                self.chatModel.append(ChatModel(isOutgoing: false, messageText: "Пожалуйста))"))
                self.tableView.reloadData()
            })
        default:
            print("Не найден сценарий")
        }
    }
}
