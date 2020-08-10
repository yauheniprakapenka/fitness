//
//  TrainingProgrammViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 11.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

struct TrainingProgrammModel {
    var minute: Int
    var exerciseName: String        // Двойные прыжки на скаакалке
    var numberOfRepeats: String?     // 7 повторений
    var weight: String?              // 20 кг
    var distance: String?            // 400 метров
    var video: String?               // www.youtube.com/video-7123311
}

class TrainingProgrammViewController: UIViewController {
    let tableView = UITableView()
    
    var training: [TrainingProgrammModel] = [
        TrainingProgrammModel(minute: 1, exerciseName: "Двойные прыжки на скакалке", numberOfRepeats: "7", weight: nil, distance: "200 метров", video: "www.youtube.com/video-7123311")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTableView()
    }
}


// MARK: - Setup Table View
extension TrainingProgrammViewController: UITableViewDelegate {
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = #colorLiteral(red: 0.9803171754, green: 0.9804343581, blue: 0.9802773595, alpha: 1)
        
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
        
        return cell
    }
    
}

class TrainingCell: UITableViewCell {
    
    let minuteLabel = FLabel(fontSize: 14, weight: .semibold, color: .black, message: "minuteLabel")
    let exerciseNameLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: "ExerciseNameLabel")
    let numberOfReapeatsLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: nil)
    let weightLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: nil)
    let distanceLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: nil)
    
    let topAnchorConst: CGFloat = 20
    let leadingAnchorConst: CGFloat = 20
    let trailingAnchorConst: CGFloat = 20
    
    var data: TrainingProgrammModel? {
        didSet {
            guard let data = data else { return }
            minuteLabel.text = "Минута " + String(data.minute)
            exerciseNameLabel.text = data.exerciseName
            
            if let number = data.numberOfRepeats {
                numberOfReapeatsLabel.text = "Количество повторов \(number)"
            }
            
            if let weight = data.weight {
                weightLabel.text = "\(weight) кг"
            }
            
            if let distance = data.distance {
                distanceLabel.text = "\(distance)"
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        configureMinuteLabel()
        configureExerciseNameLabel()
        configureNumberOfReapeatsLabel()
        configureWeightLabel()
        configureDistanceLabel()
    }
    
    private func configureMinuteLabel() {
        addSubview(minuteLabel)
        minuteLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topAnchorConst).isActive = true
        minuteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchorConst).isActive = true
        minuteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingAnchorConst).isActive = true
    }
    
    private func configureExerciseNameLabel() {
        addSubview(exerciseNameLabel)
        exerciseNameLabel.topAnchor.constraint(equalTo: minuteLabel.bottomAnchor, constant: topAnchorConst).isActive = true
        exerciseNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchorConst).isActive = true
        exerciseNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingAnchorConst).isActive = true
    }
    
    private func configureNumberOfReapeatsLabel() {
        addSubview(numberOfReapeatsLabel)
        numberOfReapeatsLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: topAnchorConst).isActive = true
        numberOfReapeatsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchorConst).isActive = true
        numberOfReapeatsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingAnchorConst).isActive = true
    }
    
    private func configureWeightLabel() {
        addSubview(weightLabel)
        weightLabel.topAnchor.constraint(equalTo: numberOfReapeatsLabel.bottomAnchor, constant: topAnchorConst).isActive = true
        weightLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchorConst).isActive = true
        weightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingAnchorConst).isActive = true
    }
    
    private func configureDistanceLabel() {
        addSubview(distanceLabel)
        distanceLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: topAnchorConst).isActive = true
        distanceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchorConst).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingAnchorConst).isActive = true
    }
}

