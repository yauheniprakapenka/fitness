//
//  AddTrainingViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 26.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class AddTrainingViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var typeSectionButton: UIButton!
    @IBOutlet var configTrainingLabel: UILabel!
    
    @IBAction func typeSectionButtonTapped(_ sender: Any) {
        showTypeSectionAlert(amrap: { (TypeSection) in
            self.configTrainig(typeSection: TypeSection)
        }, emom: { (TypeSection) in
            self.configTrainig(typeSection: TypeSection)
        }, forTime: { (TypeSection) in
            self.configTrainig(typeSection: TypeSection)
        }) { (TypeSection) in
            self.configTrainig(typeSection: TypeSection)
        }
    }
    
    private func configTrainig(typeSection: TypeSectionEnum) {
        switch typeSection {
        case .amrap:
            configTrainingLabel.text = "Поминутный выбор упражениня"
        case .emom:
            configTrainingLabel.text = "Набор упражнений. Для каждого упражнения - количество повторов и вес"
        case .forTime:
            configTrainingLabel.text = "Набор упражнений. Для каждого упражнения - количество повторов и вес"
        case .rest:
            configTrainingLabel.text = "Отдых"
        }
    }
}
