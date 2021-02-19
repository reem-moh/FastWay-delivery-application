//
//  Maps.swift
//  FastWay
//
//  Created by taif.m on 2/14/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct Maps: View {
    var body: some View {
        Home()
    }
}

struct Maps_Previews: PreviewProvider {
    static var previews: some View {
        Maps()
    }
}

struct Home: View {
    
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var source : CLLocationCoordinate2D!
    @State var destination : CLLocationCoordinate2D!
    
    var body: some View{
        
        ZStack{
            
            VStack(spacing: 0){
                MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$source, destination: self.$destination)
                    .onAppear {
                        
                        self.manager.requestAlwaysAuthorization()
                        
                    }
                
            }
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
}

struct MapView : UIViewRepresentable {
    
    
    @Binding var map : MKMapView
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    @Binding var source : CLLocationCoordinate2D!
    @Binding var destination : CLLocationCoordinate2D!
    
    func makeUIView(context: Context) -> MKMapView {
        //map = MKMapView(frame: .zero)
        map.delegate = context.coordinator
        manager.delegate = context.coordinator as CLLocationManagerDelegate
        map.showsUserLocation = true
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
    
}

class Coordinator : NSObject,MKMapViewDelegate,CLLocationManagerDelegate{
    
    var parent : MapView
    
    init(parent1 : MapView) {
        
        parent = parent1
    }
    
    
    //fuction to sit the pointers and draw a line between them
    
    
    
    
   /* func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .denied{
            
            self.parent.alert.toggle()
        }
        else{
            
            self.parent.manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.parent.source = locations.last!.coordinate
    }*/
    
   
    
}

