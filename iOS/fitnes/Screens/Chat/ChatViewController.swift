//
//  ChatViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 09.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Private properties
    
    private let tableView = UITableView()
    private let chatTextField = FTextField()
    private var timer: Timer?
    private var sendMessageCount = 0
    private let backButton = FButtonSimple(title: "Назад", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 16)
    private let sendButton = FButtonWithBackgroundColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Отправить", size: 18)
    private let headerView = FViewHorisontalLine()
    private let trainerNameLabel = FLabel(fontSize: 12, weight: .regular, color: .gray, message: "")
    private let avatarImageView = UIImageView()
    private let messageImageView = UIImageView()
    private var chatModel: [ChatModel] = [
        ChatModel(isOutgoing: true, messageText: "Это была отличная тренировка, ваша музыка вообще задавала ритм"),
        ChatModel(isOutgoing: false, messageText: "Музыка - это замечательный источник энергии и вдохновения")
    ]

    // MARK: - Public properties
    
    var selectedTrainer: TrainerModel?
    
    // MARK: - View life cycle
    
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
        DismissKeyboardWhenTap.shared.dismissKeyboard(view: view)
    }
}

// MARK: - UI Table View Data Source

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

// MARK: - Private methods

private extension ChatViewController {
    
    func chatBotAnswer(scenario: Int) {
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
    
    func configureHeaderView() {
        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        headerView.backgroundColor = #colorLiteral(red: 0.959921658, green: 0.9648196101, blue: 0.9689807296, alpha: 1)
    }
    
    func configureTrainerNameLabel() {
        headerView.addSubview(trainerNameLabel)
        trainerNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10).isActive = true
        trainerNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trainerNameLabel.text = selectedTrainer?.trainerName
    }
    
    func configureBackButton() {
        headerView.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 45).isActive = true
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func configureAvatarImageView() {
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
    
    func configureSendButton() {
        view.addSubview(sendButton)
        sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    func configureChatTextField() {
        view.addSubview(chatTextField)
        chatTextField.bottomAnchor.constraint(equalTo: sendButton.topAnchor).isActive = true
        chatTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chatTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chatTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        chatTextField.delegate = self
        chatTextField.placeholder = "Сообщение"
        chatTextField.text = "Добрый вечер!\n\nСбросьте, пожалуйста, qr код с программой тренировки"
    }
    
    func configureTableView() {
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

// MARK: - Private actions

private extension ChatViewController {
    
    @objc
    func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    func sendButtonTapped() {
        let senderMessage = chatTextField.text ?? ""
        chatModel.append(ChatModel(isOutgoing: true, messageText: senderMessage, messageImage: nil))
        tableView.reloadData()
        chatTextField.text = ""
        
        sendMessageCount += 1
        chatBotAnswer(scenario: sendMessageCount)
    }
}

// MARK: - UI TextField Delegate
extension ChatViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
