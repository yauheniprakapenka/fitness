//
//  AthleteParameterViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 07.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

private extension AthleteProfileViewController {
    enum Const {
        static let avatarTopAnchor: CGFloat = 120
        static let tableViewTopAnchor: CGFloat = 40
        static let leftRightMargin: CGFloat = 20
        
        static let screenSizeHeight: CGFloat = UIScreen.main.bounds.height
        static let imageSize: CGFloat = Const.screenSizeHeight / 6
        
        static let cameraSize: CGFloat = 56
        static let cameraAnchor: CGFloat = 0
    }
}

class AthleteProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private let avatarContainerView = UIView()
    private let avatarImageView = UIImageView()
    let tableView = UITableView()
    private var safeArea: UILayoutGuide!
    
    private let cameraImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        let cameraImage = UIImage(systemName: "camera.circle.fill")?.withTintColor(#colorLiteral(red: 0.3195307553, green: 0.8156289458, blue: 0.7399761081, alpha: 1), renderingMode: .alwaysOriginal)
        imageView.image = cameraImage
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = Const.cameraSize / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureNavigationBar()
        configureBackNavigationButton()
        configureAvatarContainerView()
        configureTableView()
    }
}

// MARK: - Private actions

private extension AthleteProfileViewController {
    
    @objc
    private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func avatarTapped() {
        print(#function)
        
        let alert = UIAlertController(title: "Добавить фото", message: "Выберите изображение для вашего профиля", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Private methods

private extension AthleteProfileViewController {
    
    func configureView() {
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func configureBackNavigationButton() {
        let backButton = UIBarButtonItem(title: "Обратно", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem  = backButton
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.4548649788, green: 0.4549226761, blue: 0.4548452497, alpha: 1)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Const.tableViewTopAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.leftRightMargin),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.leftRightMargin),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ProfileAthleteCell.self, forCellReuseIdentifier: "cell")
        
        tableView.rowHeight = 60
    }
}

// MARK: - Avatar Image

private extension AthleteProfileViewController {
    
    func configureAvatarContainerView() {
        view.addSubview(avatarContainerView)
        avatarContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: Const.avatarTopAnchor),
            avatarContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarContainerView.heightAnchor.constraint(equalToConstant: Const.imageSize),
            avatarContainerView.widthAnchor.constraint(equalToConstant: Const.imageSize)
        ])
        
        avatarContainerView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarContainerView.addGestureRecognizer(tap)
        
        configureAvatarImageView()
    }
    
    func configureAvatarImageView() {
        avatarContainerView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFill
        
//        avatarImageView.image = Base64Converter.shared.convertBase64StringToImage(imageBase64String: )
//        if apiGetUserModel.avatar == nil {
//            avatarImageView.image = #imageLiteral(resourceName: "fitnes-girl")
//        } else {
//
//        }
        
        if let avatar = apiGetUserModel.avatar {
            let image = Base64Converter.shared.stringToImage(imageBase64String: avatar)
            avatarImageView.image = image
        }
        
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = Const.imageSize / 2
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: avatarContainerView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: avatarContainerView.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: avatarContainerView.trailingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: avatarContainerView.bottomAnchor)
        ])
        
        configureCameraImage()
    }
    
    func configureCameraImage() {
        avatarContainerView.addSubview(cameraImageView)
        
        NSLayoutConstraint.activate([
            cameraImageView.bottomAnchor.constraint(equalTo: avatarContainerView.bottomAnchor, constant: -Const.cameraAnchor),
            cameraImageView.trailingAnchor.constraint(equalTo: avatarContainerView.trailingAnchor, constant: -Const.cameraAnchor),
            cameraImageView.widthAnchor.constraint(equalToConstant: Const.cameraSize),
            cameraImageView.heightAnchor.constraint(equalToConstant: Const.cameraSize)
        ])
    }
}

// MARK: - UITableViewDataSource

extension AthleteProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        athleteProfileModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileAthleteCell
        cell.selectionStyle = .none
        cell.data = athleteProfileModel[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AthleteProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(athleteProfileModel[indexPath.row])
    }
}

// MARK: - UI Image Picker Controller Delegate

extension AthleteProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            dismiss(animated: true)
            return
        }
        
        avatarImageView.image = image
        dismiss(animated: true)
    }
    
    func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
}
