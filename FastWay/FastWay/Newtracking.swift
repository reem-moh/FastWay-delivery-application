//
//  Newtracking.swift
//  FastWay
//
//  Created by Ghaida . on 06/08/1442 AH.
//

import SwiftUI
import MapKit
import CoreLocation
 
//courierrrrr
//Current card c details New order
//@objc
dynamic var riyadhCoordinatetracking = CLLocationCoordinate2D()
struct Newtracking: UIViewRepresentable {
    
    @Binding var map : MKMapView
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    @Binding var source : CLLocationCoordinate2D!
    @Binding var destination : CLLocationCoordinate2D!
    @Binding var distance : String
    @Binding var time : String
    @Binding var CourierID : String

    
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
        
        //ghaida location
      // riyadhCoordinate.latitude = 24.8270610
       //riyadhCoordinate.longitude = 46.6551692
        
        //campus  location
       riyadhCoordinate.latitude = 24.72640308847297
       riyadhCoordinate.longitude = 46.638332536327816
        
    
        
        riyadhCoordinatetracking = map.userLocation.coordinate
     
    updateCourierLocation(CourierID: CourierID, courierLocation: riyadhCoordinatetracking)

        
        let region = MKCoordinateRegion(center: riyadhCoordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
    
    
    func makeCoordinator() -> Coordinator {
        
        return Newtracking.Coordinator(parent1: self)
    }
    
    class Coordinator : NSObject,MKMapViewDelegate,CLLocationManagerDelegate{
        
        var parent : Newtracking
        
        init(parent1 : Newtracking) {
            
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
        
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            if status == .denied{
                
                parent.alert.toggle()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            //manager.update
            let location = locations.last
            let point = MKPointAnnotation()
            
            let georeader = CLGeocoder()
            georeader.reverseGeocodeLocation(location!) { (places, err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                let place = places?.first?.locality
                point.title = place
                point.subtitle = "Current"
                point.coordinate = location!.coordinate
                self.parent.map.removeAnnotations(self.parent.map.annotations)
                self.parent.map.addAnnotation(point)
                
                let region = MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                self.parent.map.region = region
            }
        }
        
        
    }
    
}






