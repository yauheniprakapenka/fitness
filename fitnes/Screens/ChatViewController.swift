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
    
    var chatModel: [ChatModel] = [
        ChatModel(isOutgoing: true, message: "Добрый вечер Юля! Мы с вами уже сегодня общались. Могу я получить программу тренировки qr коду?"),
        ChatModel(isOutgoing: false, message: "Юлия: Добрый вечер!"),
        ChatModel(isOutgoing: false, message: "Юлия: Вот программа. Сканируйте код и отмечайте выполненные задания")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureNavigation()
        configureChatTextField()
        configureTableView()
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Чат с тренером"
        
        let cancelButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc private func cancelButtonTapped() {
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
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        configureMessageLabel()
    }
    
    private func configureMessageLabel() {
        addSubview(messageLabel)
        
        messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        if isOutgoing {
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            messageLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100).isActive = true
            messageLabel.textColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        }
        
        messageLabel.numberOfLines = 0
    }
}
