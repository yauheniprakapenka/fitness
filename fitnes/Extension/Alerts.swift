//
//  ViewController + Extension.swift
//  fitnes
//
//  Created by yauheni prakapenka on 16.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Продолжить", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func showEditScheduleAlert(selectedText: String, editedText: @escaping (String) -> Void) {
        let ac = UIAlertController(title: "Редактирование", message: "Измените запись", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Отменить", style: .default)

        ac.addTextField { (textField) in
            textField.text = selectedText
        }
       
        let savetAction = UIAlertAction(title: "Сохранить", style: .default) { [unowned ac] _ in
            let text = (ac.textFields![0].text ?? "") as String
            editedText(text)
        }

        ac.addAction(cancelAction)
        ac.addAction(savetAction)

        present(ac, animated: true)
    }
    
    func showTypeSectionAlert(amrap: @escaping (TypeSection) -> Void, emom: @escaping (TypeSection) -> Void, forTime: @escaping (TypeSection) -> Void, rest: @escaping (TypeSection) -> Void) {
        
        let ac = UIAlertController(title: "", message: "Выберите секцию", preferredStyle:     .actionSheet)
        
        let amrap = UIAlertAction(title: "AMRAP", style: .default) { _ in
            amrap(TypeSection.amrap)
        }
        
        let emom = UIAlertAction(title: "EMOM", style: .default) { _ in
            emom(TypeSection.emom)
        }
        
        let forTime = UIAlertAction(title: "FOR TIME", style: .default) { _ in
            forTime(TypeSection.forTime)
        }
        
        let rest = UIAlertAction(title: "REST", style: .default) { _ in
            rest(TypeSection.rest)
               }
        
        let cancel = UIAlertAction(title: "Отменить", style: .cancel)
        
        ac.addAction(amrap)
        ac.addAction(emom)
        ac.addAction(forTime)
        ac.addAction(rest)
        ac.addAction(cancel)
        
        present(ac, animated: true)
    }
}

