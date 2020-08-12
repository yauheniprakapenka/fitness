//
//  TrainingCell.swift
//  fitnes
//
//  Created by yauheni prakapenka on 11.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

protocol VideoUrlDelegate {
    func sendVideoUrl()
}

class TrainingCell: UITableViewCell {

    var delegate: VideoUrlDelegate?
    
    let shapeView = UIView()
    
    let minuteLabel = FLabel(fontSize: 14, weight: .semibold, color: .black, message: nil)
    let exerciseNameLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: nil)
    let numberOfReapeatsLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: nil)
    let weightLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: nil)
    let distanceLabel = FLabel(fontSize: 14, weight: .regular, color: .black, message: nil)
    let videoButton = FButtonSimple(title: "Посмотреть упражнение", titleColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), size: 14)
    
    var isFirstUnfinished = true
    
    var data: ExerciseModelNew? {
        didSet {
            guard let data = data else { return }
            minuteLabel.text = "Минута " + String(data.minute)
            exerciseNameLabel.text = data.exerciseName
            
            if let number = data.numberOfRepeats {
                numberOfReapeatsLabel.text = "\(number) повторов"
            }
            
            if let weight = data.weight {
                weightLabel.text = "Вес \(weight)"
            }
            
            if let distance = data.distance {
                distanceLabel.text = "Дистанция \(distance)"
            }
            
            if let distance = data.distance {
                distanceLabel.text = distance
            }
            
            if data.videoURL == nil {
                videoButton.isHidden = true
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureShapeView()
        
        configureMinuteLabel()
        configureExerciseNameLabel()
        configureNumberOfReapeatsLabel()
        configureWeightLabel()
        configureDistanceLabel()
        
        configureButton()
        
    }

    private func configureShapeView() {
        addSubview(shapeView)
        shapeView.translatesAutoresizingMaskIntoConstraints = false
        shapeView.backgroundColor = .black
        shapeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        shapeView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        shapeView.widthAnchor.constraint(equalToConstant: 6).isActive = true
        shapeView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        shapeView.clipsToBounds = true
        shapeView.layer.cornerRadius = 3
    }
    
    private func configureMinuteLabel() {
        addSubview(minuteLabel)
        minuteLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        minuteLabel.leadingAnchor.constraint(equalTo: shapeView.trailingAnchor, constant: 8).isActive = true
        minuteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        minuteLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func configureExerciseNameLabel() {
        addSubview(exerciseNameLabel)
        exerciseNameLabel.topAnchor.constraint(equalTo: minuteLabel.bottomAnchor, constant: 10).isActive = true
        exerciseNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true
        exerciseNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        exerciseNameLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func configureNumberOfReapeatsLabel() {
        addSubview(numberOfReapeatsLabel)
        
        numberOfReapeatsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true
        numberOfReapeatsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        guard let _ = numberOfReapeatsLabel.text else {
            numberOfReapeatsLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 0).isActive = true
            return
        }
        
        numberOfReapeatsLabel.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    private func configureWeightLabel() {
        addSubview(weightLabel)
        weightLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true
        weightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        guard let _ = weightLabel.text else {
            weightLabel.topAnchor.constraint(equalTo: numberOfReapeatsLabel.bottomAnchor, constant: 0).isActive = true
            return
        }
        
        weightLabel.topAnchor.constraint(equalTo: numberOfReapeatsLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    private func configureDistanceLabel() {
        addSubview(distanceLabel)
        
        distanceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        guard let _ = distanceLabel.text else {
            distanceLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 0).isActive = true
            return
        }
        
        distanceLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    private func configureButton() {
        addSubview(videoButton)
        videoButton.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 10).isActive = true
        videoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60).isActive = true
        videoButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        videoButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    func buttonTapped() {
        let vc = WKWebViewController()
        
        print("1")
        print(data?.videoURL)
        
        guard let url = data?.videoURL else {
            return
        }
        
        print("2 \(url)")
        vc.urlString = url
        
        delegate?.sendVideoUrl()
        
//        present(vc, animated: true)
        
//        addSubview(WKWebViewController())
//        self.window?.rootViewController!.present(WKWebViewController(), animated: true, completion: nil)
    }
 
}
