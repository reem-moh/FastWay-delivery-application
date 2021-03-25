//
//  Tracking.swift
//  FastWay
//
//  Created by Ghaida . on 05/08/1442 AH.
//


import SwiftUI
import MapKit
/*
struct ContentView: View {
    
    @Binding var map : MKMapView
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    @Binding var source : CLLocationCoordinate2D!
    @Binding var destination : CLLocationCoordinate2D!
    @Binding var distance : String
    @Binding var time : String
    
    var body: some View {
       
        MapViewTracking(manager: $manager, alert: $alert).alert(isPresented: $alert) {
            
            Alert(title: Text("Please Enable Location Access In Settings Pannel !!!"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}*/
//////member
//Current card M details assigned
var myTimer: Timer!

struct MapViewTracking : UIViewRepresentable {
    
    @Binding var map : MKMapView
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    @Binding var source : CLLocationCoordinate2D!
    @Binding var destination : CLLocationCoordinate2D!
   // @Binding var courierLocation : CLLocationCoordinate2D!
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


 
        myTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true){ timer in
            map.removeAnnotation(point3)
            getCourierLocation(CourierID: CourierID)
            point3.coordinate = riyadhCoordinatetracking
            print("timer fired!")
            map.addAnnotation(point3)
           // timer.invalidate()
       }
        
        
        
    }

    func makeCoordinator() -> Coordinator {
        
        return MapViewTracking.Coordinator(parent1: self)
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
            
            /*
            let point = CLLocationCoordinate2D(latitude: 24.8270611, longitude: 46.6551691)
         let   point4=MKPointAnnotation()
            point4.subtitle = "-off"
            point4.coordinate = point
           */
            
                
            //}
            
            self.parent.destination = drop
            self.parent.source = pick
        // self.parent.courierLocation = courierLoc
            
            self.parent.map.addAnnotation(point1)
            self.parent.map.addAnnotation(point2)
            

            //self.parent.map.addAnnotation(point4)


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
