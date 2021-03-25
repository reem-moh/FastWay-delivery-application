//
//  Tracking.swift
//  FastWay
//
//  Created by Ghaida . on 05/08/1442 AH.
//


import SwiftUI
import MapKit
import UIKit

//////member
//Current card M details assigned
var myTimer: Timer!

struct MapViewTracking : UIViewRepresentable {
    
    @Binding var map : MKMapView
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    @Binding var source : CLLocationCoordinate2D!
    @Binding var destination : CLLocationCoordinate2D!
    @Binding var distance : String
    @Binding var time : String
    @Binding var CourierID : String


    @State  var point3 = MKPointAnnotation()


    
    func makeUIView(context: Context) -> MKMapView {
        map.delegate = context.coordinator
        manager.delegate = context.coordinator as CLLocationManagerDelegate
       map.showsUserLocation = true
        let c = makeCoordinator()
        c.tap(pick: source, drop: destination)
        
        point3.subtitle = "Courier"
        point3.coordinate = riyadhCoordinatetracking
    //   map.removeAnnotation(point3)
       map.addAnnotation(point3)
        

        return map
    }
    
    
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        point3.subtitle = "Courier"
        point3.coordinate = riyadhCoordinatetracking
    //   map.removeAnnotation(point3)
       map.addAnnotation(point3)
        
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        var riyadhCoordinate = CLLocationCoordinate2D()
        
        //campus  location
        // riyadhCoordinate.latitude = 24.72640308847297
        // riyadhCoordinate.longitude = 46.638332536327816
        
        
        
        //ghaida location
        riyadhCoordinate.latitude = 24.8270610
        riyadhCoordinate.longitude = 46.6551692
        
        let region = MKCoordinateRegion(center: riyadhCoordinate, span: span)
        uiView.setRegion(region, animated: true)
        
//no need we can delete them
    print("ooooooooooooooooooooooooooooooooooooooo")
    print(riyadhCoordinatetracking.latitude)
    print(riyadhCoordinatetracking.longitude)
        getCourierLocation(CourierID: CourierID)

        
        
               myTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true){ timer in
                   map.removeAnnotation(point3)
                   getCourierLocation(CourierID: CourierID)
                   point3.coordinate = riyadhCoordinatetracking
                   print("timer fired!")
                   map.addAnnotation(point3)
                  // timer.invalidate()
              }
        
        
        
    }

    func makeCoordinator() -> Coordinator {
        
        return FastWay.MapViewTracking.Coordinator(parent1: self)
    }
    
    class Coordinator : NSObject,MKMapViewDelegate,CLLocationManagerDelegate{
        
        var parent : MapViewTracking
        
        init(parent1 : MapViewTracking) {
            
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
        
        
        ///////// ///////     custom annotation views
        
        func MapViewTracking(MapViewTracking: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            if !(annotation is CustomPointAnnotation) {
                //Check for CustomPointAnnotation (not MKPointAnnotation)
                //because the code below assumes CustomPointAnnotation.
                return nil
            }
            var _:Bool

            let reuseId = "test"
            var anView = MapViewTracking.dequeueReusableAnnotationView(withIdentifier: reuseId)
            if anView == nil {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView?.canShowCallout = true

                //Create and add UILabel only when actually creating MKAnnotationView...
                let nameLbl: UILabel! = UILabel(frame: CGRect(x: -24, y: 40, width: 100, height: 30))
                nameLbl.tag = 42    //set tag on it so we can easily find it later
                nameLbl.textColor = UIColor.black
                nameLbl.font = UIFont(name: "Atari Classic Extrasmooth", size: 10)
                nameLbl.textAlignment = NSTextAlignment.center
                anView?.addSubview(nameLbl)
            }
            else {
                anView?.annotation = annotation
            }

            let cpa = annotation as! CustomPointAnnotation
            anView?.image = cpa.image

            //NOTE: Setting selected property directly on MKAnnotationView
            //      is not recommended.
            //      See documentation for the property.
            //      Instead, call MKMapView.selectAnnotation method
            //      in the didAddAnnotationViews delegate method.
            if cpa.toBeTriggered == true {
                anView?.isSelected = true
            }

            //Get a reference to the UILabel already on the view
            //and set its text...
            if let nameLbl = anView?.viewWithTag(42) as? UILabel {
                nameLbl.text = cpa.nickName
            }

            return anView
        }
        
        class CustomPointAnnotation: MKPointAnnotation {
            var image: UIImage!
            var toBeTriggered: Bool = false
            var selected: Bool = false
            var nickName: String!
        }
        
        
    }
    
    
  
    //////////////////////////////////////////////////////////
    
    /*
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? Food {
            if annotation == mapView.userLocation {
                return nil
            }
            let identifier = "pin"
            var view: MKAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
                imageView.image = UIImage(named:"picture")
                imageView.layer.cornerRadius = imageView.layer.frame.size.width / 2

                imageView.layer.borderWidth = 1.5
                imageView.layer.borderColor = UIColor(red: 230/255, green: 39/255, blue: 39/255, alpha: 1).cgColor
                imageView.layer.masksToBounds = true
                view.addSubview(imageView)

                view.canShowCallout = true
                view.calloutOffset = CGPoint(x:  16, y: 16)
                view.layer.anchorPoint = CGRect(origin: 16 , size: 16)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
 */
    
    
}
