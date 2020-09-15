//
//  AthleteParameterViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 07.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

// MARK: - Constants

private extension ProfileViewController {
    enum Const {
        static let avatarTopAnchor: CGFloat = 120
        static let tableViewTopAnchor: CGFloat = 40
        static let leftRightMargin: CGFloat = 20
        
        static let screenSizeHeight: CGFloat = UIScreen.main.bounds.height
        static let imageSize: CGFloat = Const.screenSizeHeight / 6
        
        static let cameraSize: CGFloat = 56
        static let cameraAnchor: CGFloat = 0
        
        static let trashButtonSize: CGFloat = 60
        static let trashButtonTitle = "Удалить профиль?"
        static let trashButtonDescription = "Будут удалены все ваши данные без возможности их восстановления"
        static let trashButtonAction = "Удалить"
        static let trashButtonCancel = "Отменить"
        
        static let logoutButtonTitle = "Выйти из профиля?"
        static let logoutButtonDescription = "Для входа в профиль заново необходимо будет ввети почту и пароль"
        static let logoutButtonAction = "Выйти"
        static let logoutButtonCancel = "Отменить"
        
        static let grayColor = #colorLiteral(red: 0.8721661568, green: 0.8723127246, blue: 0.8721467853, alpha: 1)
    }
}

class ProfileViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let avatarContainerView = UIView()
    private let avatarImageView = UIImageView()
    private var safeArea: UILayoutGuide!
    private var didSelectAthleteRow: AthelteProfileModel!
    private let activityIndicator = FActivityIndicator()
    
    private let cameraImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        let cameraImage = UIImage(systemName: SfSymbolEnum.camera.rawValue)?.withTintColor(#colorLiteral(red: 0.3195307553, green: 0.8156289458, blue: 0.7399761081, alpha: 1), renderingMode: .alwaysOriginal)
        imageView.image = cameraImage
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = Const.cameraSize / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Public properties
    
    let tableView = UITableView()
    var alertVC: AlertWithImageViewController!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateProfileModel()
        configureView()
        configureNavigationBar()
        configureBackNavigationButton()
        configureAvatarContainerView()
        configureTrashButton()
        configureTableView()
        configureLogoutButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateProfileModel()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Private actions

private extension ProfileViewController {
    
    @objc
    func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    func avatarTapped() {
        let alert = UIAlertController(title: "Добавить фото",
                                      message: "Выберите изображение для вашего профиля",
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Камера",
                                      style: .default,
                                      handler: { _ in
                                        self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Галерея",
                                      style: .default,
                                      handler: { _ in
                                        self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Отменить", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    func trashButtonTapped() {
        HapticFeedback.shared.make(type: .error)
        let vc = AlertViewController(question: Const.trashButtonTitle,
                                     description: Const.trashButtonDescription,
                                     actionButtonTitle: Const.trashButtonAction,
                                     cancelButtonTitle: Const.trashButtonCancel,
                                     icon: .trashCircle)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.actionButton.addTarget(self, action: #selector(deleteAlertTapped), for: .touchUpInside)
        present(vc, animated: true)
    }
    
    @objc
    func logoutButtonTapped() {
        HapticFeedback.shared.make(type: .error)
        let vc = AlertViewController(question: Const.logoutButtonTitle,
                                     description: Const.logoutButtonDescription,
                                     actionButtonTitle: Const.logoutButtonAction,
                                     cancelButtonTitle: Const.logoutButtonCancel,
                                     icon: .paperplane)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.actionButton.addTarget(self, action: #selector(logoutAlertTapped), for: .touchUpInside)
        present(vc, animated: true)
    }
    
    @objc
    func deleteAlertTapped() {
        NetworkManager.shared.deleteUser {
            DispatchQueue.main.async {
                self.dismiss(animated: true)
                
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            }
        }
    }
    
    @objc
    func logoutAlertTapped() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
            
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
}

// MARK: - Private methods

private extension ProfileViewController {
    
    func configureActivityIndicator() {
        alertVC.view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    func configureTrashButton() {
        let containerView = UIView()
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor)
        ])
        
        let trashButton = FButtonWithSFSymbol(sfSymbol: .personCrop, color: Const.grayColor, size: 44)
        containerView.addSubview(trashButton)
        
        NSLayoutConstraint.activate([
            trashButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            trashButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        
        trashButton.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
        
        let descriptionLabel = FLabel(fontSize: 14, weight: .light, color: Const.grayColor, message: "Удалить")
        containerView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: trashButton.bottomAnchor, constant: 6),
            descriptionLabel.centerXAnchor.constraint(equalTo: trashButton.centerXAnchor)
        ])
    }
    
    func configureLogoutButton() {
        let containerView = UIView()
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let logoutButton = FButtonWithSFSymbol(sfSymbol: .paperplane, color: Const.grayColor, size: 44)
        containerView.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            logoutButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        let descriptionLabel = FLabel(fontSize: 14, weight: .light, color: Const.grayColor, message: "Выйти")
        containerView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 6),
            descriptionLabel.centerXAnchor.constraint(equalTo: logoutButton.centerXAnchor)
        ])
        
    }
    
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
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ProfileAthleteCell.self, forCellReuseIdentifier: "cell")
        
        tableView.rowHeight = 60
    }
    
    func showAlert(title: String, keyboardType: KeyboardTypeEnum, completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Укажите данные"
            
            switch keyboardType {
            case .numberPad:
                textField.keyboardType = .numberPad
            case .defaultKeyboard:
                textField.keyboardType = .default
            }
        })
        
        alert.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: { action in
            
            if let data = alert.textFields?.first?.text {
                completion(data)
            }
        }))
        
        present(alert, animated: true)
    }
}

// MARK: - Avatar Image

private extension ProfileViewController {
    
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
        
        SetAvatarImage.shared.set(imageView: avatarImageView)
        
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

extension ProfileViewController: UITableViewDataSource {
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

// MARK: - UI Table View Delegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectAthleteRow = athleteProfileModel[indexPath.row]
        //        var currentAlertKeyboard: KeyboardTypeEnum?
        //
        //
        //        switch didSelectAthleteRow.typeData {
        //        case .int:
        //            currentAlertKeyboard = .numberPad
        //        case .string:
        //            currentAlertKeyboard = .defaultKeyboard
        //        case .double:
        //            currentAlertKeyboard = .numberPad
        //        }
        
        switch didSelectAthleteRow.apiName {
        case "sex":
            presentSexVC(didSelectAthleteRow: didSelectAthleteRow)
        case "email":
            return
        default:
            presentAlertWithImageVC(didSelectAthleteRow: didSelectAthleteRow)
        }
    }
}

// MARK: - UI Image Picker Controller Delegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            dismiss(animated: true)
            return
        }
        
        avatarImageView.image = image
        
        let stringAvatar = Base64Converter.shared.imageToString(img: image)
        let avatarProfileModel = AthelteProfileModel(description: "Фото",
                                                     userDataString: stringAvatar,
                                                     userDataInt: nil,
                                                     apiName: "avatar",
                                                     typeData: .string)
        
        NetworkManager.shared.putUser(bodyData: avatarProfileModel) {
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
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

// MARK: - Present Alert With Image VC

private extension ProfileViewController {
    
    func presentSexVC(didSelectAthleteRow: AthelteProfileModel) {
        if didSelectAthleteRow.apiName == "sex" {
            let vc = SexViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            return
        }
    }
    
    func presentAlertWithImageVC(didSelectAthleteRow: AthelteProfileModel) {
        configureAlertWithImage(apiName: didSelectAthleteRow.apiName ?? "")
        
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
        
        alertVC.actionButton.addTarget(self, action: #selector(alertActionButtonTapped), for: .touchUpInside)
        alertVC.cancelButton.addTarget(self, action: #selector(alertCancelButtonTapped), for: .touchUpInside)
        alertVC.userInputTextfield.becomeFirstResponder()
        
        present(alertVC, animated: true)
        return
    }
    
    @objc
    func alertActionButtonTapped() {
        configureActivityIndicator()
        
        self.activityIndicator.startAnimate()
        switch didSelectAthleteRow.typeData {
        case .int:
            didSelectAthleteRow.userDataInt = Int(alertVC.userInputTextfield.text ?? "")
        case .string:
            didSelectAthleteRow.userDataString = String(alertVC.userInputTextfield.text ?? "")
        default:
            print("Error: unknown type data")
        }
        
        NetworkManager.shared.putUser(bodyData: didSelectAthleteRow) {
            updateProfileModel()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.dismiss(animated: true)
            }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimate()
            }
        }
    }
    
    @objc
    func alertCancelButtonTapped() {
        self.dismiss(animated: true)
    }
}
