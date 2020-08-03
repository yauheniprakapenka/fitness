//
//  ViewController.swift
//  delete
//
//  Created by yauheni prakapenka on 17.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.text = "test"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    override func loadView() {
        scrollView = UIScrollView()
        view = scrollView
        view.addSubview(label)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
}
