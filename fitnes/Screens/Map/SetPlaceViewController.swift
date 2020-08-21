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
 
    private let bottomView = UIView()
    private let descriptionLabel = FLabel(fontSize: 13, weight: .light, color: .black, message: "Отметьте место на карте. В поле ниже появится предложенный адрес, который увидит атлет.")
    private var placeTextField = FTextField(placeholderText: "Здесь можно отредактировать адрес", placeholderColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    private let userPin = MKPointAnnotation()
    
    private var currnetLatitude: Double?
    private var currentLongitude: Double?
    private var currentPhoto: UIImage?
    private var currentAddress: String?
    
    private var placeModel: PlaceModel?
    
    var delegate: SetPlaceVСDelegate?
    
    private lazy var mkMapView: MKMapView = {
        let mapView = MKMapView(frame: view.frame)
        mapView.delegate = self
        
        let latitude: CLLocationDegrees = 52.431296
        let longitude: CLLocationDegrees = 31.005284
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        mapView.setCenter(center, animated: true)
        
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: center, span: mySpan)
        mapView.region = myRegion
        
        let myLongPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer()
        myLongPress.addTarget(self, action: #selector(recognizeLongPress(_:)))
        
        mapView.addGestureRecognizer(myLongPress)
        
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(mkMapView)
        
        configureNavigation()
        
        configureBottonView()
        configureDescriptionLabel()
        configurePlaceTextField()
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
    
    @objc
    private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func saveButtonTapped() {
        guard let currnetLatitude = currnetLatitude else { return }
        guard let currentLongitude = currentLongitude else { return }
        
        if currentPhoto == nil {
            currentPhoto = #imageLiteral(resourceName: "city-black-and-white")
        }
        
        if currentAddress == nil {
            currentAddress = "г. Санкт-Петербург, ул. Братьев Лизюковых, 77а"
        }
        
        placeModel = PlaceModel(
            address: currentAddress!,
            placeImage: currentPhoto!,
            lat: currnetLatitude,
            long: currentLongitude)
        
        delegate?.addPlace(place: placeModel!)
    }
    
    private func configureBottonView() {
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .white
        bottomView.layer.cornerRadius = 10
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        bottomView.layer.shadowOpacity = 0.1
        bottomView.layer.shadowRadius = 2
        bottomView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 4).isActive = true
    }
    
    private func configureDescriptionLabel() {
        bottomView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2
        
        descriptionLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 40).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -40).isActive = true
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
        userPin.title = "Тренировка"
        userPin.subtitle = "будет здесь"
        
        mkMapView.addAnnotation(userPin)
        mkMapView.selectAnnotation(mkMapView.annotations[0], animated: true) // для отображения title и subtitle
    }
    
    @objc
    private func addPhotoImageViewTapped() {
        let vc = PhotoViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func configurePlaceTextField() {
        bottomView.addSubview(placeTextField)
        placeTextField.delegate = self
        placeTextField.translatesAutoresizingMaskIntoConstraints = false
        
        placeTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        placeTextField.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20).isActive = true
        placeTextField.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20).isActive = true
        placeTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension SetPlaceViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let myPinIdentifier = "PinAnnotationIdentifier"
        
        let myPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: myPinIdentifier)
        myPinView.animatesDrop = true
        myPinView.canShowCallout = true
        myPinView.annotation = annotation
        
        print("latitude: \(annotation.coordinate.latitude), longitude: \(annotation.coordinate.longitude)")
        
        currnetLatitude = annotation.coordinate.latitude
        currentLongitude = annotation.coordinate.longitude
        
        return myPinView
    }
}

extension SetPlaceViewController: PhotoViewControllerDelegate {
    
    func addPhoto(image: UIImage) {
        dismiss(animated: true) {
            self.currentPhoto = image
        }
    }
}

extension SetPlaceViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        placeTextField.resignFirstResponder()
        currentAddress = placeTextField.text
        return true
    }
}
