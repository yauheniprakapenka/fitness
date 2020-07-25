//
//  ScheduleViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 25.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct Calendar {
    var day: String
    var shedule: [String]
}

class ScheduleViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var calendar: [Calendar] = [
        Calendar(day: "Понедельник", shedule: ["08:30 Земфира Приседания", "14:30 Лусине Геворкян Силовая тренировка", "14:30 Марта Силовая тренировка"]),
        Calendar(day: "Вторник", shedule: ["13:30 Мария Приседания"]),
        Calendar(day: "Среда", shedule: ["08:30 Екатерина Приседания", "11:30 Анастасия Силовая тренировка"]),
        Calendar(day: "Четверг", shedule: ["08:30 Екатерина Приседания", "14:30 Лиза Силовая тренировка"]),
        Calendar(day: "Пятница", shedule: ["16:30 Линда Приседания"]),
        Calendar(day: "Суббота", shedule: ["11:30 Вика Приседания", "14:30 Лида Силовая тренировка"]),
        Calendar(day: "Воскресенье", shedule: ["14:30 Екатерина Приседания"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let interaction = UIContextMenuInteraction(delegate: self)
        tableView.addInteraction(interaction)
    }
}


// MARK: - UI Table View Data Source
extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        calendar.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calendar[section].shedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
        cell.textLabel?.text = calendar[indexPath.section].shedule[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = #colorLiteral(red: 0.8719801903, green: 0.8719801903, blue: 0.8719801903, alpha: 1)
        
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        label.text = calendar[section].day
        label.textColor = .black
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let add = UIAction(title: "Редактировать", image: UIImage(systemName: "square.and.pencil")) { action in
            self.showEditScheduleAlert(selectedText: self.calendar[indexPath.section].shedule[indexPath.row]) { (editedText) in
                self.calendar[indexPath.section].shedule[indexPath.row] = editedText
                self.tableView.reloadData()
            }
        }
        
        let delete = UIAction(title: "Удалить", image: UIImage(systemName: "trash.fill"), attributes: [.destructive]) { action in
            self.calendar[indexPath.section].shedule.remove(at: indexPath.row)
            
            print("Секция: \(indexPath.section), ряд: \(indexPath.row)")
            tableView.reloadData()
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            UIMenu(title: "Выберите действие", children: [add, delete])
        }
    }
}


// MARK: - UI Context Menu Interaction Delegate
extension ScheduleViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return nil
    }
}
