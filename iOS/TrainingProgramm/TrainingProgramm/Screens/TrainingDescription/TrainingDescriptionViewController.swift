//
//  TrainingDescriptionViewController.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/16/20.
//

import UIKit

private let exercises = [
    TPExercise(name: "Трастер", inventory: "Трастер", description: "Описание упражнения", video: .remote(url: URL(string: "https://www.youtube.com/watch?v=NyWchPA9CH0")!),
               id: 1),
    TPExercise(name: "Двойные прыжки на скакалке", inventory: "Скакалка", description: "Описание упражнения", video: .remote(url: URL(string: "https://www.youtube.com/watch?v=NyWchPA9CH0")!),
               id: 2),
    
]

public class TrainingDescriptionViewController: UIViewController {
    
    private weak var trainingView: TrainingDescriptionView!
    
    let exampleTraining = TPTraining(
        id: nil,
        name: "Супер эффективная тренировка",
        descriptionText: "Стартуем со взятий на грудь, обширная техническая подготовка, будут тяги и связки и еще всякие подводящие фишки. А потом вообще прилетит Шварцнеггер",
        time: Date(),
        sections: [
            TPTrainingSection.amrap(minutes: 10, items: [
                TPTrainingSectionItem(koeff: 1, exerciseId: 1, profileValue: "Жим стоя", defaultForMan: 10, defaultForWoman: 10, repeats: 10, distanceMeters: 10),
                TPTrainingSectionItem(koeff: 1, exerciseId: 2, profileValue: "Жим лежа", defaultForMan: 10, defaultForWoman: 10, repeats: 10, distanceMeters: 10),
            ], name: "Разминка"),
            TPTrainingSection.rest(minutes: 10, name: "Отдохнуть")
        ])
    
    // MARK: - Lifecycle
    public override func loadView() {
        super.loadView()
        
        let trainingView = TrainingDescriptionView()
        trainingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trainingView)
        self.trainingView = trainingView
        trainingView.constraintAllSidesToSuperview()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        trainingView.exercises = exercises
        trainingView.configure(with: exampleTraining)
    }
}
