//
//  SetTrainingMapViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 18.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import MapKit

protocol SetPlaceVСDelegate {
    func addPlace(place: PlaceModel)
}

class SetPlaceViewController: UIViewController {
    
    // MARK: - Properties
    
    private let bottomContainerView = UIView()
    private let descriptionLabel = FLabel(fontSize: 13, weight: .light, color: .black, message: "Отметьте место на карте. В поле ниже отредактируйте адрес, который увидит атлет.")
    private var addressTextField = FTextField(placeholderText: "г. Гомель, ул. Кирова, 32а", placeholderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    private let userPin = MKPointAnnotation()
    
    private var currentLatitude: Double?
    private var currentLongitude: Double?
    private var currentPhoto: UIImage?
    private var currentAddress: String?
    private var currentFileName: String?
    
    private let containerView = UIView()
    private let deleteButton = UIButton()
    private let addPhotoButton = UIButton()
    private let paperclipImageView = UIImageView()
    
    var placeModel: PlaceModel?
    
    var delegate: SetPlaceVСDelegate?
    
    private lazy var mkMapView: MKMapView = {
        let mapView = MKMapView(frame: view.frame)
        mapView.delegate = self
        
        let myLongPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer()
        myLongPress.addTarget(self, action: #selector(recognizeLongPress(_:)))
        mapView.addGestureRecognizer(myLongPress)
        
        return mapView
    }()
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(mkMapView)
        
        configureNavigation()
        
        configureBottonContainerView()
        configureDescriptionLabel()
        configurePlaceTextField()
        
        configureContainerView()
        configureDeleteButton()
        
        configurePaperclipImage()
        configureAddPhotoButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        configurePlaceOnMap()
    }
    
    
    // MARK: - Private funcs
    
    private func configurePlaceOnMap() {
        if placeModel != nil {
            currentLatitude = placeModel!.latitude
            currentLongitude = placeModel!.longitude
            currentPhoto = placeModel?.photo
            currentAddress = placeModel?.address
            currentFileName = placeModel?.fileName
            
            addressTextField.text = currentAddress
            addPhotoButton.setTitle(currentFileName, for: .normal)
            
            moveMarkerToCoordinate(latitude: currentLatitude!, longitude: currentLongitude!)
            
            deleteButton.isHidden = false
            
            return
        }
        
        moveMarkerToCoordinate(latitude: 52.52433369066986, longitude: 30.99177458767204) // по умолчанию
    }
    
    private func moveMarkerToCoordinate(latitude: Double, longitude: Double) {
        let myCoordinate = CLLocationCoordinate2DMake(latitude, longitude)
        mkMapView.setCenter(myCoordinate, animated: true)
        
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: myCoordinate, span: mySpan)
        mkMapView.region = myRegion
        
        userPin.coordinate = myCoordinate
        userPin.title = "Занятия"
        userPin.subtitle = "будут здесь"
        
        mkMapView.addAnnotation(userPin)
        mkMapView.selectAnnotation(mkMapView.annotations[0], animated: true) // для отображения title и subtitle
    }
    
    private func configureNavigation() {
        navigationItem.title = "Место тренировки"
        
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.5999526381, green: 0.6000268459, blue: 0.5999273658, alpha: 1)
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15)!], for: .normal)
        
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15)!], for: .normal)
    }
    
    private func configureBottonContainerView() {
        view.addSubview(bottomContainerView)
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.backgroundColor = .white
        bottomContainerView.layer.cornerRadius = 10
        bottomContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomContainerView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        bottomContainerView.layer.shadowOpacity = 0.1
        bottomContainerView.layer.shadowRadius = 2
        bottomContainerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        bottomContainerView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 4).isActive = true
    }
    
    private func configureDescriptionLabel() {
        bottomContainerView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2
        
        descriptionLabel.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 20).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 40).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -40).isActive = true
    }
    
    private func configurePlaceTextField() {
        bottomContainerView.addSubview(addressTextField)
        addressTextField.delegate = self
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        addressTextField.returnKeyType = .done
        
        addressTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        addressTextField.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 20).isActive = true
        addressTextField.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -20).isActive = true
        addressTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        
        containerView.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 16).isActive = true
        containerView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -20).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func configureDeleteButton() {
        containerView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.isHidden = true
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .medium)
        let iconImage = UIImage(systemName: "trash", withConfiguration: config)?.withTintColor(#colorLiteral(red: 0.5999526381, green: 0.6000268459, blue: 0.5999273658, alpha: 1), renderingMode: .alwaysOriginal)
        
        deleteButton.setImage(iconImage, for: .normal)
        
        deleteButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
    }
    
    private func configurePaperclipImage() {
        containerView.addSubview(paperclipImageView)
        paperclipImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .medium)
        let iconImage = UIImage(systemName: "paperclip", withConfiguration: config)?.withTintColor(#colorLiteral(red: 0.3025592268, green: 0.6826873422, blue: 0.9980949759, alpha: 1), renderingMode: .alwaysOriginal)
        
        paperclipImageView.image = iconImage
        
        paperclipImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        paperclipImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        paperclipImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        paperclipImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    private func configureAddPhotoButton() {
        containerView.addSubview(addPhotoButton)
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        addPhotoButton.contentHorizontalAlignment = .left
        addPhotoButton.setTitle("Прикрепить файл", for: .normal)
        addPhotoButton.setTitleColor(#colorLiteral(red: 0.3025592268, green: 0.6826873422, blue: 0.9980949759, alpha: 1), for: .normal)
        addPhotoButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        addPhotoButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        addPhotoButton.leadingAnchor.constraint(equalTo: paperclipImageView.trailingAnchor, constant: 6).isActive = true
        addPhotoButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -20).isActive = true
        addPhotoButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - @objc funcs
    
    @objc
    private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func saveButtonTapped() {
        guard let currnetLatitude = currentLatitude else { return }
        guard let currentLongitude = currentLongitude else { return }
        
        if currentPhoto == nil {
            currentPhoto = #imageLiteral(resourceName: "city-black-and-white")
        }
        
        if currentAddress == nil {
            currentAddress = "Адрес не указан"
        }
        
        if addPhotoButton.titleLabel?.text == nil {
            currentAddress = "Прикрепить файл"
        }
        
        placeModel = PlaceModel(
            address: currentAddress!,
            photo: currentPhoto!,
            fileName: (addPhotoButton.titleLabel?.text)!,
            latitude: currnetLatitude,
            longitude: currentLongitude)
        
        delegate?.addPlace(place: placeModel!)
    }
    
    @objc
    private func recognizeLongPress(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state != UIGestureRecognizer.State.began {
            return
        }
        
        mkMapView.removeAnnotation(userPin)
        
        let location = sender.location(in: mkMapView)
        let myCoordinate: CLLocationCoordinate2D = mkMapView.convert(location, toCoordinateFrom: mkMapView)
        
        userPin.coordinate = myCoordinate
        userPin.title = "Занятия"
        userPin.subtitle = "будут здесь"
        
        mkMapView.addAnnotation(userPin)
        mkMapView.selectAnnotation(mkMapView.annotations[0], animated: true) // для отображения title и subtitle
    }
    
    @objc
    private func addPhotoButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
    }
}


// MARK: - MK Map View Delegate

extension SetPlaceViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let myPinIdentifier = "PinAnnotationIdentifier"
        
        let myPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: myPinIdentifier)
        myPinView.animatesDrop = true
        myPinView.canShowCallout = true
        myPinView.annotation = annotation
        
        print("latitude: \(annotation.coordinate.latitude), longitude: \(annotation.coordinate.longitude)")
        
        currentLatitude = Double(annotation.coordinate.latitude)
        currentLongitude = Double(annotation.coordinate.longitude)
        
        GeolocationConverter.shared.getAddress(latitude: currentLatitude ?? 0, longitude: currentLongitude ?? 0) { (address) in
            self.addressTextField.text = address
            self.currentAddress = address
        }
        
        return myPinView
    }
}


extension SetPlaceViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addressTextField.resignFirstResponder()
        currentAddress = addressTextField.text
        return true
    }
}


// MARK: - Keyboard Notification

extension SetPlaceViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}


// MARK: - UIImagePickerControllerDelegate

extension SetPlaceViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        //        print(fileUrl.lastPathComponent)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            dismiss(animated: true)
            return
        }
        
        currentFileName = fileUrl.lastPathComponent
        addPhotoButton.setTitle(currentFileName, for: .normal)
        currentPhoto = image
        
        dismiss(animated: true)
    }
}
