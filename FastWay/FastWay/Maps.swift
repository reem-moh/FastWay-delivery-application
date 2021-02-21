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
        riyadhCoordinate.latitude = 24.8270610
        riyadhCoordinate.longitude = 46.6551692
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
        
        /*func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
                    
                    let over = MKPolylineRenderer(overlay: overlay)
                    over.strokeColor = .red
                    over.lineWidth = 3
                    return over
        }*/
        
    }
    
}



