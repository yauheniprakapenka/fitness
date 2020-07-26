//
//  ScheduleViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 25.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct TrainingModel {
    var day: String
    var training: [String]
}

class TrainingViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var trainings: [TrainingModel] = [
        TrainingModel(day: "Понедельник", training: ["08:30 Земфира Приседания", "14:30 Лусине Геворкян Силовая тренировка", "14:30 Марта Силовая тренировка"]),
        TrainingModel(day: "Вторник", training: ["13:30 Мария Приседания"]),
        TrainingModel(day: "Среда", training: ["08:30 Екатерина Приседания", "11:30 Анастасия Силовая тренировка"]),
        TrainingModel(day: "Четверг", training: ["08:30 Екатерина Приседания", "14:30 Лиза Силовая тренировка"]),
        TrainingModel(day: "Пятница", training: ["16:30 Линда Приседания"]),
        TrainingModel(day: "Суббота", training: ["11:30 Вика Приседания", "14:30 Лида Силовая тренировка"]),
        TrainingModel(day: "Воскресенье", training: ["14:30 Екатерина Приседания"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let interaction = UIContextMenuInteraction(delegate: self)
        tableView.addInteraction(interaction)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "addTraining") as! AddTrainingViewController
        present(vc, animated: true)
    }
    
}


// MARK: - UI Table View Data Source
extension TrainingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        trainings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trainings[section].training.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
        cell.textLabel?.text = trainings[indexPath.section].training[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = #colorLiteral(red: 0.8719801903, green: 0.8719801903, blue: 0.8719801903, alpha: 1)
        
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        label.text = trainings[section].day
        label.textColor = .black
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let add = UIAction(title: "Редактировать", image: UIImage(systemName: "square.and.pencil")) { action in
            self.showEditScheduleAlert(selectedText: self.trainings[indexPath.section].training[indexPath.row]) { (editedText) in
                self.trainings[indexPath.section].training[indexPath.row] = editedText
                self.tableView.reloadData()
            }
        }
        
        let delete = UIAction(title: "Удалить", image: UIImage(systemName: "trash.fill"), attributes: [.destructive]) { action in
            self.trainings[indexPath.section].training.remove(at: indexPath.row)
            
            print("Секция: \(indexPath.section), ряд: \(indexPath.row)")
            tableView.reloadData()
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            UIMenu(title: "Выберите действие", children: [add, delete])
        }
    }
}


// MARK: - UI Context Menu Interaction Delegate
extension TrainingViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return nil
    }
}
