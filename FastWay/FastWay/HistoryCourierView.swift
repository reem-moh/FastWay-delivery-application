//
//  HistoryView.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.
//

import SwiftUI

struct HistoryCourierView: View {
    
    @StateObject var viewRouter: ViewRouter
    let abuotPage: Page = .AboutUs
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()
    
    var body: some View {
        
        ZStack{
            
            //background
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 49"))
                .resizable() //add resizable
                .frame(width: width(num: 375)) //addframe
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:hieght(num: -100))
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                .resizable() //add resizable
                .frame(width: width(num: 375)) //addframe
                .offset(y: hieght(num: 30))
            GeometryReader { geometry in
                // if UserDefaults.standard.getUderType() == "M"{
                VStack {
                    Spacer()
                    Text("Hello,History Courier View!")
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
                            }.padding(.horizontal, width(num: 14)).onTapGesture {
                                notificationT = .None
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
        .onAppear(){
            //for the in app notification
            //call it before get notification
            UNUserNotificationCenter.current().delegate = delegate
            getNotificationCourier(courierId: UserDefaults.standard.getUderId()){ success in
                print("after calling method get notification")
                guard success else { return }
            }
        }
    }}

struct HistoryCourierView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCourierView(viewRouter: ViewRouter())
    }
}
