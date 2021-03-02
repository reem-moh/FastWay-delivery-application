//
//  CurrentOrderViewDetailsCourier.swift
//  FastWay
//
//  Created by Ghaida . on 13/07/1442 AH.
//

import SwiftUI

struct CurrentOrderViewDetailsCourier: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CurrentOrderViewDetailsCourier_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOrderViewDetailsCourier()
    }
}



/*
 
 //
 //  CurrentOrderViewDetailsCourier.swift
 //  FastWay
 //
 //  Created by Ghaida . on 13/07/1442 AH.
 //


 import SwiftUI
 import MapKit
 import CoreLocation

 struct CurrentOrderViewDetailsCourier: View {
     @EnvironmentObject var model: CarouselViewModel
     @StateObject var viewRouter: ViewRouter
     var animation: Namespace.ID
     @State var map = MKMapView()
     @State var manager = CLLocationManager()
     @State var order : Order = Order()
     @State var alert = false
     @State var distance = ""
     @State var time = ""
     @State var expandOffer = false
     @State var expand = false
     @State var offer = 0
     @State var offerList : String = "Offer price"
     @State var checkOffer : Bool = false
     @State var show = false
     @State private var showingPaymentAlert = false


     var body: some View{
         
         ZStack{
             
             //map
             MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$model.selectedCard.orderD.pickUP, destination: self.$model.selectedCard.orderD.dropOff, distance: self.$distance, time: self.$time)
                 .cornerRadius(35)
                 .frame(width: 390, height: 300).padding(.bottom, 0)
                 .clipped().position(x: 188,y: 100)
                 .offset(y: 50)
                 .onAppear {
                     
                     self.manager.requestAlwaysAuthorization()
                 }
             
             // VStack{
             
             ZStack {
                 //go back button
                 //arrow_back image
                 Group{
                     RoundedRectangle(cornerRadius: 10).frame(width: 45, height: 35).foregroundColor(Color(.white))
                     
                     Button(action: {
                         // model.showCard = false
                         
                         withAnimation(.spring()){
                             model.showCard.toggle()
                             DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                 withAnimation(.easeIn){
                                     model.showContent = false
                                     
                                 }
                             }
                             
                         }
                     }) {
                         Image("arrow_back")
                             .resizable()
                             .colorInvert()
                             .aspectRatio(contentMode: .fill)
                             .frame(width: 30, height: 30)
                             .clipped()
                             .background(Color(.white))
                     }.padding(1.0)
                 }.position(x: 50, y: 50)
                 
                 
                 //white background
                 Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).edgesIgnoringSafeArea(.bottom).offset(y: 240).shadow(radius: 2)
                 
                 VStack{
                     
                     ScrollView{
                         HStack{
                             Image(systemName: "clock")
                                 .foregroundColor(Color.black.opacity(0.5))
                                 .offset(x: 10, y: 10)
                                 .padding(.leading)
                             Text("\(model.selectedCard.orderD.createdAt.calenderTimeSinceNow())")
                                 .font(.body)
                                 .fontWeight(.regular)
                                 .foregroundColor(Color.black.opacity(0.5))
                                 .animation(.easeIn)
                                 .offset(x: 10, y: 10)
                             Spacer(minLength: 0)
                         }
                         //pick up
                         ZStack{
                             RoundedRectangle(cornerRadius: 15).padding().frame(width: 350, height: 160).foregroundColor(.white).shadow(radius: 1)
                             Image(uiImage: #imageLiteral(resourceName: "IMG_0528 1")).offset(x: -125)
                             HStack {
                                 
                                 Text("Building \(self.getBuilding(id: model.selectedCard.orderD.pickUpBulding)), \nfloor \(model.selectedCard.orderD.pickUpFloor),  \(model.selectedCard.orderD.pickUpRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 200, alignment: .leading)
                             }
                             
                         }
                         //drop off
                         ZStack{
                             RoundedRectangle(cornerRadius: 15).padding().frame(width: 350, height: 160).foregroundColor(.white).shadow(radius: 1)
                             Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 3")).offset(x: -125)
                             HStack{
                                 
                                 Text("Building \(self.getBuilding(id: model.selectedCard.orderD.dropOffBulding)), \nfloor \(model.selectedCard.orderD.dropOffFloor),  \(model.selectedCard.orderD.dropOffRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 200, alignment: .leading)
                             }
                             
                         }
                         //order items
 {
     
     Text("\(model.selectedCard.orderD.orderDetails)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 220, alignment: .leading)
 }
                         //Offer price
                         if(checkOffer) {
                             Text("*You must specify a price").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)))
                                 .offset(x: -50)
                             
                         }
                        
                         //make an offer button
                         Button(action: {
                             
                             showingPaymentAlert.toggle()


                            // if(true){
                            //     viewRouter.notificationT =  .CancelOffer

                             //    viewRouter.currentPage = .CurrentOrderCourier
                            // }
                             
                             let isOfferAddrd = order.addOffer(OrderId: model.selectedCard.orderD.id, memberID:model.selectedCard.orderD.memberId , price: offer, locationLatiude: map.userLocation.coordinate.latitude, locationLongitude: map.userLocation.coordinate.longitude)
                             
                             

                         }) {
                             Text("Cancel Offer")
                                 .font(.custom("Roboto Bold", size: 22))
                                 .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                 .multilineTextAlignment(.center)
                                 .padding(1.0)
                                 .frame(width: UIScreen.main.bounds.width - 50)
                                 .textCase(.none)
                             

                         }
                         .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                         .padding(.top,25)
                         .offset(x: 0)
                         .padding(.bottom,450)
                         
                     }
                 }.position(x: 188,y: 700)
             }
             // }
             
         }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).alert(isPresented: $showingPaymentAlert) {Alert(title: Text("Order confirmed"), message: Text("Are you sure you want cancel this offer"), primaryButton: .default((Text("YES")), action: { viewRouter.notificationT =  .CancelOffer
 
 viewRouter.currentPage = .CurrentOrderCourier}) , secondaryButton: .cancel((Text("NO"))))
}
         
     }
     
     
     
     //name of building
     func getBuilding(id: Int) -> String {
         var building = ""
         switch id {
         case 5:
             building = "no.5 College Of Sciences"
         case 6:
             building = "no.6 College Of Computer and Information Sciences"
         case 8:
             building = "no.8 College Of Pharmacy"
         case 9:
             building = "no.9 College Of Medicine"
         case 10:
             building = "no.10 College Of Dentistry"
         case 11:
             building = "no.11 College Of Applied Medical Science"
         case 2:
             building = "no.12 College Of Education"
         case 13:
             building = "no.13 College Of Arts"
         case 4:
             building = "no.14 College Of Languages And Translation"
         case 3:
             building = "no.15 College Of Business Administration"
         case 16:
             building = "no.16 College of Sports Sciences and Physical Activity"
         case 7:
             building = "no.17 College of Law and Political Sciences"
         default:
             building = ""
         }
         return building
     }
     
 }
 
 
 
 */
