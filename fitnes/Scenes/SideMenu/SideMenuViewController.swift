//
//  SideMenuViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 26.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct SideMenuModel {
    var menu: String
}

class SideMenuViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    let sideMenu: [SideMenuModel] = [
        SideMenuModel(menu: "ФИО"),
        SideMenuModel(menu: "QR")
    ]
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileID") as! ProfileViewController
        present(vc, animated: true)
    }
    
}


// MARK: - UI Table View Data Source
extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sideMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCellID", for: indexPath)
        cell.textLabel?.text = sideMenu[indexPath.row].menu
        return cell
    }
}
