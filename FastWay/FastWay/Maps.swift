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
        //map = MKMapView(frame: .zero)
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

        
        //fuction to sit the pointers and draw a line between them
        
        
        func tap(pick: CLLocationCoordinate2D!, drop: CLLocationCoordinate2D!){
                    
                   // let location = ges.location(in: self.parent.map)
                   // let mplocation1 = self.parent.map.convert(location, toCoordinateFrom: self.parent.map)
                    
                    let point1 = MKPointAnnotation()
                    point1.subtitle = "Pick-up"
                    point1.coordinate = pick
            
            let point2 = MKPointAnnotation()
            point2.subtitle = "Drop-off"
            point2.coordinate = drop
                    
                    self.parent.destination = drop
                    self.parent.source = pick
                    
                    /*let decoder = CLGeocoder()
                    decoder.reverseGeocodeLocation(CLLocation(latitude: mplocation.latitude, longitude: mplocation.longitude)) { (places, err) in
                        
                        if err != nil{
                            
                            print((err?.localizedDescription)!)
                            return
                        }
                        
                        //self.parent.name = places?.first?.name ?? ""
                        point.title = places?.first?.name ?? ""
                        
                        //self.parent.show = true
                    }*/
                    
                    let req = MKDirections.Request()
                    req.source = MKMapItem(placemark: MKPlacemark(coordinate: self.parent.source))
                    
                    req.destination = MKMapItem(placemark: MKPlacemark(coordinate: self.parent.destination))
                    
                    let directions = MKDirections(request: req)
                    
                    directions.calculate { (dir, err) in
                        
                        if err != nil{
                            
                            print((err?.localizedDescription)!)
                            return
                        }
                        
                        let polyline = dir?.routes[0].polyline
                        
                        let dis = dir?.routes[0].distance as! Double
                        self.parent.distance = String(format: "%.1f", dis / 1000)
                        
                        let time = dir?.routes[0].expectedTravelTime as! Double
                        self.parent.time = String(format: "%.1f", time / 60)
                        
                        self.parent.map.removeOverlays(self.parent.map.overlays)
                        
                        self.parent.map.addOverlay(polyline!)
                        
                        self.parent.map.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
                    }
                    
                    //self.parent.map.removeAnnotations(self.parent.map.annotations)
                    self.parent.map.addAnnotation(point1)
                    self.parent.map.addAnnotation(point2)
                }//end tap
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
                    
                    let over = MKPolylineRenderer(overlay: overlay)
                    over.strokeColor = .red
                    over.lineWidth = 3
                    return over
                }
        
    }

    
}



