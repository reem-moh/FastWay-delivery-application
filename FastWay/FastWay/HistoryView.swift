//
//  HistoryView.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.
//

import SwiftUI
import MapKit

struct HistoryView: View {
    let abuotPage: Page = .AboutUs
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var model: HistoryCarouselMViewModel
    @StateObject var courierOrderModel = CarouselViewModel()
    @Namespace var animation
    //for notification
    @State var show = false
    @State var imgName = "shoppingCart"
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()

    
    var body: some View {
        ZStack{
            
        }
        ZStack {
            //Background
            HStack{
                GeometryReader{ geometry in
                    //background
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 49"))
                        .resizable() //add resizable
                        .frame(width: width(num: 375)) //addframe
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:hieght(num:-70))
                    //CurrentOrderView
                    Text("Past Orders").font(.custom("Roboto Medium", size: fontSize(num:25))).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .multilineTextAlignment(.center).position(x:width(num:170) ,y:hieght(num:10)).offset(x:width(num:20),y:hieght(num:20))
                    //white rectangle
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                        .resizable() //add resizable
                        .frame(width: width(num: 375)) //addframe
                        .edgesIgnoringSafeArea(.bottom).offset(y: hieght(num:50))
                    
                }.edgesIgnoringSafeArea(.all)
                
            }.onAppear(){
                //retrieve ordered assigned to the user
                model.order.getMemberOrderCancelledAndCompleted(Id: UserDefaults.standard.getUderId())
                //retrieve order waiting for accept
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
            
            
      

            // Carousel...
            
            VStack{
                // Carousel....
                Spacer()
                if model.cards.count == 0 {
                    Text("you do not have any  Past order yet ")
                }else{
                    ZStack{
                        GeometryReader{ geometry in
                            HStack {
                                ScrollView {
                                    
                                    ForEach(model.cards.lazy.indices.reversed(),id: \.self) { index in
                                        HStack{
                                            HistoryCardMView(card: model.cards[index], animation: animation)
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
            
            //Press details
            if model.showCard {
                HistoryCardMDetailes(viewRouter: viewRouter, animation: animation)
            }
                        
            
            //BarMenue
            ZStack{
                GeometryReader { geometry in
                    VStack {
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
                                    .frame(width: width(num:geometry.size.width/7), height: hieght(num:geometry.size.width/7))
                                    .shadow(radius: 4)
                                VStack {
                                    Image(uiImage:  #imageLiteral(resourceName: "FastWay")) //logo
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: width(num:geometry.size.width/7-6) , height: hieght(num:geometry.size.width/7-6))
                                }.padding(.horizontal, width(num:14))
                                .onTapGesture {
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
                            }.padding(.horizontal, width(num:14))
                            .onTapGesture {
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
        .onAppear(){
            //for the in app notification
            //call it before get notification
            /*UNUserNotificationCenter.current().delegate = delegate
            getNotificationCourier(courierId: UserDefaults.standard.getUderId()){ success in
                print("after calling method get notification")
                guard success else { return }
            }*/
        }
    }
    
}


//Current card M View/ Taif
struct HistoryCardMView: View {
    @EnvironmentObject var model : HistoryCarouselMViewModel
    var card: HistoryCardM
    var animation: Namespace.ID
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
                Spacer(minLength: 0)
                Spacer(minLength: 0)

                if(model.orderPreview(c: card).deliveryPrice != 0 && self.stat == "completed" ){
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
            }
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
                    //have an offer
                    if self.stat == "completed"{
                        Text("completed")
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: width(num:170),height: hieght(num:25))
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray))
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
                
    
                    if self.stat == "cancled"
                    {
                        Text("cancled")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: width(num:100),height: hieght(num:25))
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray))
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

                        
                    }
                    
                    Image(systemName: "arrow.right")
                }
            }
            .foregroundColor(Color.gray.opacity(0.9))
            .padding(20)
            .onAppear(){
                model.getCards()
                self.stat = model.orderPreview(c: card).status
                /*model.order.getStatusNotAssigned(memberId: model.orderPreview(c: card).memberId, order: model.orderPreview(c: card).orderDetails){ success in
                    print("Live status for cards")
                }
                self.stat = model.order.liveStatus*/
            }
            .onChange(of: model.orderPreview(c: card).status) { value in
                model.getCards()
                self.stat = model.orderPreview(c: card).status
                //self.stat = model.order.liveStatus
                
            }
            
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

//HistoryCardMDetailes card M detailes/ Reem
struct HistoryCardMDetailes: View {
    @EnvironmentObject var model : HistoryCarouselMViewModel
    @StateObject var viewRouter: ViewRouter
    var animation: Namespace.ID
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var distance = ""
    @State var time = ""
    @State private var CancelOrder = false
    @State var CancelButtonShow = true
    @State var stat = ""
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()
    
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
                            model.getCards()
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
                    .onAppear(){
                        //self.stat = model.selectedCard.orderD.status
                        model.order.getStatusNotAssigned(memberId: model.selectedCard.orderD.memberId, order: model.selectedCard.orderD.orderDetails){ success in
                            print("\(model.order.liveStatus)")
                        }
                        self.stat = model.order.liveStatus
                    }
                    .onChange(of: model.order.liveStatus) { value in
                        self.model.getCards()
                        self.stat = value
                    }
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
                            Spacer(minLength: 0)

                            
                            
                          
                            
                            if (model.selectedCard.orderD.deliveryPrice != 0 && self.stat == "completed" ){
                                
                                Image(uiImage: #imageLiteral(resourceName: "money"))
                                    .foregroundColor(Color.black.opacity(0.5))
                                    .offset(x: width(num:10), y: hieght(num:10))
                                    .padding(.leading)
                                
                            Text("\(model.selectedCard.orderD.deliveryPrice) SR")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color.black.opacity(0.5))
                                .animation(.easeIn)
                                .offset(x: width(num:10), y: hieght(num:10))}
                            Spacer(minLength: 0)
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
                                    .padding(.vertical, hieght(num: 4))
                            }
                            
                        }.contentShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: width(num:325))
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 1)
                        .padding(.bottom, hieght(num:450))
                        
                        
                        
                        
                        
                        
                    }
                }.position(x: width(num:188),y: hieght(num:700))
                
                
            }
            // }
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
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


// HistoryCarouselMViewModel
class HistoryCarouselMViewModel: ObservableObject {
    
    //Add obs obje from type member?
    @ObservedObject var order = Order()
    @StateObject var OfferModel = OfferCarousel()
    
    //each order has card
    @Published var cards: [HistoryCardM] = []
    
    // Detail Content....
    @Published var selectedCard = HistoryCardM(cardColor: .clear)

    //Display all cards in current page
    @Published var showCard = false
    //Display details page of a card
    @Published var showContent = false
    //display offers page
    @Published var showOffers = false
    //display notification inside system of cancel order
    @Published var showCancel = false
    //Id of canceled order
    @Published var cancelCardOrderId : String = ""
    //Toggle to show notification
    @Published var notificationMSG =  false
    @Published var assigned = false
    //Toggle to show chat
    @Published var showChat = false
    
    init(){
        //from this ID get all the cards
        //order.getMemberOrder(Id: UserDefaults.standard.getUderId())
        //print("number of oreders inside init: \(order.memberOrder.count)")
        //getCards()
        
    }
    
    //return order details
    func orderPreview(c: HistoryCardM) -> OrderDetails {
        return c.orderD
    }
    
    func getCards(){
        print("number of cards inside getCards: \(order.MemberOrderCancelled.count)")
        if order.MemberOrderCancelled.isEmpty{
            print("there is no order")
        }
        
        cards.removeAll()
        //&& index.id != cancelCardOrderId
        for index in order.MemberOrderCancelled {
            checkOrders(ID: UserDefaults.standard.getUderId())
            if( index.status == "cancled" || index.status == "completed" ){
                cards.append(contentsOf: [ HistoryCardM( cardColor: Color(.white), orderD : index )])
            }
            
            
        }
    }
    
 
  
}


//Card info
struct HistoryCardM: Identifiable {
    
    var id = UUID().uuidString
    var cardColor: Color
    var offset: CGFloat = 0
    var orderD = OrderDetails(id: "", pickUP: CLLocationCoordinate2D (latitude: 0.0, longitude: 0.0), pickUpBulding: 0, pickUpFloor: 0, pickUpRoom: "", dropOff: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), dropOffBulding: 0, dropOffFloor: 0, dropOffRoom: "", orderDetails: "", memberId: "", isAdded: false, status: "")
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(viewRouter: ViewRouter())
    }
}
