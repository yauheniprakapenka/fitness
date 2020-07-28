//
//  ViewController.swift
//  delete
//
//  Created by yauheni prakapenka on 17.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var items = 2
    
    @IBAction func addButtonTapped(_ sender: Any) {
        items += 1
        tableView.reloadData()
        print("test")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        cell.button.isHidden = true
        cell.textfield.isHidden = false
        
        if indexPath.row == items - 1 {
            cell.button.isHidden = false
            cell.textfield.isHidden = true
        }
        
        return cell
    }
    
    
}
