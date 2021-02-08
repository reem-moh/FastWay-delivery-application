//
//  HomeCourierView.swift
//  FastWay
//
//  Created by Ghaida . on 21/06/1442 AH.
//

import SwiftUI

struct HomeCourierView: View {
    
    
    @StateObject var viewRouter: ViewRouter
    let abuotPage: Page = .AboutUs

    var body: some View {
        ZStack{
         
            
            
            
            ZStack{
                
                //background
              Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
              Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 25)
                
                GeometryReader { geometry in
                   // if UserDefaults.standard.getUderType() == "M"{
                    
                    
                    Image("FASTWAY 1").frame(width: -50, height: -50)
                        .offset(x:180 ,y:130).position(x: 10, y: -45)
                               
                                 
                                
                        VStack {
                            
                            Spacer()
                            
                              
                                  
                            Spacer()
                           HStack {
                               TabBarIcon(viewRouter: viewRouter, assignedPage: .HomePageC,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
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
                                                    viewRouter.currentPage = abuotPage
                                                }.foregroundColor(viewRouter.currentPage == abuotPage ? Color("TabBarHighlight") : .gray)
                                }.offset(y: -geometry.size.height/8/2)
                               TabBarIcon(viewRouter: viewRouter, assignedPage: .ViewProfileC ,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Profile") //change assigned page
                            }
                                .frame(width: geometry.size.width, height: geometry.size.height/8)
                                .background(Color("TabBarBackground").shadow(radius: 2))
                        }
                   // }
                    
                 }
                
            }.edgesIgnoringSafeArea(.all)//zstack
            
                
                VStack{
                  /*      transparent-log-out-icon-5d6b36311cbea9 2

                   */

                                  
                                 Button(action: {
                                  viewRouter.currentPage = .AddNewOrder
                                 }) {
                                  
                                  //logo, text feilds and buttons
                                  Image("addNewOrder")
                                      .resizable()
                                      .aspectRatio(contentMode: .fill)
                                      .frame(width: 300, height: 180)
                                      .clipped()
                                 }
                              
                                  
                                  
                                  
                                  
                                  
                                 Button(action: {
                                  viewRouter.currentPage = .CurrentOrder
                                     
                                 }) {
                                   Image("current")
                                       .resizable()
                                       .aspectRatio(contentMode: .fill)
                                       .frame(width: 300, height: 180)
                                       .clipped()
                                   
                                 }
                                  
                                  
                                  
                                  
                                 Button(action: {
                                  viewRouter.currentPage = .HistoryView
                                     
                                 }) {
                                   
                                   Image("History")
                                       .resizable()
                                       .aspectRatio(contentMode: .fill)
                                       .frame(width: 300, height: 180)
                                       .clipped()
                                   
                                 }
                                
                                  
                                  
                               }.position(x:189 ,y:370)

                
                
                
                
                
            }
            
        
        
    }
    
}


struct HomeCourierView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeCourierView(viewRouter: ViewRouter())
        }
    }
}
