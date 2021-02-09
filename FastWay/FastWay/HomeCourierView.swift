//
//  HomeCourierView.swift
//  FastWay
//
//  Created by Ghaida . on 21/06/1442 AH.
//

import SwiftUI

struct HomeCourierView: View {
    
    
    @StateObject var viewRouter: ViewRouter

    var body: some View {
        
        ZStack{
         
            //BackGround
            ZStack{
                
                //background
              Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
              Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 25)
                
            }
            
            //inside the page
            VStack{
                    
                    //add new Order
                    Button(action: {
                    viewRouter.currentPage = .DeliverOrder
                    }) {
                    //logo, text feilds and buttons
                    Image("addNewOrder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 180)
                        .clipped()
                    }
                    
                    //current
                    Button(action: {
                    viewRouter.currentPage = .CurrentOrder
                        
                    }) {
                    Image("current")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 180)
                        .clipped()
                    
                    }
                
                    //History
                    Button(action: {
                    viewRouter.currentPage = .HistoryView
                        
                    }) {
                    
                    Image("HistoryCourier")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 180)
                        .clipped()
                    
                    }
                            
                                
                                
            }.position(x:189 ,y:370)//end VStack

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
