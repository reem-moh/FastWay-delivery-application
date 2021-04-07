//
//  Maps.swift
//  FastWay
//
//  Created by taif.m on 2/14/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView : UIViewRepresentable {
    
    @Binding var map : MKMapView
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    @Binding var source : CLLocationCoordinate2D!
    @Binding var destination : CLLocationCoordinate2D!
    @Binding var distance : String
    @Binding var time : String
    
    func makeUIView(context: Context) -> MKMapView {
        map.delegate = context.coordinator
        manager.delegate = context.coordinator as CLLocationManagerDelegate
        map.showsUserLocation = true
        let c = makeCoordinator()
        c.tap(pick: source, drop: destination)
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        var riyadhCoordinate = CLLocationCoordinate2D()
        
       // ghaida location
       // riyadhCoordinate.latitude = 24.8270610
       // riyadhCoordinate.longitude = 46.6551692
        
        
        //campus  location
         riyadhCoordinate.latitude = 24.72640308847297
         riyadhCoordinate.longitude = 46.638332536327816
        
        
        let region = MKCoordinateRegion(center: riyadhCoordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        
        return MapView.Coordinator(parent1: self)
    }
    
    class Coordinator : NSObject,MKMapViewDelegate,CLLocationManagerDelegate{
        
        var parent : MapView
        
        init(parent1 : MapView) {
            
            parent = parent1
        }
        
        func tap(pick: CLLocationCoordinate2D!, drop: CLLocationCoordinate2D!){
            
            let point1 = MKPointAnnotation()
            point1.subtitle = "Pick-up"
            point1.coordinate = pick
            
            let point2 = MKPointAnnotation()
            point2.subtitle = "Drop-off"
            point2.coordinate = drop
            
            self.parent.destination = drop
            self.parent.source = pick
            
            self.parent.map.addAnnotation(point1)
            self.parent.map.addAnnotation(point2)
        }//end tap
        
        
        
    }
    
}


func getDistance(loc1: CLLocation, loc2: CLLocation) -> String {
    var distance = 0.0
    var sDistance = ""
    
    distance = loc1.distance(from: loc2)
    if distance >= 0 && distance < 1000 {
        sDistance = String(format: "%d m", Int(distance))
    }else{
        if distance >= 1000{
            sDistance = String(format: "%.1f km", distance/1000)
        }
    }
    return sDistance
}



