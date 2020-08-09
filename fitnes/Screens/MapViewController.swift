//
//  MapViewController.swift
//  
//
//  Created by yauheni prakapenka on 09.08.2020.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var mapView = MKMapView()
    let backButton = FButtonWithColor(backgroundColor: #colorLiteral(red: 0.4109300077, green: 0.4760656357, blue: 0.9726527333, alpha: 1), title: "Назад")
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureMapView()
        configureBackButton()
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
        pin.title = "Тренировка здесь"
        //        pin.subtitle = "The tallest buildiing in the world."
        mapView.addAnnotation(pin)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
}
