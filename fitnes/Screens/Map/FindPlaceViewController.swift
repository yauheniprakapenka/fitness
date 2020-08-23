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
    
    var mapView = MKMapView()
    let backButton = FButtonWithBackgroundColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Назад", size: 13)
    let trainingPlaceView = FViewContentPlace()
    let locationManager = CLLocationManager()
    var selectedTrainer: TrainerModel?
    let trainerContainerView = UIView()
    let avatarImageView = UIImageView()
    let trainerNameLabel = FLabel(fontSize: 12, weight: .medium, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), message: "Не указано")
    let costLabel = FLabel(fontSize: 12, weight: .regular, color: .gray, message: "Не указано")
    let trainingPlaceLabel = FLabel(fontSize: 12, weight: .regular, color: .lightGray, message: "Не указано")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureMapView()
        configureBackButton()
        
        configureTrainerView()
        configureTrainingPlaceView()
        
        configureAvatarImageView()
        configureTrainerName()
        configureCostLabel()
        configureTrainingLabel()
    }
    
    private func configureBackButton() {
        view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func configureMapView() {
        let latitude = 52.431296
        let longitude = 31.005284
        
        mapView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(mapView)
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        pin.title = "Занятие проводится здесь"
        //        pin.subtitle = "The tallest buildiing in the world."
        mapView.addAnnotation(pin)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    private func configureTrainingPlaceView() {
        view.addSubview(trainingPlaceView)
        trainingPlaceView.translatesAutoresizingMaskIntoConstraints = false
        trainingPlaceView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trainingPlaceView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trainingPlaceView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trainingPlaceView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        trainingPlaceView.placeImageView.image = selectedTrainer?.schoolImage
        trainingPlaceView.addressLabel.text = selectedTrainer?.trainingPlace
    }
    
    private func configureTrainerView() {
        view.addSubview(trainerContainerView)
        trainerContainerView.translatesAutoresizingMaskIntoConstraints = false
        trainerContainerView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        trainerContainerView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        trainerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        trainerContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        
        trainerContainerView.backgroundColor = .white
        trainerContainerView.layer.cornerRadius = 15
        
        trainerContainerView.layer.shadowColor = UIColor.black.cgColor
        trainerContainerView.layer.shadowOpacity = 0.4
        trainerContainerView.layer.shadowOffset = CGSize.zero
        trainerContainerView.layer.shadowRadius = 9
    }
    
    private func configureAvatarImageView() {
        trainerContainerView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 15
        avatarImageView.contentMode = .scaleAspectFill
        
        avatarImageView.topAnchor.constraint(equalTo: trainerContainerView.topAnchor, constant: 8).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: trainerContainerView.leadingAnchor, constant: 8).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: trainerContainerView.trailingAnchor, constant: -8).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        avatarImageView.image = selectedTrainer?.avatarImage
    }

    private func configureTrainerName() {
        trainerContainerView.addSubview(trainerNameLabel)
        trainerNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 6).isActive = true
        trainerNameLabel.leadingAnchor.constraint(equalTo: trainerContainerView.leadingAnchor, constant: 4).isActive = true
        trainerNameLabel.trailingAnchor.constraint(equalTo: trainerContainerView.trailingAnchor, constant: -4).isActive = true
        trainerNameLabel.numberOfLines = 2
        trainerNameLabel.text = selectedTrainer?.trainerName
        trainerNameLabel.textAlignment = .center
    }
    
    private func configureCostLabel() {
        trainerContainerView.addSubview(costLabel)
        costLabel.topAnchor.constraint(equalTo: trainerNameLabel.bottomAnchor, constant: 6).isActive = true
        costLabel.leadingAnchor.constraint(equalTo: trainerContainerView.leadingAnchor, constant: 8).isActive = true
        costLabel.trailingAnchor.constraint(equalTo: trainerContainerView.trailingAnchor, constant: -4).isActive = true
        costLabel.numberOfLines = 1
        costLabel.text = selectedTrainer?.cost
        costLabel.textAlignment = .left
    }
    
    private func configureTrainingLabel() {
        trainerContainerView.addSubview(trainingPlaceLabel)
        trainingPlaceLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 6).isActive = true
        trainingPlaceLabel.leadingAnchor.constraint(equalTo: trainerContainerView.leadingAnchor, constant: 8).isActive = true
        trainingPlaceLabel.trailingAnchor.constraint(equalTo: trainerContainerView.trailingAnchor, constant: -8).isActive = true
        trainingPlaceLabel.numberOfLines = 3
        trainingPlaceLabel.text = selectedTrainer?.trainingPlace
        trainingPlaceLabel.textAlignment = .left
    }
}
