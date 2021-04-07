//
//  HomeMemberView.swift
//  FastWay
//
//  Created by Ghaida . on 21/06/1442 AH.
//

import SwiftUI

struct HomeMemberView: View {
    
    
    @StateObject var viewRouter: ViewRouter
    let abuotPage: Page = .AboutUs
    @State var show = false
    @State var imgName = "Tick"
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()
    var body: some View {
        ZStack{
            //Background
            ZStack{
                
                //background
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 49"))
                    .resizable() //add resizable
                    .frame(width: width(num: 375)) //addframe
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .offset(y:hieght(num: -100))
                
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                    .resizable() //add resizable
                    .frame(width: width(num: 375)) //addframe
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: hieght(num:50))
                
                Image("FASTWAY1")
                    .resizable()
                    .frame(width: width(num: UIImage(named: "FASTWAY1")!.size.width ), height: hieght(num: UIImage(named: "FASTWAY1")!.size.height))
                    .offset(x:width(num:180) ,y:hieght(num:130))
                    .position(x: width(num:10), y: hieght(num:-45))
            }.edgesIgnoringSafeArea(.all)
            .onAppear(){
                checkOrders(ID:  UserDefaults.standard.getUderId())
            }
            //zstack
            //main page
            VStack{
                //AddNewOrder Button
                Button(action: {
                    notificationT = .None
                    viewRouter.currentPage = .AddNewOrder
                }) {
                    //logo, text feilds and buttons
                    Image("addNewOrder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width(num:300), height: hieght(num:180))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .clipped().shadow(radius: 2)
                }
                //CurrentOrder Button
                Button(action: {
                    notificationT = .None
                    viewRouter.currentPage = .CurrentOrder
                    
                }) {
                    Image("current")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width(num:300), height: hieght(num:180))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .clipped().shadow(radius: 2)
                    
                }
                //HistoryView Button
                Button(action: {
                    notificationT = .None
                    viewRouter.currentPage = .HistoryView
                    
                }) {
                    Image("History")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width(num:300), height: hieght(num:180))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .clipped().shadow(radius: 2)
                    
                    }

            }.position(x:width(num:189) ,y:hieght(num:370))
            //notification
            VStack{
                if show{
                    Notifications(type: notificationT, imageName: self.imgName)
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }   
            }.onAppear(){
                if notificationT == .LogIn || notificationT == .SignUp {
                    self.imgName = "Tick"
                    animateAndDelayWithSeconds(0.05) { self.show = true }
                    animateAndDelayWithSeconds(4) {
                        self.show = false
                        notificationT = .None
                    }
                }else{
                    if notificationT == .CancelByDefault{
                        animateAndDelayWithSeconds(0.05) {
                            self.imgName = "cancelTick"
                            self.show = true }
                        animateAndDelayWithSeconds(4) {
                            self.show = false
                            notificationT = .None
                        }
                    }
                }
            }
            // canceled order after 15 min
            /*VStack{
                if show{
                    Notifications(type: notificationT, imageName: "shoppingCart")
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
            }.onAppear(){
                if notificationT == .CancelByDefault  {
                    animateAndDelayWithSeconds(0.05) { self.show = true }
                    animateAndDelayWithSeconds(4) {
                        self.show = false
                        notificationT = .None
                    }
                }
            }*/
            
            //BarMenue
            ZStack{
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        Spacer()
                        HStack {
                            //Home
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .HomePageM,width: width(num:geometry.size.width/5), height: hieght(num:geometry.size.height/28), systemIconName: "homekit", tabName: "Home")
                           //about us
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: width(num:geometry.size.width/7), height: hieght(num:geometry.size.width/7))
                                    .shadow(radius: 4)
                                VStack {
                                    Image(uiImage:  #imageLiteral(resourceName: "FastWay")) //logo
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: width(num:geometry.size.width/7-6 ), height: hieght(num:geometry.size.width/7-6))
                                }.padding(.horizontal, width(num:14))
                                .onTapGesture {
                                    notificationT = .None
                                    viewRouter.currentPage = abuotPage
                                }.foregroundColor(viewRouter.currentPage == abuotPage ? Color("TabBarHighlight") : .gray)
                            }.offset(y:hieght(num: -geometry.size.height/8/2))
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .ViewProfileM ,width: width(num:geometry.size.width/5), height: hieght(num:geometry.size.height/28), systemIconName: "person.crop.circle", tabName: "Profile") //change assigned page
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        //.frame(width: width(num:geometry.size.width), height: hieght(num:geometry.size.height/8))
                        .background(Color("TabBarBackground").shadow(radius: 2))
                    }
                    // }
                    
                }
            }.edgesIgnoringSafeArea(.all)//zstack
        }.onAppear(){
            //for the in app notification
            //call it before get notification
            /*UNUserNotificationCenter.current().delegate = delegate
           getNotificationMember(memberId: UserDefaults.standard.getUderId()){ success in
                print("after calling method get notification")
                guard success else { return }
            }*/
            
        }
    
    }
    
}


struct HomeMemberView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeMemberView(viewRouter: ViewRouter())
        }
    }
}
