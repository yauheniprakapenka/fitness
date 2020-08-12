//
//  TrainingProgrammViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 11.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class TrainingProgrammViewController: UIViewController {
    
    let trainingCell = TrainingCell()
    
    let tableView = UITableView()
    
    var training: [ExerciseModelNew] = [
        ExerciseModelNew(minute: 1, exerciseName: "Прыжки на скакалке", numberOfRepeats: "7", weight: nil, distance: nil, videoURL: "https://www.youtube.com/watch?v=qct-gB6bukE&pbjreload=101"),
        ExerciseModelNew(minute: 2, exerciseName: "Жим лежа", numberOfRepeats: "4", weight: "60 kg", distance: nil, videoURL: nil),
        ExerciseModelNew(minute: 3, exerciseName: "Отдых", numberOfRepeats: nil, weight: nil, distance: nil, videoURL: nil),
        ExerciseModelNew(minute: 4, exerciseName: "Бег", numberOfRepeats: nil, weight: nil, distance:"300 метров", videoURL: "https://www.youtube.com/watch?v=ZMBp84joHQY"),
        ExerciseModelNew(minute: 5, exerciseName: "Приседания", numberOfRepeats: "22", weight: nil, distance: nil, videoURL: "https://www.youtube.com/watch?v=qct-gB6bukE&pbjreload=101"),
        ExerciseModelNew(minute: 6, exerciseName: "Прыжки на скакалке", numberOfRepeats: "7", weight: nil, distance: nil, videoURL: "https://www.youtube.com/watch?v=qct-gB6bukE&pbjreload=101"),
        ExerciseModelNew(minute: 7, exerciseName: "Жим лежа", numberOfRepeats: "4", weight: "60 kg", distance: nil, videoURL: nil),
        ExerciseModelNew(minute: 8, exerciseName: "Отдых", numberOfRepeats: nil, weight: nil, distance: nil, videoURL: "mail.ru"),
        ExerciseModelNew(minute: 9, exerciseName: "Бег", numberOfRepeats: nil, weight: nil, distance:"300 метров", videoURL: "https://www.youtube.com/watch?v=ZMBp84joHQY"),
        ExerciseModelNew(minute: 10, exerciseName: "Прыжки на скакалке", numberOfRepeats: "7", weight: nil, distance: nil, videoURL: "https://www.youtube.com/watch?v=qct-gB6bukE&pbjreload=101")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        
        setupTableView()
        
        trainingCell.delegate = self
    }
}

// MARK: - Setup Table View
extension TrainingProgrammViewController: UITableViewDelegate {
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.register(TrainingCell.self, forCellReuseIdentifier: "cell")
    }
}

extension TrainingProgrammViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        training.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrainingCell
        
        cell.data = training[indexPath.row]
        cell.videoButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        return cell
    }
    
    @objc func buttonTapped() {
        trainingCell.buttonTapped()
    }
    
}

extension TrainingProgrammViewController: VideoUrlDelegate {
    func sendVideoUrl() {
        print("3")
        let vc = WKWebViewController()
        present(vc, animated: true)
    }
    
}
