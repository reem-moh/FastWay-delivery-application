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
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 49"))
                        .resizable() //add resizable
                        .frame(width: width(num: 375)) //addframe
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .offset(y:hieght(num: -100))
                    //CurrentOrderView
                    Text("Current Orders")
                        .font(.custom("Roboto Medium", size: fontSize(num:25)))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .multilineTextAlignment(.center)
                        .position(x:width(num:170) ,y:hieght(num:50))
                        .offset(x:width(num:20),y:hieght(num:20))
                    //white rectangle
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                        .resizable() //add resizable
                        .frame(width: width(num: 375)) //addframe
                        .edgesIgnoringSafeArea(.all)
                        .offset(y:hieght(num:  100))
                    
                }.edgesIgnoringSafeArea(.all)
                
            }.onAppear(){
                //calling Methods
                //model.order.getMemberOrder(Id: UserDefaults.standard.getUderId())
                checkOrders(ID:  UserDefaults.standard.getUderId())
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    //withAnimation(.easeIn){
                        model.getCards()
                    //}//end with animation
                }
                model.showCard = false
                model.showContent = false
                model.showOffers = false
                //model.order.cancelAutomatic(memberId: UserDefaults.standard.getUderId())
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
                                    .padding(.vertical, hieght(num:5))
                                    .shadow(radius: 1)
                                    
                                    
                                }.padding(.bottom,hieght(num:25))//end of for each
                                
                                
                            }
                            
                        }
                    }
                }.padding(.top,hieght(num:80))
                Spacer()
            }.padding(.bottom,hieght(num:80))
            //Press detailes
            if model.showCard {
                CurrentCardMDetailes(viewRouter: viewRouter, animation: animation)
            }
            if model.showOffers {
                Offers(viewRouter: viewRouter, orderID: model.selectedCard.orderD.id, status: model.selectedCard.orderD.status,pickupLocation: model.selectedCard.orderD.pickUP, Offers: model.order.offers).environmentObject(OfferModel)
            }
            //notification CancelByDefault
            //Send order
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
            //Cancel order
            VStack{
                if model.showCancel{
                    Notifications(type: notificationT, imageName: "shoppingCart")
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
            }
            // canceled order after 15 min
            VStack{
                if show{
                    Notifications(type: notificationT, imageName: "shoppingCart")
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
            }.onAppear(){
                if notificationT == .CancelByDefault  {
                    animateAndDelayWithSeconds(0.05) { self.show.toggle() }
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
                                    .frame(width: width(num:geometry.size.width/5), height: hieght(num:geometry.size.height/28))
                                    .padding(.top, hieght(num:10))
                                Text("Home")
                                    .font(.footnote)
                                Spacer()
                            }.padding(.horizontal, width(num:14)).onTapGesture {
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
                                    .frame(width: width(num:geometry.size.width/7), height: width(num:geometry.size.width/7))
                                    .shadow(radius: 4)
                                VStack {
                                    Image(uiImage:  #imageLiteral(resourceName: "FastWay")) //logo
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: width(num:geometry.size.width/7-6) , height: width(num:geometry.size.width/7-6))
                                }.padding(.horizontal, width(num:14)).onTapGesture {
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
                            }.offset(y: hieght(num:-geometry.size.height/8/2))
                            //profile icon
                            VStack {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: width(num:geometry.size.width/5), height: hieght(num:geometry.size.height/28))
                                    .padding(.top, hieght(num:10))
                                Text("Profile")
                                    .font(.footnote)
                                Spacer()
                            }.padding(.horizontal, width(num:14)).onTapGesture {
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
                        .frame(width:width(num: geometry.size.width), height: hieght(num:geometry.size.height/8))
                        .background(Color("TabBarBackground").shadow(radius: 2))
                        
                    }
                }
            }.edgesIgnoringSafeArea(.all)//zstack
            
        }//end ZStack
    }}

//Current card M View/ Taif
struct CurrentCardMView: View {
    @EnvironmentObject var model : CurrentCarouselMViewModel
    var card: Card
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
            }.padding(.top,hieght(num:15))
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
                
            }.padding(.top,hieght(num:15))
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
                                .frame(width: width(num:100),height: hieght(num:25))
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
        .frame(maxWidth: width(num:.infinity), maxHeight: hieght(num:.infinity))
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
        /*.alert(isPresented: $model.check10min) {
            Alert(
                title: Text("Order confirmed"),
                message: Text("your order: \"\(card.orderD.orderDetails)\" has been 10 minutes without an offer, do you want to extend the time?"),
                primaryButton: .default((Text("Yes")), action: {
                    model.check10min = false
                }) ,
                secondaryButton: .cancel((Text("No, Cancel Order")),  action: {
                    model.canelOrder(Id : card.orderD.id)
                    notificationT = .CancelOrder
                    //viewRouter.currentPage = .CurrentOrder
                    model.showCard = false
                    model.showContent = false
                    model.check10min = false
                })
        )}//end alert*/
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
    @State private var CancelOrder = false
    @State var CancelButtonShow = true
    
    var body: some View{
        
        ZStack{
            
            //map
            MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$model.selectedCard.orderD.pickUP, destination: self.$model.selectedCard.orderD.dropOff, distance: self.$distance, time: self.$time)
                .cornerRadius(35)
                .frame(width: width(num:390), height: hieght(num:300))
                .padding(.bottom, hieght(num:0))
                .clipped()
                .position(x: width(num:188),y: hieght(num:100))
                .offset(y: hieght(num:50))
                .onAppear {
                    
                    self.manager.requestAlwaysAuthorization()
                }
            
            ZStack {
                //back button
                Group{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: width(num:45), height:hieght(num: 35))
                        .foregroundColor(Color(.white))
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
                            .frame(width: width(num:30), height: hieght(num:30))
                            .clipped()
                            .background(Color(.white))
                    }.padding(1.0)
                }.position(x: width(num:50), y: hieght(num:50))
                //white background
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                    .resizable() //add resizable
                    .frame(width: width(num: 375)) //addframe
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y:hieght(num:  240))
                
                VStack{
                    
                    ScrollView{
                        //Time
                        HStack{
                            Image(systemName: "clock")
                                .foregroundColor(Color.black.opacity(0.5))
                                .offset(x: width(num:10), y: hieght(num:10))
                                .padding(.leading)
                            Text("\(model.selectedCard.orderD.createdAt.calenderTimeSinceNow())")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color.black.opacity(0.5))
                                .animation(.easeIn)
                                .offset(x: width(num:10), y: hieght(num:10))
                            Spacer(minLength: 0)
                        }
                        
                        
                 
                        //Offers page
                        if model.selectedCard.orderD.status == "have an offer"{
                            HStack{
                                
                                    Text("Delivery offers")
                                        .foregroundColor(Color("ButtonColor"))
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
                                        .padding(.leading, width(num:20))
                                    DotView(frame: 15)
                                    DotView(delay: 0.2, frame: 15)
                                    DotView(delay: 0.4, frame: 15)
            
                                Spacer(minLength: 0)
                                }
                            }
                        }
                        
                        //pick up
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .padding()
                                .frame(width: width(num:350), height: hieght(num:160))
                                .foregroundColor(.white)
                                .shadow(radius: 1)
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 1"))
                                .offset(x: width(num:-125))
                            HStack {
                                
                                Text("Building \(self.getBuilding(id: model.selectedCard.orderD.pickUpBulding)), \nfloor \(model.selectedCard.orderD.pickUpFloor),  \(model.selectedCard.orderD.pickUpRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:200), alignment: .leading)
                            }
                            
                        }
                        //drop off
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .padding()
                                .frame(width: width(num:350), height: hieght(num:160))
                                .foregroundColor(.white)
                                .shadow(radius: 1)
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 3"))
                                .offset(x: width(num:-125))
                            HStack{
                                
                                Text("Building \(self.getBuilding(id: model.selectedCard.orderD.dropOffBulding)), \nfloor \(model.selectedCard.orderD.dropOffFloor),  \(model.selectedCard.orderD.dropOffRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:200), alignment: .leading)
                            }
                            
                        }
                        //order items
                        ZStack(alignment: .top){
            
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).offset(x: width(num:-130))
                            
                            HStack() {
                                Text("\(model.selectedCard.orderD.orderDetails)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:220), alignment: .leading)
                                    .padding(.vertical, 4)
                            }
                            
                        }.contentShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: width(num:325))
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 1)
                        
                        HStack {
                            if CancelButtonShow {
                            //Cancel button
                             Button(action: {
                                CancelOrder.toggle()
                            }) {
                                Text("Cancel Order")
                                    .font(.custom("Roboto Bold", size: fontSize(num:22)))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                    .multilineTextAlignment(.center)
                                    .padding(1.0)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                                    .textCase(.none)
                            }
                            .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                            .padding(.top,hieght(num:25))
                            .offset(x: width(num:0))
                            .padding(.bottom,hieght(num:450))
                            /*.onTapGesture {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation(.easeIn){
                                        
                                    }//end with animation
                                }
                            }*/
                        }
                        }.onAppear(){
                            //assigned
                            if model.selectedCard.orderD.status == order.status[3]{
                                
                             let timeInterval = -1 * model.selectedCard.orderD.createdAt.timeIntervalSinceNow
                                //60 * (60+30)
                                if timeInterval >= 5400 {
                                    self.CancelButtonShow.toggle()
                                }else {
                                    CancelButtonShow = false
                                }
                            }

                        }
                        
                        
                    }
                }.position(x: width(num:188),y: hieght(num:700))
                
                
            }
            // }
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .alert(isPresented: $CancelOrder) {
            Alert(
                title: Text("Order confirmed"),
                message: Text("Are you sure you want cancel this offer"),
                primaryButton: .default((Text("Yes")), action: {
                    model.canelOrder(Id: model.selectedCard.orderD.id)
                    notificationT = .CancelOrder
                    //viewRouter.currentPage = .CurrentOrder
                    model.showCard = false
                    model.showContent = false
                }) ,
                secondaryButton: .cancel((Text("No")))
            )}//end alert
        
    }// end body
    
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
    @Published var cards: [Card] = []
    
    // Detail Content....
    @Published var selectedCard = Card(cardColor: .clear)
    //user press details
    @Published var showCard = false
    @Published var showContent = false
    @Published var showOffers = false
    @Published var showCancel = false
    //@Published var check10min = false
    @Published var cancelCardOrderId : String = ""
    
    init(){
        //from this ID get all the cards
        order.getMemberOrder(Id: UserDefaults.standard.getUderId())
        print("number of oreders inside init: \(order.memberOrder.count)")
        getCards()
        
    }
    
    //return order details
    func orderPreview(c: Card) -> OrderDetails {
        return c.orderD
    }
    
    func getCards(){
        print("number of cards inside getCards: \(order.memberOrder.count)")
        if order.memberOrder.isEmpty{
            print("there is no order")
        }
        
        cards.removeAll()
        for index in order.memberOrder {
            //convert time to double
            checkOrders(ID: UserDefaults.standard.getUderId())
            //let timeInterval = -1*index.createdAt.timeIntervalSinceNow
            if( index.status != "cancled" && index.status != "completed" && index.memberId != cancelCardOrderId){
                /* if timeInterval >= 1200  && index.status == order.status[0]{
                    order.cancelOrder(OrderId: index.id)
                    //notification
                    notificationT = .CancelOrder
                    //viewRouter.currentPage = .CurrentOrder
                    showCard = false
                    showContent = false
                    
                }else {
                    if((timeInterval >= 600 && timeInterval < 1200)  && index.status == order.status[0]){
                        check10min=true
                    }*/
                
                    cards.append(contentsOf: [ Card( cardColor: Color(.white), orderD : index )])
                //}
            }
            
            
        }
    }
    
    //cancel order
    func canelOrder(Id: String){
           cancelCardOrderId = Id
            order.cancelOrder(OrderId: Id)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                //withAnimation(.easeIn){
                self.getCards()
                self.showCancel.toggle()
                animateAndDelayWithSeconds(0.05) { self.showCancel = true }
                animateAndDelayWithSeconds(4) {self.showCancel = false }
                //}//end with animation
            }
    }
    
    
}






//check if order exceede th 15 min limit
func checkOrders(ID : String){
    if order.memberOrder.isEmpty{
        order.getMemberOrder(Id: ID)
    }
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        for index in order.memberOrder {
            
            //convert time to double
            let timeInterval = -1*index.createdAt.timeIntervalSinceNow
            if( index.status != "cancled" && index.status != "completed" ){
                if timeInterval >= 360  && index.status == order.status[0]{
                    order.cancelOrder(OrderId: index.id)
                    //notification
                    notificationT = .CancelByDefault
                    //ViewRouter.currentPage = .HomePageM
                }
            }
            
        }
      }
    
}

struct CurrentOrderView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOrderView(viewRouter: ViewRouter())
    }
}
