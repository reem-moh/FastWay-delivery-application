//
//  Tracking.swift
//  FastWay
//
//  Created by Ghaida . on 05/08/1442 AH.
//

import CoreLocation
import Combine

class LocationManagerService: NSObject, ObservableObject, CLLocationManagerDelegate {
    var manager: CLLocationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var enabled: Bool = false
    
    override init() {
        super.init()
        manager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            manager.requestWhenInUseAuthorization()
            // manager.requestAlwaysAuthorization()
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location changed") // prints only once
        location = locations.first
      //  manager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        enabled = CLLocationManager.locationServicesEnabled()
    }
}
