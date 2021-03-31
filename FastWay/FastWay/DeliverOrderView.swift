//
//  DeliverOrderView.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.
//

// Home
import SwiftUI

struct DeliverOrderView: View{
    
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var model: CarouselViewModel
    @Namespace var animation
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()
    
    var body: some View {
        
        ZStack {
            //Background
            HStack{
                GeometryReader{ geometry in
                    //background
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 49"))
                        .resizable() //add resizable
                        .frame(width: width(num: 375)) //addframe
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:hieght(num:-100))
                    //DeliverOrderView
                    Text("Available Orders").font(.custom("Roboto Medium", size:fontSize(num:25))).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .multilineTextAlignment(.center).position(x:width(num:170) ,y:hieght(num:50)).offset(x:width(num:20),y:hieght(num:20))
                    //white rectangle
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                        .resizable() //add resizable
                        .frame(width: width(num: 375)) //addframe
                        .edgesIgnoringSafeArea(.bottom).offset(y: hieght(num:100))
                    
                }.edgesIgnoringSafeArea(.all)
                
            }.onAppear(){
                //cancel order when its exceeds 15 minutes without offers
                checkOrdersForCourier()
                //retrieve all waiting for offer orders [from collection order]
                model.order.getOrderWaitingForOffer()
                //retrieve all orders have an offer [from collection order]
                model.order.getOrder()
                //get all order id that the courier has offer in order [from collection offer]
                model.order.getAllOffersFromCourier(){ success in
                    print("inside DeliverOrderView ")
                    //if success false return
                    guard success else { return }
                    model.getCards()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    //withAnimation(.easeIn){
                    model.getCards()
                    //}//end with animation
                }
                model.showCard = false
                model.showContent = false
            }
            
            VStack{
                // Carousel....
                Spacer()
                if model.cards.count == 0 {
                    Text("There is no order yet, wait for new orders")
                }else{
                    ZStack{
                        GeometryReader{ geometry in
                            HStack {
                                ScrollView {
                                    
                                    ForEach(model.cards.lazy.indices.reversed(),id: \.self) { index in
                                        HStack{
                                            CardView(card: model.cards[index], animation: animation)
                                            Spacer(minLength: 0)
                                        }//.frame(height: 100)
                                        .padding(.horizontal)
                                        .contentShape(Rectangle())
                                        .gesture(DragGesture(minimumDistance: 20))
                                        .padding(.vertical, 5)
                                        .shadow(radius: 1)
                                        
                                        
                                    }.padding(.bottom,25)//end of for each
                                    
                                    
                                }
                                
                            }
                        }
                    }.padding(.top,80)
                }
                Spacer()
            }.padding(.bottom,80)
            
            if model.showCard {
                DetailedOrderOffer(viewRouter: viewRouter, animation: animation)
            }
            
            //BarMenue
            ZStack{
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        Spacer()
                        Spacer()
                        HStack {
                            //Home icon
                            // TabBarIcon(viewRouter: viewRouter, assignedPage: .HomePageC,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
                            VStack {
                                Image(systemName: "homekit")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/5, height: geometry.size.height/28)
                                    .padding(.top, 10)
                                Text("Home")
                                    .font(.footnote)
                                Spacer()
                            }.padding(.horizontal, 14).onTapGesture {
                                withAnimation(.spring()){
                                    model.showCard.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn){
                                            model.showContent = false
                                            
                                        }
                                    }
                                    
                                }
                                notificationT = .None
                                viewRouter.currentPage = .HomePageC
                            }.foregroundColor(viewRouter.currentPage == .HomePageC ? Color("TabBarHighlight") : .gray)
                            
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
                                    withAnimation(.spring()){
                                        model.showCard.toggle()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            withAnimation(.easeIn){
                                                model.showContent = false
                                                
                                            }
                                        }
                                        
                                    }
                                    notificationT = .None
                                    viewRouter.currentPage = .AboutUs
                                    
                                }.foregroundColor(viewRouter.currentPage == .AboutUs ? Color("TabBarHighlight") : .gray)
                            }.offset(y: -geometry.size.height/8/2)
                            
                            //Profile icon
                            // TabBarIcon(viewRouter: viewRouter, assignedPage: .ViewProfileC ,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Profile")//change assigned page
                            
                            VStack {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/5, height: geometry.size.height/28)
                                    .padding(.top, 10)
                                Text("Profile")
                                    .font(.footnote)
                                Spacer()
                            }.padding(.horizontal, 14).onTapGesture {
                                withAnimation(.spring()){
                                    model.showCard.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn){
                                            model.showContent = false
                                            
                                        }
                                    }
                                    
                                }
                                notificationT = .None
                                viewRouter.currentPage = .ViewProfileC
                            }.foregroundColor(viewRouter.currentPage == .ViewProfileC ? Color("TabBarHighlight") : .gray)
                            
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBackground").shadow(radius: 2))
                        
                    }
                }
            }.edgesIgnoringSafeArea(.all)//zstack
            
        }//end ZStack
        .onAppear(){
            //for the in app notification
            //call it before get notification
            /*UNUserNotificationCenter.current().delegate = delegate
            getNotificationCourier(courierId: UserDefaults.standard.getUderId()){ success in
                print("after calling method get notification")
                guard success else { return }
            }*/
        }
    }//end Body
    
}

//don't show the order who exceed 15 minutes without offers
func checkOrdersForCourier(){
    if order.ordersCanceled.isEmpty{
        order.getOrderForCancel()
    }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
     
            for index in order.ordersCanceled {
                
                //convert time to double
                let timeInterval = -1*index.createdAt.timeIntervalSinceNow
                if( index.status != "cancled" && index.status != "completed" ){
                    //60 sec * 15 minutes
                    if timeInterval >= 900  && index.status == order.status[0]{
                        order.cancelOrder(OrderId: index.id)
                    }
                }
                
            }
        
        
      }
    
}

struct DeliverOrderView_Previews: PreviewProvider {
    static var previews: some View {
        DeliverOrderView(viewRouter: ViewRouter())
    }
}
