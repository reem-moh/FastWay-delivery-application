//
//  LocationMsnager.swift
//  FastWay
//
//  Created by Raghad AlOtaibi on 01/07/1442 AH.
//
import SwiftUI
import Foundation
import MapKit
import CoreLocation
 

class LocationManager: NSObject , ObservableObject{
    private let LocationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        self.LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.LocationManager.distanceFilter = kCLDistanceFilterNone
        self.LocationManager.requestWhenInUseAuthorization()
        self.LocationManager.startUpdatingLocation()
        self.LocationManager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
       
        DispatchQueue.main.async {
            self.location = location
        }
    }
}

