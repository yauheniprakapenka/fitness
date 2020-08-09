//
//  ChatViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 09.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct ChatModel {
    var id: Int
    var message: String
}

class ChatViewController: UIViewController {
    
    let tableView = UITableView()
    
    var chatModel: [ChatModel] = [
        ChatModel(id: 0, message: "Добрый вечер"),
        ChatModel(id: 1, message: "Добрый вечер")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
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
        
        cell.messageLabel.text = chatModel[indexPath.row].message
        
        return cell
    }
    
}

class ChatCell: UITableViewCell {
    
    let messageLabel = FLabel(textAligment: .left, fontSize: 14, weight: .regular, color: .black, message: "")
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        configureMessageLabel()
    }
    
    private func configureMessageLabel() {
        addSubview(messageLabel)
        messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        messageLabel.numberOfLines = 0
    }
}
