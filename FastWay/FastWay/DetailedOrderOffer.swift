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
    //@Binding var order : OrderDetails
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var model: CarouselViewModel
    @State var cardView = false
    //var animation: Namespace.ID
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var source : CLLocationCoordinate2D!
    @State var destination : CLLocationCoordinate2D!
    @State var expandOffer = false
    @State var expand = false
    @State var offer = 0
    @State var offerList : String = ""
    
    var body: some View{
        
        ZStack{
            
          //  VStack(spacing: 0){
                MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$source, destination: self.$destination)
                    .onAppear {
                        
                        self.manager.requestAlwaysAuthorization()
                    }
           // }//end of map vStack
            ZStack {
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).edgesIgnoringSafeArea(.bottom).offset(y: 240).shadow(radius: 2)
                
                VStack{
                    
                    ScrollView{
                        //pick up
                        ZStack{
                            RoundedRectangle(cornerRadius: 15).padding().frame(width: /*@START_MENU_TOKEN@*/350.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/).foregroundColor(.white).shadow(radius: 1)
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 1")).offset(x: -125)
                            HStack {
                                
                                Text("Building 6, \nfloor 0, office 13").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 200)
                            }
                            
                        }
                        //drop off
                        ZStack{
                            RoundedRectangle(cornerRadius: 15).padding().frame(width: /*@START_MENU_TOKEN@*/350.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/).foregroundColor(.white).shadow(radius: 1)
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 3")).offset(x: -125)
                            HStack {
                                
                                Text("Building 5, \nfloor 0, office 13").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 200)
                            }
                            
                        }
                    //order items
                    ZStack{
                        RoundedRectangle(cornerRadius: 15).padding().frame(width: /*@START_MENU_TOKEN@*/350.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/150.0/*@END_MENU_TOKEN@*/).foregroundColor(.white).shadow(radius: 1)
                        Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).offset(x: -125)
                        HStack() {
                           
                            Text("Print a paper and deliver it to the office").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 220)
                        }
                    }
                    //Offer price
                    VStack(spacing: 0){
                 
                        HStack() {
                            Text("Offer")
                                .font(.custom("Roboto Medium", size: 18))
                                .fontWeight(.bold).multilineTextAlignment(.leading)
                                .frame(width: 268, height: 6)
                            Image(systemName: expand ? "chevron.up" : "chevron.down")
                                .resizable()
                                .frame(width: 13, height: 6)
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
                        //Call DB
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
                
                
                
                //BarMenue
                ZStack{
                    GeometryReader { geometry in
                        VStack {
                            Spacer()
                            Spacer()
                            Spacer()
                            HStack {
                                //Home icon
                                TabBarIcon(viewRouter: viewRouter, assignedPage: .HomePageC,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
                                ZStack {
                                    //about us icon
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                                        .shadow(radius: 4)
                                    VStack {
                                        Image(uiImage:  #imageLiteral(resourceName: "FastWay")) //logo
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geometry.size.width/7-6 , height: geometry.size.width/7-6)
                                    }.padding(.horizontal, 14).onTapGesture {
                                        viewRouter.currentPage = .AboutUs
                                        //model.showContent = false
                                    }.foregroundColor(viewRouter.currentPage == .AboutUs ? Color("TabBarHighlight") : .gray)
                                }.offset(y: -geometry.size.height/8/2)
                                //Profile icon
                                TabBarIcon(viewRouter: viewRouter, assignedPage: .ViewProfileC ,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Profile") //change assigned page
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height/8)
                            .background(Color("TabBarBackground").shadow(radius: 2))
                        }
                    }
                }.edgesIgnoringSafeArea(.all)//zstack
            }
            
            
            
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
    
}

/*struct DetailedOrderOffer_Previews: PreviewProvider {
    static var previews: some View {
       // DetailedOrderOffer(viewRouter: ViewRouter())
    }
}*/
