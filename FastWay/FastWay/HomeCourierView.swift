//
//  HomeCourierView.swift
//  FastWay
//
//  Created by Ghaida . on 21/06/1442 AH.
//

import SwiftUI

struct HomeCourierView: View {
    
    
    @StateObject var viewRouter: ViewRouter
    @State var show = false
    var body: some View {
        
        ZStack{
            
            //BackGround
            ZStack{
                
                //background
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 25)
                Image("FASTWAY1").frame(width: -50, height: -50)
                    .offset(x:180 ,y:130).position(x: 10, y: -60)
                
            }
            
            //inside the page
            VStack{
                
                //add new Order
                Button(action: {
                    notificationT = .None
                    viewRouter.currentPage = .DeliverOrder
                }) {
                    //logo, text feilds and buttons
                    Image("DeliverNew")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .clipped().shadow(radius: 2)
                }
                
                //current
                Button(action: {
                    notificationT = .None
                    viewRouter.currentPage = .CurrentOrderCourier
                    
                }) {
                    Image("current")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .clipped().shadow(radius: 2)
                    
                }
                
                //History
                Button(action: {
                    notificationT = .None
                    viewRouter.currentPage = .HistoryCourierView
                    
                }) {
                    
                    Image("HistoryCourier")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .clipped().shadow(radius: 2)
                    
                }
                
                
                
            }.position(x:189 ,y:370)//end VStack
            
            //notification here
            VStack{
                if show{
                    Notifications(type: notificationT, imageName: "tick")
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
                
                
                
                
            }.onAppear(){
                if notificationT == .LogIn || notificationT == .SignUp {
                    animateAndDelayWithSeconds(0.05) { self.show = true }
                    animateAndDelayWithSeconds(4) { self.show = false }
                }
            }
            //bar menue
            ZStack{
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        
                        Spacer()
                        HStack {
                            //Home
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .HomePageC,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
                            
                            //AboutUs
                            ZStack {
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
                                    notificationT = .None
                                    viewRouter.currentPage = .AboutUs
                                }.foregroundColor(viewRouter.currentPage == .AboutUs ? Color("TabBarHighlight") : .gray)
                            }.offset(y: -geometry.size.height/8/2)
                            
                            //Profile
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .ViewProfileC ,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Profile") //change assigned page
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBackground").shadow(radius: 2))
                    }
                }
            }.edgesIgnoringSafeArea(.all)//zstack bar menu
            
            
        }//end ZStack
        
    }//body
    
}//end HomeCourierView


struct HomeCourierView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeCourierView(viewRouter: ViewRouter())
        }
    }
}
