//
//  CurrentCardCDetailesNeworder.swift
//  FastWay
//
//  Created by Reem on 19/03/2021.
//
import SwiftUI
import MapKit

//courierrrrr
//Current card c details New order
struct CurrentCardCDetailesNeworder: View {
    @EnvironmentObject var model : CurrentCarouselCViewModel
    @StateObject var viewRouter: ViewRouter
    var animation: Namespace.ID
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var distance = ""
    @State var time = ""
    @State var expandOffer = false
    @State var expand = false
    @State private var showingPaymentAlert = false
    @State var stat = ""
    @State var oneDouble = 0.0
    @State var tDouble = 0.0
    
    var body: some View{
        
        ZStack{
            
            //map
            Newtracking(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$model.selectedCard.orderD.pickUP, destination: self.$model.selectedCard.orderD.dropOff, distance: self.$distance, time: self.$time)
                .cornerRadius(35)
                .frame(width: width(num:390), height: hieght(num:300)).padding(.bottom, 0)
                .clipped().position(x: width(num:188),y: hieght(num:100))
                .offset(y: hieght(num:50))
                .onAppear(){
                    self.manager.requestAlwaysAuthorization()
                    print("inside updateCourierLocation in HHHHHJHKHKUHHHHHHHHHHHHH")
                  //  model.order.getCourierLocation(orderId: model.selectedCard.orderD.id)
                     oneDouble = Double(model.order.traking.courierLocation.longitude)
                   // self.oneDouble = value
                    tDouble = Double(model.order.traking.courierLocation.latitude)
                  // self.tDouble = value
                    //self.model.getCourierLocation
                    
                    model.order.updateCourierLocation(orderId: model.selectedCard.orderD.id, courierLocation: CLLocationCoordinate2D(latitude: riyadhCoordinatetracking.latitude, longitude: riyadhCoordinatetracking.longitude))
                    
                    /*riyadhCoordinatetracking
                    model.order.updateCourierLocation(orderId: model.selectedCard.orderD.id, courierLocation: CLLocationCoordinate2D(latitude: model.order.traking.courierLocation.latitude, longitude: model.order.traking.courierLocation.longitude))
               */
                
                }
            /*    .onChange(of: model.order.traking.courierLocation.longitude) { value in
                   // courierLocation = Float(courierLocation.longitude)
                    print("inside updateCourierLocation in HHHHHJHKHKUHHHHHHHHHHHHH")

                     oneDouble = Double(model.order.traking.courierLocation.longitude)
                    self.oneDouble = value
                    tDouble = Double(model.order.traking.courierLocation.latitude)
                   self.tDouble = value
                    //self.model.getCourierLocation
                    model.order.updateCourierLocation(orderId: model.selectedCard.orderD.id, courierLocation: model.selectedCard.orderD.courierLocation)
                
                }*/
            
            // VStack{
            
            ZStack {
                //go back button
                //arrow_back image
                Group{
                    RoundedRectangle(cornerRadius: 10).frame(width: width(num:45), height: hieght(num:35)).foregroundColor(Color(.white))
                    Button(action: {
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
                            .frame(width: width(num:30), height: hieght(num:30))
                            .clipped()
                            .background(Color(.white))
                    }.padding(1.0)
                }.position(x: width(num:50), y: hieght(num:50))
                
                
                //white background
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                    .resizable() //add resizable
                    .frame(width: width(num: 375)) //addframe
                    .edgesIgnoringSafeArea(.bottom).offset(y: hieght(num:240)).shadow(radius: 2)
                
                VStack{
                    
                    ScrollView{
                        HStack{
                            Image(systemName: "clock")
                                .foregroundColor(Color.black.opacity(0.5))
                                .offset(x: width(num:10), y: hieght(num:10))
                                .padding(.leading)
                            Text("\(model.selectedCard.orderD.createdAt.calenderTimeSinceNow())")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color.black.opacity(0.5))
                                .animation(.easeIn)
                                .offset(x: width(num:10), y: hieght(num:10))
                            Spacer(minLength: 0)
                            Spacer(minLength: 0)

                            
                            Image(uiImage: #imageLiteral(resourceName: "dollar"))
                                .foregroundColor(Color.black.opacity(0.5))
                                .offset(x: width(num:10), y: hieght(num:10))
                                .padding(.leading)
                            
                            Text("\(model.selectedCard.orderD.deliveryPrice) SR")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color.black.opacity(0.5))
                                .animation(.easeIn)
                                .offset(x: width(num:10), y: hieght(num:10))
                            Spacer(minLength: 0)
                        }
                        
                        if model.selectedCard.orderD.status == ""{
                            HStack{
                                Text("New order")
                                    .foregroundColor(.green)
                                    .bold()
                                    .padding(.leading, width(num:20))
                                DotView(frame: 15)
                                DotView(delay: 0.2, frame: 15)
                                DotView(delay: 0.4, frame: 15)
        
                            Spacer(minLength: 0)
                            }
                        }
                        
                        //pick up
                        ZStack{
                            RoundedRectangle(cornerRadius: 15).padding().frame(width: width(num:350), height: hieght(num:160)).foregroundColor(.white).shadow(radius: 1)
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 1")).offset(x: width(num:-125))
                            HStack {
                                
                                Text("Building \(self.getBuilding(id: model.selectedCard.orderD.pickUpBulding)), \nfloor \(model.selectedCard.orderD.pickUpFloor),  \(model.selectedCard.orderD.pickUpRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:200), alignment: .leading)
                            }
                            
                        }
                        //drop off
                        ZStack{
                            RoundedRectangle(cornerRadius: 15).padding().frame(width: width(num:350), height: hieght(num:160)).foregroundColor(.white).shadow(radius: 1)
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 3")).offset(x: width(num:-125))
                            HStack{
                                
                                Text("Building \(self.getBuilding(id: model.selectedCard.orderD.dropOffBulding)), \nfloor \(model.selectedCard.orderD.dropOffFloor),  \(model.selectedCard.orderD.dropOffRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:200), alignment: .leading)
                            }
                            
                        }
                        //order items
                        ZStack{
                           
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).offset(x: width(num:-125))
                            HStack() {
                                
                                Text("\(model.selectedCard.orderD.orderDetails)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:220), alignment: .leading)
                            }
                        }.contentShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: width(num:325))
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 1)
                      
                       
                        //make an offer button
                        Button(action: {
                            showingPaymentAlert.toggle()
                        }) {
                            Text("Cancel order")
                                .font(.custom("Roboto Bold", size: fontSize(num:22)))
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
                }.position(x: width(num:188),y: hieght(num:700))
            }
  
       }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).alert(isPresented: $showingPaymentAlert) {Alert(title: Text("Order confirmed"), message: Text("Are you sure you want cancel this order"), primaryButton: .default((Text("YES")), action: {
                    notificationT =  .CancelOffer
                    canelOrder()
                    model.notificationMSG = true
                    model.showCard = false
                    model.showContent = false
                   }) , secondaryButton: .cancel((Text("NO"))))

        }
        
    }// end body
    
    func canelOrder(){
        
        model.cancelCardOrderId = model.selectedCard.orderD.id
        model.order.cancelOffer(CourierID: model.selectedCard.orderD.courierId, OrderId: model.selectedCard.orderD.id, MemberID: model.selectedCard.orderD.memberId, Price: model.selectedCard.orderD.deliveryPrice)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //withAnimation(.easeIn){
            model.getCards()
            //}//end with animation
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
