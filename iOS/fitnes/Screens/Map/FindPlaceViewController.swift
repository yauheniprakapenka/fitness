//
//  MapViewController.swift
//  
//
//  Created by yauheni prakapenka on 09.08.2020.
//

import UIKit
import MapKit
import CoreLocation

class FindPlaceViewController: UIViewController {
    
    // MARK: - Private porperties
    
    private var mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let backButton = FButtonWithBackgroundColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Назад", size: 13)
    private let trainerNameLabel = FLabel(fontSize: 12, weight: .medium, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), message: "Не указано")
    private let emailLabel = FLabel(fontSize: 12, weight: .regular, color: .gray, message: "Не указано")
    private let phoneLabel = FLabel(fontSize: 12, weight: .regular, color: .lightGray, message: "Не указано")
    private let avatarImageView = UIImageView()
    private let bottomContainerView = UIView()
    private let placeView = FViewContentPlace()
    
    // MARK: - Public porperties
    
    var trainer: TrainerModel?
    var place: PlaceModel?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigation()
        configureMapView()
  
        configureTrainerView()
        configureTrainingPlaceView()
        
        configureAvatarImageView()
        configureNameLabel()
        configureEmailLabel()
        configurePhoneLabel()
    }
}

// MARK: - Actions

private extension FindPlaceViewController {
    
    @objc
    private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - Private Methods

private extension FindPlaceViewController {
    
    func configureNavigation() {
        navigationItem.title = "Место тренировки"
        
        let cancelButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.5999526381, green: 0.6000268459, blue: 0.5999273658, alpha: 1)
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15)!], for: .normal)
    }

    func configureMapView() {
        mapView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(mapView)
        
        let coordinate = CLLocationCoordinate2DMake(place?.latitude ?? 0, place?.longitude ?? 0)
        mapView.setCenter(coordinate, animated: true)
        
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: mySpan)
        mapView.region = myRegion
        
        let userPin = MKPointAnnotation()
        userPin.coordinate = coordinate
        userPin.title = "Занятия"
        userPin.subtitle = "будут здесь"
        
        mapView.addAnnotation(userPin)
        mapView.selectAnnotation(mapView.annotations[0], animated: true)
    }
    
    func configureTrainingPlaceView() {
        view.addSubview(placeView)
        placeView.translatesAutoresizingMaskIntoConstraints = false
        placeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        placeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        placeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        placeView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        placeView.placeImageView.image = place?.photo
        placeView.addressLabel.text = place?.address
        placeView.seeOnMapLabel.alpha = 0
    }
    
    func configureTrainerView() {
        view.addSubview(bottomContainerView)
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        bottomContainerView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        
        bottomContainerView.backgroundColor = .white
        bottomContainerView.layer.cornerRadius = 15
        
        bottomContainerView.layer.shadowColor = UIColor.black.cgColor
        bottomContainerView.layer.shadowOpacity = 0.4
        bottomContainerView.layer.shadowOffset = CGSize.zero
        bottomContainerView.layer.shadowRadius = 9
    }
    
    func configureAvatarImageView() {
        bottomContainerView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 15
        avatarImageView.contentMode = .scaleAspectFill
        
        avatarImageView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 8).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 8).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -8).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        avatarImageView.image = trainer?.avatarImage
    }

    func configureNameLabel() {
        bottomContainerView.addSubview(trainerNameLabel)
        trainerNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 6).isActive = true
        trainerNameLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 4).isActive = true
        trainerNameLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -4).isActive = true
        trainerNameLabel.numberOfLines = 2
        trainerNameLabel.text = trainer?.trainerName
        trainerNameLabel.textAlignment = .center
    }
    
    func configureEmailLabel() {
        bottomContainerView.addSubview(emailLabel)
        emailLabel.topAnchor.constraint(equalTo: trainerNameLabel.bottomAnchor, constant: 6).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 8).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -4).isActive = true
        emailLabel.numberOfLines = 1
        emailLabel.text = trainer?.cost
        emailLabel.textAlignment = .center
        emailLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    }
    
    func configurePhoneLabel() {
        bottomContainerView.addSubview(phoneLabel)
        phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 6).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 8).isActive = true
        phoneLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -8).isActive = true
        phoneLabel.numberOfLines = 3
        phoneLabel.text = trainer?.trainingPlace
        phoneLabel.textAlignment = .center
        phoneLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    }
}
