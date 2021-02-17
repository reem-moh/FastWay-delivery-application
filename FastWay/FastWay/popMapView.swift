//
//  popMapView.swift
//  FastWay
//
//  Created by Shahad AlOtaibi on 05/07/1442 AH.
//

import SwiftUI
import MapKit

struct popMapView: View {
    
    @StateObject var viewRouter: ViewRouter
    @State var map = MKMapView()
        @State var manager = CLLocationManager()
        @State var alert = false
        @State var source : CLLocationCoordinate2D!
        @State var destination : CLLocationCoordinate2D!
    var body: some View {
        
        ZStack{
            EntireMapView(map: $map, manager: $manager, alert: $alert, source: $source, destination: $destination)
            
Text("hello")
            Button(action: {
                viewRouter.currentPage = .AddNewOrder

                })   {
                    Text("Done").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50)
                                    }
                .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                .padding(.top,25)
          
        }
    
}
    
}

struct popMapView_Previews: PreviewProvider {
    static var previews: some View {
        popMapView(viewRouter: ViewRouter())
    }
}
