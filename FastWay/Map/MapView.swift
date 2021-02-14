//
//  Home.swift
//  mapTest
//
//  Created by Shahad AlOtaibi on 01/07/1442 AH.
//
/*

import SwiftUI
import MapKit
import CoreLocation
import Firebase
import Foundation
import UIKit

struct Home : View {
    
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var source : CLLocationCoordinate2D!
    @State var destination : CLLocationCoordinate2D!

    @State var show = false
    @State var doc = ""
    @State var data : Data = .init(count: 0)
    @State var search = false
    @State var name = ""
    
    var body: some View{
        
        ZStack{
            
            ZStack(alignment: .bottom){
                
                VStack(spacing: 0){
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text(self.destination != nil ? "Destination" : "Pick a Location")
                                .font(.title)
                            
                          /*  if self.destination != nil{
                                
                                Text(self.name)
                                    .fontWeight(.bold)
                            }*/
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            
                            self.search.toggle()
                            
                        }) {
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color.white)
                    
                    MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$source, destination: self.$destination,show: self.$show)
                    .onAppear {
                    
                        self.manager.requestAlwaysAuthorization()
                            
                    }
                }
                
                if self.destination != nil && self.show{
                    
                    ZStack(alignment: .topTrailing){
                        
                        VStack(spacing: 20){
                            
                            HStack{
                                
                              /*  VStack(alignment: .leading,spacing: 15){
                                    
                                    Text("Destination")
                                        .fontWeight(.bold)
                                    Text(self.name)
                                    
                                    Text("Distance - "+self.distance+" KM")
                                    
                                    Text("Expexted Time - "+self.time + "Min")
                                }*/
                                
                                Spacer()
                            }
                            
                            Button(action: {
                                
                               /* self.loading.toggle()*/
                                
                                //self.Book()
                                
                            }) {
                                
                                Text("Book Now")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .frame(width: UIScreen.main.bounds.width / 2)
                            }
                            .background(Color.red)
                            .clipShape(Capsule())
                        
                        }
                        
                        Button(action: {
                            
                            self.map.removeOverlays(self.map.overlays)
                            self.map.removeAnnotations(self.map.annotations)
                            self.destination = nil
                            
                            self.show.toggle()
                            
                        }) {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    .background(Color.white)
                }
            }
            
          //  if self.loading{
            
            //    Loader()
            //}
            
         
            if self.search{
                
                SearchView(show: self.$search, map: self.$map, source: self.$source, destination: self.$destination, name: self.$name, detail: self.$show)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: self.$alert) { () -> Alert in
            
            Alert(title: Text("Error"), message: Text("Please Enable Location In Settings !!!"), dismissButton: .destructive(Text("Ok")))
        }
    }
    
}

struct Loader : View {
    
    @State var show = false
    
    var body: some View{
        
        GeometryReader{_ in
            
            VStack(spacing: 20){
                
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: self.show ? 360 : 0))
                    .onAppear {
                        
                        withAnimation(Animation.default.speed(0.45).repeatForever(autoreverses: false)){
                            
                            self.show.toggle()
                        }
                }
                
                Text("Please Wait....")
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 40)
            .background(Color.white)
            .cornerRadius(12)
        }
        .background(Color.black.opacity(0.25).edgesIgnoringSafeArea(.all))
    }
}


struct MapView : UIViewRepresentable {
    
    
    func makeCoordinator() -> Coordinator {
        
        return MapView.Coordinator(parent1: self)
    }
    
    @Binding var map : MKMapView
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    @Binding var source : CLLocationCoordinate2D!
    @Binding var destination : CLLocationCoordinate2D!
  //  @Binding var name : String
   // @Binding var distance : String
    //@Binding var time : String
    @Binding var show : Bool
    
    func makeUIView(context: Context) ->  MKMapView {
        
        map.delegate = context.coordinator
        manager.delegate = context.coordinator
        map.showsUserLocation = true
        let gesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.tap(ges:)))
        map.addGestureRecognizer(gesture)
        return map
    }
    
    func updateUIView(_ uiView:  MKMapView, context: Context) {
        
        
    }
    
    class Coordinator : NSObject,MKMapViewDelegate,CLLocationManagerDelegate{
        
        var parent : MapView
        
        init(parent1 : MapView) {
            
            parent = parent1
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            if status == .denied{
                
                self.parent.alert.toggle()
            }
            else{
                
                self.parent.manager.startUpdatingLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            let region = MKCoordinateRegion(center: locations.last!.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            self.parent.source = locations.last!.coordinate
            
            self.parent.map.region = region
        }
        
        @objc func tap(ges: UITapGestureRecognizer){
            
            let location = ges.location(in: self.parent.map)
            let mplocation = self.parent.map.convert(location, toCoordinateFrom: self.parent.map)
            
            let point = MKPointAnnotation()
            point.subtitle = "Destination"
            point.coordinate = mplocation
            
            self.parent.destination = mplocation
            
            let decoder = CLGeocoder()
            decoder.reverseGeocodeLocation(CLLocation(latitude: mplocation.latitude, longitude: mplocation.longitude)) { (places, err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
              //  self.parent.name = places?.first?.name ?? ""
                point.title = places?.first?.name ?? ""
                
                self.parent.show = true
            }
            
            let req = MKDirections.Request()
            req.source = MKMapItem(placemark: MKPlacemark(coordinate: self.parent.source))
            
            req.destination = MKMapItem(placemark: MKPlacemark(coordinate: mplocation))
            
            let directions = MKDirections(request: req)
            
            directions.calculate { (dir, err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                let polyline = dir?.routes[0].polyline
                
            //  let dis = dir?.routes[0].distance
              //  self.parent.distance = String(format: "%.1f", dis! / 1000)
                
              // let time = dir?.routes[0].expectedTravelTime
             //   self.parent.time = String(format: "%.1f", time! / 60)
                
                self.parent.map.removeOverlays(self.parent.map.overlays)
                
                self.parent.map.addOverlay(polyline!)
                
                self.parent.map.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
            }
            
            self.parent.map.removeAnnotations(self.parent.map.annotations)
            self.parent.map.addAnnotation(point)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let over = MKPolylineRenderer(overlay: overlay)
            over.strokeColor = .red
            over.lineWidth = 3
            return over
        }
    }
}


struct SearchView: View {
    
    @State var result : [SearchData] = []
    @Binding var show : Bool
    @Binding var map : MKMapView
    @Binding var source : CLLocationCoordinate2D!
    @Binding var destination : CLLocationCoordinate2D!
    @Binding var name : String
    //@Binding var distance : String
    //@Binding var time : String
    @State var txt = ""
    @Binding var detail : Bool
    
    var body: some View {
        
        GeometryReader{_ in
            
            VStack(spacing: 0){
                
                SearchBar(map: self.$map, source: self.$source, destination: self.$destination, result: self.$result,txt: self.$txt)
                
                if self.txt != ""{
                    
                    List(self.result){i in
                        
                        VStack(alignment: .leading){
                            
                            Text(i.name)
                            
                            Text(i.address)
                                .font(.caption)
                        }
                        .onTapGesture {
                            
                            self.destination = i.coordinate
                            self.UpdateMap()
                            self.show.toggle()
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height / 2)
                }
            }
            .padding(.horizontal, 25)
        }
        .background(Color.black.opacity(0.2).edgesIgnoringSafeArea(.all)
        .onTapGesture {
            self.show.toggle()
        })
    }
    
    func UpdateMap(){
        
        let point = MKPointAnnotation()
        point.subtitle = "Destination"
        point.coordinate = destination
           
        let decoder = CLGeocoder()
        decoder.reverseGeocodeLocation(CLLocation(latitude: destination.latitude, longitude: destination.longitude)) { (places, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            self.name = places?.first?.name ?? ""
            point.title = places?.first?.name ?? ""

            self.detail = true
        }
        
        let req = MKDirections.Request()
        req.source = MKMapItem(placemark: MKPlacemark(coordinate: self.source))
        
        req.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        
        let directions = MKDirections(request: req)
        
        directions.calculate { (dir, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            let polyline = dir?.routes[0].polyline
            
          //  let dis = dir?.routes[0].distance
         //   self.distance = String(format: "%.1f", dis! / 1000)
            
        //    let time = dir?.routes[0].expectedTravelTime
          //  self.time = String(format: "%.1f", time! / 60)
            
            self.map.removeOverlays(self.map.overlays)
            
            self.map.addOverlay(polyline!)
            
            self.map.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
        }
        
        self.map.removeAnnotations(self.map.annotations)
        self.map.addAnnotation(point)
    }
}


struct SearchBar : UIViewRepresentable {
    
    @Binding var map : MKMapView
    @Binding var source : CLLocationCoordinate2D!
    @Binding var destination : CLLocationCoordinate2D!
    @Binding var result : [SearchData]
   // @Binding var name : String
   // @Binding var distance : String
   // @Binding var time : String
    @Binding var txt : String
    
    func makeCoordinator() -> Coordinator {
        
        return SearchBar.Coordinator(parent1: self)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        
        let view = UISearchBar()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView:  UISearchBar, context: Context) {
        
        
    }
    
    class Coordinator : NSObject,UISearchBarDelegate{
        
        var parent : SearchBar
        
        init(parent1 : SearchBar) {
            
            parent = parent1
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            self.parent.txt = searchText
            
            let req = MKLocalSearch.Request()
            req.naturalLanguageQuery = searchText
            req.region = self.parent.map.region
            
            let search = MKLocalSearch(request: req)
            
            DispatchQueue.main.async {
                
                self.parent.result.removeAll()
            }
            
            search.start { (res, err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                for i in 0..<res!.mapItems.count{
                    
                    let temp = SearchData(id: i, name: res!.mapItems[i].name!, address: res!.mapItems[i].placemark.title!, coordinate: res!.mapItems[i].placemark.coordinate)
                    
                    self.parent.result.append(temp)
                }
            }
        }
    }
}


struct SearchData : Identifiable {
    
    var id : Int
    var name : String
    var address : String
    var coordinate : CLLocationCoordinate2D
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}*/
