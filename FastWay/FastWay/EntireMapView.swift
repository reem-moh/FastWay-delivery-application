//
//  EntireMapView.swift
//  maptest3
//
//  Created by Shahad AlOtaibi on 02/07/1442 AH.
//

import SwiftUI
import MapKit
import UIKit

var pickAndDrop = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
var CheckPinInRegion = true

struct EntireMapView: UIViewRepresentable {
    
    
    
    
    
    @Binding var map : MKMapView
    @Binding var manager : CLLocationManager
    
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        var riyadhCoordinate = CLLocationCoordinate2D()
        
        
        //ghaida location
       // riyadhCoordinate.latitude = 24.8270610
       // riyadhCoordinate.longitude = 46.6551692
        
        //campus  location
              riyadhCoordinate.latitude = 24.72640308847297
         riyadhCoordinate.longitude = 46.638332536327816
        
    
        let region = MKCoordinateRegion(center: riyadhCoordinate, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        map.delegate = context.coordinator
        manager.delegate = context.coordinator as? CLLocationManagerDelegate
        manager.requestAlwaysAuthorization()
        map.showsUserLocation = true
        let longPress = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(EntireMapViewCoordinator.addAnnotation(gesture:)))
        longPress.minimumPressDuration = 0.1
        map.addGestureRecognizer(longPress)
        map.delegate = context.coordinator
        return map
    }
    
    
    func makeCoordinator() -> EntireMapViewCoordinator {
        return EntireMapViewCoordinator(self)
    }
    
    
    
    class EntireMapViewCoordinator: NSObject, MKMapViewDelegate {
        
        
        
        var entireMapViewController: EntireMapView
        
        init(_ control: EntireMapView) {
            self.entireMapViewController = control
        }
        
        
        @objc func addAnnotation(gesture: UIGestureRecognizer) {
            
            if gesture.state == .ended {
                var test: Double
                var test1: Double
                
                if let mapView = gesture.view as? MKMapView {
                    mapView.removeAnnotations(mapView.annotations)
                    let point = gesture.location(in: mapView)
                    let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    mapView.addAnnotation(annotation)
                    let location = coordinate
                    pickAndDrop = coordinate
                    test = location.latitude
                    test1 = location.longitude
                    print("User annotation")
                    print(test)
                    print(test1)
                    
                }
            }
        }
        
    }
    
    
}
