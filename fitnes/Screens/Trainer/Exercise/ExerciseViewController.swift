//
//  ExerciseViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 25.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import WebKit

class ExerciseViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var equipmentLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    
    @IBOutlet var youtubeWebView: WKWebView!
    
    var exercise: ExerciseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = exercise?.name
        descriptionLabel.text = exercise?.description
        equipmentLabel.text = exercise?.equipment
        typeLabel.text = exercise?.type
        
        fetchVideo()
    }
    
    private func fetchVideo() {

        guard let url = URL(string: exercise!.videoUrl) else {
            print("Видео не найдено")
            return
        }
 
        youtubeWebView.load(URLRequest(url: url))
    }

}
