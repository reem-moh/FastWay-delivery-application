//
//  CurrentOrderView.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.
//

import SwiftUI
import MapKit

struct CurrentOrderView: View {
    
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var model: CurrentCarouselMViewModel
    @StateObject var OfferModel = OfferCarousel()
    @Namespace var animation
    //for notification
    @State var show = false
    
    
    
    var body: some View {
        
        ZStack {
            //Background
            HStack{
                GeometryReader{ geometry in
                    //background
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
                    //CurrentOrderView
                    Text("Current Orders").font(.custom("Roboto Medium", size: 25)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .multilineTextAlignment(.center).position(x:170 ,y:50).offset(x:20,y:20)
                    //white rectangle
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).edgesIgnoringSafeArea(.bottom).offset(y: 100)
                    
                }.edgesIgnoringSafeArea(.all)
                
            }.onAppear(){
                //calling Methods
                model.order.getMemberOrder(Id: UserDefaults.standard.getUderId())
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    //withAnimation(.easeIn){
                        model.getCards()
                    //}//end with animation
                }
                model.showCard = false
                model.showContent = false
                model.showOffers = false
            }
            // Carousel....
            VStack{
                Spacer()
                ZStack{
                    GeometryReader{ geometry in
                        HStack {
                            ScrollView {
                                
                                ForEach(model.cards.lazy.indices.reversed(),id: \.self) { index in
                                    HStack{
                                        CurrentCardMView(card: model.cards[index], animation: animation)
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
                Spacer()
            }.padding(.bottom,80)
            //Press detailes
            if model.showCard {
                CurrentCardMDetailes(viewRouter: viewRouter, animation: animation)
            }
            if model.showOffers {
                Offers(viewRouter: viewRouter, orderID: model.selectedCard.orderD.id, status: model.selectedCard.orderD.status, Offers: model.order.offers).environmentObject(OfferModel)
            }
            //notification
            VStack{
                if show{
                    Notifications(type: notificationT, imageName: "shoppingCart")
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
            }.onAppear(){
                if notificationT == .SendOrder  {
                    animateAndDelayWithSeconds(0.05) { self.show = true }
                    animateAndDelayWithSeconds(4) { self.show = false }
                }
            }
            VStack{
                if show{
                    Notifications(type: notificationT, imageName: "shoppingCart")
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
            }.onAppear(){
                if  notificationT == .CancelOrder {
                    animateAndDelayWithSeconds(0.05) { self.show = true }
                    animateAndDelayWithSeconds(4) {
                        self.show = false
                        notificationT = .None
                    }
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
                                viewRouter.currentPage = .HomePageM
                            }.foregroundColor(viewRouter.currentPage == .HomePageM ? Color("TabBarHighlight") : .gray)
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
                                viewRouter.currentPage = .ViewProfileM
                            }.foregroundColor(viewRouter.currentPage == .ViewProfileM ? Color("TabBarHighlight") : .gray)
                            
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBackground").shadow(radius: 2))
                        
                    }
                }
            }.edgesIgnoringSafeArea(.all)//zstack
            
        }//end ZStack
    }}

//Current card M View/ Taif
struct CurrentCardMView: View {
    @EnvironmentObject var model : CurrentCarouselMViewModel
    var card: currentCardM
    var animation: Namespace.ID
    
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
            }.padding(.top,15)
            //orderDetailes
            HStack {
                Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).padding(.leading)
                Text("\(model.orderPreview(c: card).orderDetails)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black.opacity(0.5))
                    .frame(maxWidth: 220, maxHeight: 50, alignment: .leading)
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
            //Detailes Button
            HStack{

                if !model.showContent{
                    //Text("\(model.selectedCard.orderD.status)")
                    //to let an arrow in the right of the card
                    
                    if model.orderPreview(c: card).status == "waiting for offer"{
                        Text("Waiting for offers")
                        Spacer(minLength: 0)
                        HStack{
                            
                            DotView(frame: 10)
                            DotView(delay: 0.2, frame: 10)
                            DotView(delay: 0.4, frame: 10)
                        }
                    }else{
                        //model.order.offers "\(model.order.offers.count) offers"
                        if model.orderPreview(c: card).status == "have an offer"{
                            Text("New offers")
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 100,height: 25)
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.green))
                            //.background(Color.purple)
                            Spacer(minLength: 0)
                        }
                    }
                    
                    
                    Image(systemName: "arrow.right")
                }
            }
            .foregroundColor(Color.gray.opacity(0.9))
            .padding(20)
            
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

//Current card M detailes/ Reem
struct CurrentCardMDetailes: View {
    @EnvironmentObject var model : CurrentCarouselMViewModel
    @StateObject var viewRouter: ViewRouter
    var animation: Namespace.ID
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var distance = ""
    @State var time = ""
    @State private var showingPaymentAlert = false
    
    var body: some View{
        
        ZStack{
            
            //map
            MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$model.selectedCard.orderD.pickUP, destination: self.$model.selectedCard.orderD.dropOff, distance: self.$distance, time: self.$time)
                .cornerRadius(35)
                .frame(width: 390, height: 300).padding(.bottom, 0)
                .clipped().position(x: 188,y: 100)
                .offset(y: 50)
                .onAppear {
                    
                    self.manager.requestAlwaysAuthorization()
                }
            
            ZStack {
                //back button
                Group{
                    RoundedRectangle(cornerRadius: 10).frame(width: 45, height: 35).foregroundColor(Color(.white))
                    Button(action: {
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
                        //Time
                        HStack{
                            Image(systemName: "clock")
                                .foregroundColor(Color.black.opacity(0.5))
                                .offset(x: 10, y: 10)
                                .padding(.leading)
                            Text("\(model.selectedCard.orderD.createdAt.calenderTimeSinceNow())")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color.black.opacity(0.5))
                                .animation(.easeIn)
                                .offset(x: 10, y: 10)
                            Spacer(minLength: 0)
                        }
                        
                        
                 
                        //Offers page
                        if model.selectedCard.orderD.status == "have an offer"{
                            HStack{
                                
                                    Text("Delivery offers")
                                        .foregroundColor(.purple)
                                        .bold()
                                
                                
                                Spacer(minLength: 0)
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(Color.gray.opacity(0.9))
                            .padding(20)
                            .onTapGesture {
                               withAnimation(.spring()){
                                model.order.getOffers(OrderId: model.selectedCard.orderD.id)
                                
                                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    withAnimation(.easeIn){
                                     //viewRouter.orderId = model.selectedCard.orderD.id
                                     //viewRouter.status = model.selectedCard.orderD.status
                                     //viewRouter.currentPage = .offers
                                     
                                     model.showOffers = true
                                    }//end with animation
                                   }//end dispatch
                                 }
                            }
                        }else{
                            if model.selectedCard.orderD.status == "waiting for offer"{
                                HStack{
                                    Text("Waiting for offers")
                                        .foregroundColor(.purple)
                                        .bold()
                                        .padding(.leading, 20)
                                    DotView(frame: 15)
                                    DotView(delay: 0.2, frame: 15)
                                    DotView(delay: 0.4, frame: 15)
            
                                Spacer(minLength: 0)
                                }
                            }
                        }
                        
                        //pick up
                        ZStack{
                            RoundedRectangle(cornerRadius: 15).padding().frame(width: 350, height: 160).foregroundColor(.white).shadow(radius: 1)
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 1")).offset(x: -125)
                            HStack {
                                
                                Text("Building \(self.getBuilding(id: model.selectedCard.orderD.pickUpBulding)), \nfloor \(model.selectedCard.orderD.pickUpFloor),  \(model.selectedCard.orderD.pickUpRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 200, alignment: .leading)
                            }
                            
                        }
                        //drop off
                        ZStack{
                            RoundedRectangle(cornerRadius: 15).padding().frame(width: 350, height: 160).foregroundColor(.white).shadow(radius: 1)
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 3")).offset(x: -125)
                            HStack{
                                
                                Text("Building \(self.getBuilding(id: model.selectedCard.orderD.dropOffBulding)), \nfloor \(model.selectedCard.orderD.dropOffFloor),  \(model.selectedCard.orderD.dropOffRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 200, alignment: .leading)
                            }
                            
                        }
                        //order items
                        ZStack(alignment: .top){
            
                           Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).offset(x: -130)
                            
                            HStack() {
                                Text("\(model.selectedCard.orderD.orderDetails)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 220, alignment: .leading)
                                    .padding(.vertical, 4)
                            }
                            
                        }.contentShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: 325)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 1)
                        
                        //Cancel button
                        Button(action: {
                            showingPaymentAlert.toggle()
                        }) {
                            Text("Cancel Order")
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
                        /*.onTapGesture {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.easeIn){
                                    
                                }//end with animation
                            }
                        }*/
                        
                        
                    }
                }.position(x: 188,y: 700)
                
                
            }
            // }
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).alert(isPresented: $showingPaymentAlert) {
            Alert(
                title: Text("Order confirmed"),
                message: Text("Are you sure you want cancel this offer"),
                primaryButton: .default((Text("Yes")), action: {
                    canelOrder()
                    notificationT = .CancelOrder
                    //viewRouter.currentPage = .CurrentOrder
                    model.showCard = false
                    model.showContent = false
                }) ,
                secondaryButton: .cancel((Text("No")))
            )}//end alert
        
    }// end body
    //cancel order
    func canelOrder(){
            model.cancelCardOrderId = model.selectedCard.orderD.id
            model.order.cancelOrder(OrderId: model.selectedCard.orderD.id)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                //withAnimation(.easeIn){
                    model.getCards()
                //}//end with animation
            }
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

// CurrentCarouselMViewModel
class CurrentCarouselMViewModel: ObservableObject {
    
    //Add obs obje from type member?
    @ObservedObject var order = Order()
    @StateObject var OfferModel = OfferCarousel()
    
    //each order has card
    @Published var cards: [currentCardM] = []
    
    // Detail Content....
    @Published var selectedCard = currentCardM(cardColor: .clear)
    //user press details
    @Published var showCard = false
    @Published var showContent = false
    @Published var showOffers = false
    
    @Published var cancelCardOrderId : String = ""
    
    init(){
        //from this ID get all the cards
        order.getMemberOrder(Id: UserDefaults.standard.getUderId())
        print("number of oreders inside init: \(order.memberOrder.count)")
        getCards()
        
    }
    
    //return order details
    func orderPreview(c: currentCardM) -> OrderDetails {
        return c.orderD
    }
    
    func getCards(){
        print("number of cards inside getCards: \(order.memberOrder.count)")
        if order.memberOrder.isEmpty{
            print("there is no order")
        }
        
        cards.removeAll()
        for index in order.memberOrder {
            //Check the state of the order
            if( index.status != "cancled" && index.status != "completed" && index.memberId != cancelCardOrderId){
                
                    cards.append(contentsOf: [ currentCardM( cardColor: Color(.white),state : 0, orderD : index )])
            }
            
        }
    }
    
    
}

//current card M info
struct currentCardM: Identifiable {
    var id = UUID().uuidString
    var cardColor: Color
    var offset: CGFloat = 0
    var state : Int = 0
    var orderD = OrderDetails(id: "", pickUP: CLLocationCoordinate2D (latitude: 0.0, longitude: 0.0), pickUpBulding: 0, pickUpFloor: 0, pickUpRoom: "", dropOff: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), dropOffBulding: 0, dropOffFloor: 0, dropOffRoom: "", orderDetails: "", memberId: "", isAdded: false, status: "")
}

struct CurrentOrderView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOrderView(viewRouter: ViewRouter())
    }
}
