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
    
    // MARK: - Variables
    
    var mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    let backButton = FButtonWithBackgroundColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Назад", size: 13)
    
    let trainerNameLabel = FLabel(fontSize: 12, weight: .medium, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), message: "Не указано")
    let costLabel = FLabel(fontSize: 12, weight: .regular, color: .gray, message: "Не указано")
    let placeLabel = FLabel(fontSize: 12, weight: .regular, color: .lightGray, message: "Не указано")
    
    let avatarImageView = UIImageView()
    let trainerContainerView = UIView()
    let placeView = FViewContentPlace()
    
    var trainer: TrainerModel?
    var place: PlaceModel?
    
    // MARK: - ViewController LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigation()
        configureMapView()
  
        configureTrainerView()
        configureTrainingPlaceView()
        
        configureAvatarImageView()
        configureTrainerName()
        configureCostLabel()
        configureTrainingLabel()
    }
    
    // MARK: - Private Methods
    
    private func configureNavigation() {
        navigationItem.title = "Место тренировки"
        
        let cancelButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.5999526381, green: 0.6000268459, blue: 0.5999273658, alpha: 1)
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15)!], for: .normal)
    }

    private func configureMapView() {
        
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
    
    private func configureTrainingPlaceView() {
        view.addSubview(placeView)
        placeView.translatesAutoresizingMaskIntoConstraints = false
        placeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        placeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        placeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        placeView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        placeView.placeImageView.image = trainer?.schoolImage
        placeView.addressLabel.text = trainer?.trainingPlace
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
        avatarImageView.image = trainer?.avatarImage
    }

    private func configureTrainerName() {
        trainerContainerView.addSubview(trainerNameLabel)
        trainerNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 6).isActive = true
        trainerNameLabel.leadingAnchor.constraint(equalTo: trainerContainerView.leadingAnchor, constant: 4).isActive = true
        trainerNameLabel.trailingAnchor.constraint(equalTo: trainerContainerView.trailingAnchor, constant: -4).isActive = true
        trainerNameLabel.numberOfLines = 2
        trainerNameLabel.text = trainer?.trainerName
        trainerNameLabel.textAlignment = .center
    }
    
    private func configureCostLabel() {
        trainerContainerView.addSubview(costLabel)
        costLabel.topAnchor.constraint(equalTo: trainerNameLabel.bottomAnchor, constant: 6).isActive = true
        costLabel.leadingAnchor.constraint(equalTo: trainerContainerView.leadingAnchor, constant: 8).isActive = true
        costLabel.trailingAnchor.constraint(equalTo: trainerContainerView.trailingAnchor, constant: -4).isActive = true
        costLabel.numberOfLines = 1
        costLabel.text = trainer?.cost
        costLabel.textAlignment = .left
    }
    
    private func configureTrainingLabel() {
        trainerContainerView.addSubview(placeLabel)
        placeLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 6).isActive = true
        placeLabel.leadingAnchor.constraint(equalTo: trainerContainerView.leadingAnchor, constant: 8).isActive = true
        placeLabel.trailingAnchor.constraint(equalTo: trainerContainerView.trailingAnchor, constant: -8).isActive = true
        placeLabel.numberOfLines = 3
        placeLabel.text = trainer?.trainingPlace
        placeLabel.textAlignment = .left
    }
    
    // MARK: - Actions 
    
    @objc
    private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
}
