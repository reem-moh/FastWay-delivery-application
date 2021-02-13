//
//  LocationMsnager.swift
//  FastWay
//
//  Created by Raghad AlOtaibi on 01/07/1442 AH.
//
/*
import SwiftUI
import Foundation
import MapKit

/*struct LocationMsnager: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LocationMsnager_Previews: PreviewProvider {
    static var previews: some View {
        LocationMsnager()
    }
}*/

class LocatIonMsnager: NSObject , ObservableObject{
    private let locaIonManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    
    override init() {
        super.init()
        self.locaIonManager.delegate = self
        self.locaIonManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locaIonManager.distanceFilter = kCLDistanceFilterNone
        self.locaIonManager.requestWhenInUseAuthorization()
        self.locaIonManager.startUpdatingLocation()
        
        
    }
}

extension LocatIonMsnager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else{
            return
        }
        self.location = location
    }
}
*/
