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
}
