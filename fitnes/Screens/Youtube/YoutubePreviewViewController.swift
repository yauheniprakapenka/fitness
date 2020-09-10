//
//  YoutubePreviewViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 10.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class YoutubePreviewViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let previewImageView = UIImageView()
    
    // MARK: - Public properties
    
    let youtubeUrl = "https://www.youtube.com/watch?v=LptTKfrHSi4&ab_channel=CryoChamber"

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePreviewImageView()
        
        FetchYoutubePreviewImage.shared.fetchImage(youtubeUrl: youtubeUrl) { (image) in
            DispatchQueue.main.async {
                self.previewImageView.image = image
            }
        }
    }
}

// MARK: - Private methods

private extension YoutubePreviewViewController {
    
    func configurePreviewImageView() {
        view.addSubview(previewImageView)
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        previewImageView.backgroundColor = .purple
        
        NSLayoutConstraint.activate([
            previewImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            previewImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            previewImageView.widthAnchor.constraint(equalToConstant: 300),
            previewImageView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(wkWebButtonTapped))
        previewImageView.isUserInteractionEnabled = true
        previewImageView.addGestureRecognizer(tap)
    }
}

// MARK: - Actions

private extension YoutubePreviewViewController {

    @objc
    func wkWebButtonTapped() {
        let vc = WKWebViewController()
        vc.urlString = youtubeUrl
        present(vc, animated: true)
    }
}
