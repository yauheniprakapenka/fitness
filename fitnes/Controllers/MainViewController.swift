//
//  ViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 13.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MainViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var inventory: [InventoryModel] = [
        InventoryModel(logoImageView: #imageLiteral(resourceName: "skippingrope"), titleLabel: "Гантели", descriptionLabel: "Описание 1"),
        InventoryModel(logoImageView: #imageLiteral(resourceName: "skippingrope"), titleLabel: "Штанга", descriptionLabel: "Описание 2"),
        InventoryModel(logoImageView: #imageLiteral(resourceName: "skippingrope"), titleLabel: "Скакалка", descriptionLabel: "Описание 3")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
    }

    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard let newInventoryVC = segue.source as? AddInventoryViewController else {
            return
        }
        
        newInventoryVC.saveNewInventory()
        inventory.append(newInventoryVC.newPlace!)
        tableView.reloadData()
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        inventory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.logoImageView?.image = inventory[indexPath.row].logoImageView
        cell.imageView?.layer.cornerRadius = cell.logoImageView.frame.size.height / 2
        cell.imageView?.clipsToBounds = true
        cell.titleLabel?.text = inventory[indexPath.row].titleLabel
        cell.descriptionLabel?.text = inventory[indexPath.row].descriptionLabel
        return cell
    }
    
}

extension MainViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
