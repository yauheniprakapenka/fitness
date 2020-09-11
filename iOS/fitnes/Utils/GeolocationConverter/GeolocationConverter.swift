//
//  GeolocationConverter.swift
//  fitnes
//
//  Created by yauheni prakapenka on 22.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation
import CoreLocation

class GeolocationConverter {
    
    static let shared = GeolocationConverter()
    
    func getAddress(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
        
        //        let location = CLLocation(latitude: 52.43148883416086, longitude: 31.00485790184038)
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            
            guard let placemark = placemarks?.first else {
                let errorString = error?.localizedDescription ?? "Unexpected Error"
                print("Unable to reverse geocode the given location. Error: \(errorString)")
                return
            }
            
            let reversedGeoLocation = ReversedGeoLocation(with: placemark)
            //            print(reversedGeoLocation.formattedAddress)
            completion(reversedGeoLocation.formattedAddress)
        }
        
        struct ReversedGeoLocation {
            let name: String            // eg. Apple Inc.
            let streetName: String      // eg. Infinite Loop
            let streetNumber: String    // eg. 1
            let city: String            // eg. Cupertino
            let state: String           // eg. CA
            let zipCode: String         // eg. 95014
            let country: String         // eg. United States
            let isoCountryCode: String  // eg. US
            
            var formattedAddress: String {
                return "\(city), \(streetName) \(streetNumber)"
            }
            
            init(with placemark: CLPlacemark) {
                self.name           = placemark.name ?? ""
                self.streetName     = placemark.thoroughfare ?? ""
                self.streetNumber   = placemark.subThoroughfare ?? ""
                self.city           = placemark.locality ?? ""
                self.state          = placemark.administrativeArea ?? ""
                self.zipCode        = placemark.postalCode ?? ""
                self.country        = placemark.country ?? ""
                self.isoCountryCode = placemark.isoCountryCode ?? ""
            }
        }
    }
}
