//
//  MapView2.swift
//  FastWay
//
//  Created by Raghad AlOtaibi on 01/07/1442 AH.
//

import SwiftUI
import MapKit
import UIKit

struct MapView2: View {
   @ObservedObject private var LocationManagerr = LocationManager()
    
    var body: some View {
        
        let coordinate = self.LocationManagerr.location != nil ? self.LocationManagerr.location!.coordinate : CLLocationCoordinate2D()
        return ZStack{
            
            MapView3()
            
            Text("\(coordinate.latitude)").foregroundColor(Color.white).padding().background(Color.green).cornerRadius(10)
        }
    }
}

struct MapView2_Previews: PreviewProvider {
    static var previews: some View {
        MapView2()
    }
}

