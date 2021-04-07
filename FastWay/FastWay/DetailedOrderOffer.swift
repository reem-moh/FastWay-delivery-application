//
//  DetailedOrderOffer.swift
//  FastWay
//
//  Created by taif.m on 2/16/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct DetailedOrderOffer: View {
    @ObservedObject var member = Member(id: "", name: "", email: "", phN: "")
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
    @State var checkCourierLocation : Bool = false
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()
    @State var token = ""

    var body: some View{
        
        ZStack{
            
            //map
            MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$model.selectedCard.orderD.pickUP, destination: self.$model.selectedCard.orderD.dropOff, distance: self.$distance, time: self.$time)
                .cornerRadius(35)
                .frame(width: width(num:390), height: hieght(num:300)).padding(.bottom, 0)
                .clipped().position(x: width(num:188),y:hieght(num: 100))
                .offset(y:hieght(num: 50))
                .onAppear {
                    
                    self.manager.requestAlwaysAuthorization()
                }
            
            // VStack{
            
            ZStack {
                //go back button
                //arrow_back image
                Group{
                    RoundedRectangle(cornerRadius: 10).frame(width: width(num:45), height: hieght(num:35)).foregroundColor(Color(.white))
                    
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
                            .frame(width: width(num:30), height: hieght(num:30))
                            .clipped()
                            .background(Color(.white))
                    }.padding(1.0)
                }.position(x: width(num:50), y:hieght(num: 50))
                .onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.member.getMemberToken(memberId: model.selectedCard.orderD.memberId){ success in
                            print("After getMemberToken in send \(self.member.member.token)")
                            self.token = self.member.member.token
                            guard success else { return }
                        }
                    }
                }
                
                
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
                                .offset(x: width(num:10), y:hieght(num: 10))
                                .padding(.leading)
                            Text("\(model.selectedCard.orderD.createdAt.calenderTimeSinceNow())")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color.black.opacity(0.5))
                                .animation(.easeIn)
                                .offset(x: width(num:10), y:hieght(num: 10))
                            Spacer(minLength: 0)
                            Spacer(minLength: 0)
                            Spacer(minLength: 0)
                            Spacer(minLength: 0)
                            Spacer(minLength: 0)
                            if (model.selectedCard.orderD.deliveryPrice != 0){
                            Image(uiImage: #imageLiteral(resourceName: "money"))
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
                                
                                Text("Building \(self.getBuilding(id: model.selectedCard.orderD.dropOffBulding)), \nfloor \(model.selectedCard.orderD.dropOffFloor),  \(model.selectedCard.orderD.dropOffRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 200, alignment: .leading)
                            }
                            
                        }
                        //order items
                        ZStack{
                          
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).offset(x: width(num:-125))
                            HStack() {
                                
                                Text("\(model.selectedCard.orderD.orderDetails)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 220, alignment: .leading)
                            }
                        }.contentShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width:width(num: 325))
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 1)
                        //Offer price
                        if(checkOffer) {
                            Text("*You must specify a price").font(.custom("Roboto Regular", size: fontSize(num:18))).foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)))
                                .offset(x: width(num:-50))
                            
                            
                        }
                        if(checkCourierLocation){
                            Text("*Your current location\'s out of the campus ").font(.custom("Roboto Regular", size: fontSize(num:18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 0)}
                        
                        VStack(spacing: 0){
                            
                            HStack() {
                                Text("\(offerList)")
                                    .font(.custom("Roboto Medium", size: fontSize(num:18)))
                                    .fontWeight(.bold).multilineTextAlignment(.leading)
                                    .frame(width:width(num: 268), height:hieght(num: 6))
                                Image(systemName: expand ? "chevron.up" : "chevron.down")
                                    .resizable()
                                    .frame(width:width(num: 13), height:hieght(num: 6))
                                    .foregroundColor(.gray)
                            }.onTapGesture {
                                self.expand.toggle()
                                self.expandOffer = false
                            }
                            if (expand && !expandOffer) {
                                Group {
                                    ScrollView {
                                        
                                        ForEach((1...20), id: \.self) { i in
                                            
                                            Button(action: {
                                                self.expand.toggle()
                                                offer = i
                                                offerList="\(i) SR"
                                            })
                                            {
                                                Text("\(i) SR").padding(5)
                                            }
                                            .foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                            .frame(width: width(num:297), height: hieght(num:30))
                                            
                                        }//end for each
                                    }.frame(width: width(num:300), height: hieght(num:70))//end scroll view
                                }.offset(x: width(num:-15), y: hieght(num:10.0))//end group
                            }//end if statment
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color(.gray), lineWidth: width(num:1)))
                        .colorMultiply(.init(#colorLiteral(red: 0.9654662013, green: 0.9606762528, blue: 0.9605932832, alpha: 1)))
                        
                        //make an offer button
                        Button(action: {
                            if(makeAnOffer()){
                                notificationT = .SendOffer
                                viewRouter.currentPage = .HomePageC
                                
                                order.addOffer(OrderId: model.selectedCard.orderD.id, memberID: model.selectedCard.orderD.memberId, price: offer , locationLatiude: map.userLocation.coordinate.latitude,locationLongitude:map.userLocation.coordinate.longitude )
                                
                                model.makeAnOffer = model.selectedCard.orderD.id
                                
                                //send notification to member
                                
                                print("Before sendMessageTouser \(self.token)")
                                //change token
                                sendMessageTouser(to: self.token, title: "New Offers", body: "The order \(model.selectedCard.orderD.orderDetails.suffix(20)).. has new offers")
                                
                            }
                       }) {
                            Text("Make an Offer")
                                .font(.custom("Roboto Bold", size: fontSize(num:22)))
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .multilineTextAlignment(.center)
                                .padding(1.0)
                                .frame(width: UIScreen.main.bounds.width - 50)
                                .textCase(.none)
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                        .padding(.top,hieght(num: 25))
                        .offset(x: 0)
                        .padding(.bottom,hieght(num: 450))
                        
                    }
                }.position(x: width(num:188),y: hieght(num:700))
            }
            // }
            
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
    
    func makeAnOffer() -> Bool{
        checkOffer=false //for error message
        checkCourierLocation = false
        
        if(!isInRegion(map: map, coordinate: map.userLocation.coordinate)){
            checkCourierLocation = true
            return false;
        }
        else
        if( offerList == "Offer price"){
            checkOffer=true
            return false;
        }
        return true;
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
