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
    @EnvironmentObject var model: CarouselViewModel
    @StateObject var viewRouter: ViewRouter
    var animation: Namespace.ID
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var expandOffer = false
    @State var expand = false
    @State var offer = 0
    @State var offerList : String = "Offer"
    @State var checkOffer : Bool = false
    
    var body: some View{
        
        ZStack{
                                   
            //map
            MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$model.selectedCard.orderD.pickUP, destination: self.$model.selectedCard.orderD.dropOff)
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
                            //pick up
                            ZStack{
                                RoundedRectangle(cornerRadius: 15).padding().frame(width: /*@START_MENU_TOKEN@*/350.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/).foregroundColor(.white).shadow(radius: 1)
                                Image(uiImage: #imageLiteral(resourceName: "IMG_0528 1")).offset(x: -125)
                                HStack {
                                    
                                    Text("Building \(model.selectedCard.orderD.pickUpBulding), \nfloor \(model.selectedCard.orderD.pickUpFloor),  \(model.selectedCard.orderD.pickUpRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 200)
                                }
                                
                            }
                            //drop off
                            ZStack{
                                RoundedRectangle(cornerRadius: 15).padding().frame(width: /*@START_MENU_TOKEN@*/350.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/).foregroundColor(.white).shadow(radius: 1)
                                Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 3")).offset(x: -125)
                                HStack {
                                    
                                    Text("Building \(model.selectedCard.orderD.dropOffBulding), \nfloor \(model.selectedCard.orderD.dropOffFloor),  \(model.selectedCard.orderD.dropOffRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 200)
                                }
                                
                            }
                        //order items
                        ZStack{
                            RoundedRectangle(cornerRadius: 15).padding().frame(width: /*@START_MENU_TOKEN@*/350.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/150.0/*@END_MENU_TOKEN@*/).foregroundColor(.white).shadow(radius: 1)
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).offset(x: -125)
                            HStack() {
                               
                                Text("\(model.selectedCard.orderD.orderDetails)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 220)
                            }
                        }
                        //Offer price
                            if(checkOffer) {
                                Text("You must add price").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)))
                                        .offset(x: -5)
                                
                            }
                        VStack(spacing: 0){
                     
                            HStack() {
                                Text("\(offerList)")
                                    .font(.custom("Roboto Medium", size: 18))
                                    .fontWeight(.bold).multilineTextAlignment(.leading)
                                    .frame(width: 268, height: 6)
                                Image(systemName: expand ? "chevron.up" : "chevron.down")
                                    .resizable()
                                    .frame(width: 13, height: 6)
                                    .foregroundColor(.white)
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
                                                offerList="\(i) SAR"
                                            })
                                            {
                                                Text("\(i) SAR").padding(5)
                                            }
                                            .foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                            .frame(width: 297, height: 30)
                                            
                                        }//end for each
                                    }.frame(width: 300, height: 70)//end scroll view
                                }.offset(x: -15, y: 10.0)//end group
                            }//end if statment
                        
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color(.gray), lineWidth: 1))
                        .colorMultiply(.init(#colorLiteral(red: 0.9654662013, green: 0.9606762528, blue: 0.9605932832, alpha: 1)))
                        
                        //make an offer button
                        Button(action: {
                            makeAnOffer()
                        }) {
                            Text("Make an Offer")
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
            
         
            
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
    func estimateTime(){
        
    }
    func makeAnOffer(){
        checkOffer=false
        if( offerList == "Offer"){
            checkOffer=true
        }else{
            viewRouter.currentPage = .HomePageC
        }
    }
    func getBuilding(id: Int) -> String {
        switch id {
        case 5:
            return "no.5 College Of Sciences"
        case 6:
            return "no.6 College Of Computer and Information Sciences"
        case 8:
            return "no.8 College Of Pharmacy"
        case 9:
            return "no.9 College Of Medicine"
        case 10:
            return "no.10 College Of Dentistry"
        case 11:
            return "no.11 College Of Applied Medical Science"
        case 12:
            return "no.12 College Of Education"
        case 13:
            return "no.13 College Of Arts"
        case 14:
            return "no.14 College Of Languages And Translation"
        case 15:
            return "no.15 College Of Business Administration"
        case 16:
            return "no.16 College of Sports Sciences and Physical Activity"
        case 17:
            return "no.17 College of Law and Political Sciences"
        default:
            return ""
        }
    }
    
}

/*struct DetailedOrderOffer_Previews: PreviewProvider {
    static var previews: some View {
        DetailedOrderOffer(viewRouter: ViewRouter(), animation: Namespace)
    }
}*/
