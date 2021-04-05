//
//  HistoryView.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.


import SwiftUI
import MapKit

struct HistoryCourierView: View {
    
    /*
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var model: HistoryCarouselCViewModel
   // @StateObject var courierOrderModel = CarouselViewModel()
    @Namespace var animation
    //for notification
    @State var show = false
    @State var imgName = "shoppingCart"
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
                    //CurrentOrderView
                    Text("Current Orders").font(.custom("Roboto Medium", size: fontSize(num:25))).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .multilineTextAlignment(.center).position(x:width(num:170) ,y:hieght(num:50)).offset(x:width(num:20),y:hieght(num:20))
                    //white rectangle
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                        .resizable() //add resizable
                        .frame(width: width(num: 375)) //addframe
                        .edgesIgnoringSafeArea(.bottom).offset(y: hieght(num:100))
                    
                }.edgesIgnoringSafeArea(.all)
                
            }.onAppear(){
                //retrieve ordered assigned to the user
                model.order.getCourierOrderAssign(Id: UserDefaults.standard.getUderId())
                //retrieve order waiting for accept
                model.order.getAllOffersFromCourierInCurrentOrder(){ success in
                    print("inside Delivery order view success ")
                    //if success false return
                    guard success else { return }
                    model.getCards()
                }
                //model.getCards()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    //withAnimation(.easeIn){
                    model.getCards()
                    //}//end with animation
                }
                model.showCard = false
                model.showContent = false
                model.showChat = false
            }
            
            //Notification
            VStack{
                
                if show{
                    Notifications(type: notificationT, imageName: self.imgName)
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
            }
          

            // Carousel...
            
            VStack{
                Spacer()
                if model.cards.count == 0 {
                    Text("you do not have any current order yet")
                }else{
                ZStack{
                    GeometryReader{ geometry in
                        HStack {
                            ScrollView {
                                
                                ForEach(model.cards.lazy.indices.reversed(),id: \.self) { index in
                                    HStack{
                                        if(index < model.cards.count){
                                            HistoryCardCView(card: model.cards[index], animation: animation)
                                        Spacer(minLength: 0)
                                        }
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
            
            //Press details
            if model.showCard && model.assigned == false{
                CurrentCardCDetailes(viewRouter: viewRouter, animation: animation)
            }else{
                if model.showCard && model.assigned == true{
                    //change to the assigned order view
                    CurrentCardCDetailesNeworder(viewRouter: viewRouter, animation: animation)
                }
            }
                        
            //notification
            VStack{
                if show{
                    Notifications(type: notificationT, imageName: self.imgName)
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
            }.onAppear(){
                if notificationT == .SendOffer || notificationT == .CancelOffer {
                    animateAndDelayWithSeconds(0.05) { self.show = true }
                    animateAndDelayWithSeconds(4) { self.show = false }
                }
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
                            //about us icon
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
                            //profile icon
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
            
           

            //notification here
            VStack{
                if show{
                    Notifications(type: notificationT, imageName: self.imgName)
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
                
                
                
                
            }.onAppear(){
                if notificationT == .SendOffer  {
                    animateAndDelayWithSeconds(0.05) { self.show = true }
                    animateAndDelayWithSeconds(4) { self.show = false }
                }
                if notificationT == .CancelOffer  {
                    animateAndDelayWithSeconds(0.05) { self.show = true }
                    animateAndDelayWithSeconds(4) { self.show = false }
                }

            }

            
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
    } */
  
    
    
        
        @StateObject var viewRouter: ViewRouter
        let abuotPage: Page = .AboutUs
        //for the in app notification
        @StateObject var delegate = NotificationDelegate()
        
        var body: some View {
            
            ZStack{
                ZStack{
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 49"))
                        .resizable() //add resizable
                        .frame(width: width(num: 375)) //addframe
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y: hieght(num: -100))
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                        .resizable() //add resizable
                        .frame(width: width(num: 375)) //addframe
                        .offset(y: hieght(num: 30))
                }.onAppear(){
                    checkOrders(ID:  UserDefaults.standard.getUderId())
                }
                //background
               
                GeometryReader { geometry in
                    // if UserDefaults.standard.getUderType() == "M"{
                    VStack {
                        Spacer()
                        Text("Hello,History View!")
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
                /*UNUserNotificationCenter.current().delegate = delegate
               getNotificationMember(memberId: UserDefaults.standard.getUderId()){ success in
                    print("after calling method get notification")
                    guard success else { return }
                }*/
            }
        }
    
    
    
}
    



/*
//Current card c View
struct HistoryCardCView: View {
    @EnvironmentObject var model : HistoryCarouselCViewModel
    var card: currentCardC
    var animation: Namespace.ID
    //@State var StateACCEPT = false
    @State var StateWaiting = true
    @State var stat = ""
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()
    
    var body: some View {
        
        //Card
        VStack{
            //Time
            HStack{
                Image(systemName: "clock")
                    .foregroundColor(Color.black.opacity(0.5))
                    .padding(.leading)
                Text("\(model.orderPreview(c: card).createdAt.calenderTimeSinceNow())")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.black.opacity(0.5))
                    .animation(.easeIn)
                Spacer(minLength: 0)
                Spacer(minLength: 0)
                Spacer(minLength: 0)

            //price
                Image(uiImage: #imageLiteral(resourceName: "money"))
                    .foregroundColor(Color.black.opacity(0.5))
                    .padding(.leading)
                    
                Text("\(model.orderPreview(c: card).deliveryPrice) SR")
                    
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.black.opacity(0.5))
                    .animation(.easeIn)
                
                
                Spacer(minLength: 0)
            }.padding(.top,15)
            
            //orderDetailes
            HStack {
                Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).padding(.leading)
                Text("\(model.orderPreview(c: card).orderDetails)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black.opacity(0.5))
                    .frame(maxWidth: width(num:220), maxHeight: hieght(num:50), alignment: .leading)
                    .animation(.easeIn) //if the user press it. It shows detailes
                Spacer(minLength: 0)
                
            }.padding(.top,15)
            //location Detailes
            VStack {
                
                Image(uiImage: #imageLiteral(resourceName: "IMG_0526 1"))
                    .animation(.easeIn)
                HStack {
                    Text("Building \(model.orderPreview(c: card).pickUpBulding)\t\t\t\t\t Building \(model.orderPreview(c: card).dropOffBulding)")
                        .fontWeight(.light)
                        .foregroundColor(Color.black.opacity(0.5))
                        .animation(.easeIn) //if the user press it it show Detail
                }.padding(5)
                
            }.padding(15)
            //Details Button
            HStack{
                //to let an arrow in the right of the card
                Spacer(minLength: 0)
                if !model.showContent{
                    //have an offer
                    if self.stat == "have an offer"{
                        Text("Waiting for accept")
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: width(num:170),height: hieght(num:25))
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("ButtonColor")))
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                      
                    }else
                
    
                    if self.stat == "assigned"
                    {
                        Text("assigned")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: width(num:100),height: hieght(num:25))
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.green))
                            //.background(Color.purple)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)

                        
                    }else{
                        
                        Text("Details")
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)

                        
                    }
                    
                    Image(systemName: "arrow.right")
                }
            }
            .foregroundColor(Color.gray.opacity(0.9))
            .padding(20)
            .onAppear(){
                model.getCards()
                self.stat = model.orderPreview(c: card).status
            }
            .onChange(of: model.orderPreview(c: card).status) { value in
                model.getCards()
                self.stat = value
                
            }
        }//end vStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            card.cardColor
                .cornerRadius(25)
                .matchedGeometryEffect(id: "bgColor-\(card.id)", in: animation)
        )
        .onTapGesture {
            withAnimation(.spring()){
                model.selectedCard = card
                model.assigned = model.selectedCard.orderD.isAdded
                model.showCard.toggle() //change the value of showCard to true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.easeIn){
                        model.showContent = true
                    }//end with animation
                }//end dispatch
            }//end with animation
        }//end on tap gesture
    }
}


//HistoryCarouselCViewModel
class HistoryCarouselCViewModel: ObservableObject {
    
    //Add obs obje from type member?
    @ObservedObject var order = Order()
    
    //each order has card
    @Published var cards: [currentCardC] = []
    
    // Detail Content....
    @Published var selectedCard = currentCardC(cardColor: .clear)
    //user press details
    @Published var showCard = false
    @Published var showContent = false
    
    @Published var cancelCardOrderId : String = ""
    @Published var notificationMSG =  false
    @Published var assigned = false
    //Toggle to show chat
    @Published var showChat = false
    
    
    
    //return order details
    func orderPreview(c: currentCardC) -> OrderDetails {
        return c.orderD
    }
    
    func getCards(){//update CourierOrderOffered
        print("number of cards inside get couerier Cards: \(order.CourierOrderOfferedAssign.count + order.CourierOrderOfferedWaiting.count)")
        
        if order.CourierOrderOfferedAssign.isEmpty{
            print("there is no order in Assign")
        }
        if order.CourierOrderOfferedWaiting.isEmpty{
            print("there is no order in waiting")
        }
        
        cards.removeAll()
        print("number of cards after remove the cards:\(cards.count)")
        for index in order.CourierOrderOfferedWaiting {
            print("index in loop waiting \(index.orderDetails)")
            if ( index.id != "") {
                cards.append(contentsOf: [ currentCardC( cardColor: Color(.white),state : 0, orderD : index )])
            }
        }
        
        for index in order.CourierOrderOfferedAssign {
            print("index in loop assign \(index.orderDetails)")
            if index.status != "cancled" && index.status != "completed" && index.id != cancelCardOrderId{
                cards.append(contentsOf: [ currentCardC( cardColor: Color(.white),state : 0, orderD : index )])
            }
            
        }
        cards.sort {
            $0.orderD.createdAt < $1.orderD.createdAt
        }
        
    }
    
    //cancel order
    func cancelOrder(Id: String){
           cancelCardOrderId = Id
            order.cancelOrder(OrderId: Id)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                //withAnimation(.easeIn){
                self.getCards()
                //self.showCancel.toggle()
                //animateAndDelayWithSeconds(0.05) { self.showCancel = true }
                //animateAndDelayWithSeconds(4) {self.showCancel = false }
                //}//end with animation
            }
    }
}


*/

struct HistoryCourierView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCourierView(viewRouter: ViewRouter())
    }
}
