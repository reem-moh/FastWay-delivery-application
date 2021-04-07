//
//  Offers.swift
//  FastWay
//
//  Created by Reem on 27/02/2021.
//

import SwiftUI
import MapKit
import CoreLocation

struct Offers: View {
    
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var model: OfferCarousel
    @ObservedObject var CurrentOrdersModel: CurrentCarouselMViewModel
    @Namespace var animation
    @State var orderID : String
    @State var status : String
    @State var pickupLocation : CLLocationCoordinate2D
    @State var Offers : [Offer] = []
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
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:hieght(num: -100))
                    //CurrentOrderView
                    Text("Offers")
                        .font(.custom("Roboto Medium", size: fontSize(num: 25)))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .multilineTextAlignment(.center)
                        .position(x:width(num: 170) ,y:hieght(num: 50))
                        .offset(x:width(num: 20),y:hieght(num: 20))
                    //white rectangle
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                        .resizable() //add resizable
                        .frame(width: width(num: 375)) //addframe
                        .edgesIgnoringSafeArea(.bottom).offset(y: hieght(num: 100))
                    
                }.edgesIgnoringSafeArea(.all)
               //back
                HStack{
                    Button(action: {
                        withAnimation(.spring()){
                            model.showContent = false
                            notificationT = .None
                            CurrentOrdersModel.getCards()
                            CurrentOrdersModel.showOffers = false
                        }
                    }) {
                        Image("arrow_back")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width(num:30), height: hieght(num:30))
                            .clipped()
                    }.padding(1.0)
                    .position(x: width(num:-150), y: hieght(num:5))
                }
                
                
            }.onAppear(){
                model.haveOffers = false
                //calling Methods
                if(status == "have an offer"){
                    print("*************************")
                    print("*******Offers view*********")
                    print("the order id inside offer view\(orderID)")
                   //model.haveOffers = true
                    model.OrderId = self.orderID
                    model.status = self.status
                    model.order.offers = self.Offers
                    model.pickupLoc = self.pickupLocation
                    model.getCards()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeIn){
                            model.getCards()
                        }//end with animation
                    }
                }
                
            }.onChange(of: model.updatePage, perform: { value in
                    if value {
                        model.getCards()
                        if notificationT == .DeclineOffer  {
                            animateAndDelayWithSeconds(0.05) {
                                self.imgName = "cancelTick"
                                self.show = true }
                            animateAndDelayWithSeconds(4) {
                                self.show = false
                                model.updatePage = false
                                notificationT = .None
                            }
                        }
                        model.updatePage = false
                    }
            })
            
            
            if model.haveOffers {
                // Carousel....
                VStack{
                    Spacer()
                    ZStack{
                        GeometryReader{ geometry in
                            HStack {
                                ScrollView {
                                    
                                    ForEach(model.cards.lazy.indices.reversed(),id: \.self) { index in
                                        HStack{
                                            OfferCard(viewRouter: viewRouter, card: model.cards[index], animation: animation,Env: CurrentOrdersModel)
                                            Spacer(minLength: 0)
                                        }
                                        .padding(.horizontal)
                                        .contentShape(Rectangle())
                                        .gesture(DragGesture(minimumDistance: 20))
                                        .padding(.vertical, hieght(num: 5))
                                        .shadow(radius: 1)
                                        
                                        
                                    }.padding(.bottom,hieght(num: 25))//end of for each
                                    
                                    
                                }
                                
                            }
                        }
                    }
                    .padding(.top,hieght(num: 80))
                    Spacer()
                }.padding(.bottom,hieght(num: 80))
            }else{
                Text("You haven\'t recieved any offers yet")
            }
           
            
        }//end ZStack
        .onAppear(){
            //for the in app notification
            //call it before get notification
           // UNUserNotificationCenter.current().delegate = delegate
                /*getNotificationMember(memberId: UserDefaults.standard.getUderId()){ success in
                print("after calling method get notification")
                guard success else { return }
            }*/
        }
        
    }
    
}

//OfferCard
struct OfferCard: View {
    @EnvironmentObject var model : OfferCarousel
    @StateObject var viewRouter: ViewRouter
   // @EnvironmentObject var Environment: CurrentCarouselMViewModel
    var card: OfferCardInfo
    var animation: Namespace.ID
    @StateObject var Env : CurrentCarouselMViewModel
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()
    
    var body: some View {
        
        //Card
        VStack{
            HStack{
                Image("profileC")
                    .resizable()
                    .frame(width: width(num: 30), height: hieght(num: 30))
                    .padding(.leading)
                    
                Text("\(model.orderPreview(c: card).courier.courier.name)")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.black.opacity(0.5))
                    .animation(.easeIn)
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }.padding(.top, hieght(num: 15))
            
            HStack{
                Text("\(getDistance(loc1: CLLocation(latitude: model.orderPreview(c: card).courierLocation.latitude, longitude: model.orderPreview(c: card).courierLocation.longitude), loc2: CLLocation(latitude: model.pickupLoc.latitude, longitude: model.pickupLoc.longitude))) from pick up location")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.black.opacity(0.5))
                    .padding(.leading, width(num: 27))
                    .animation(.easeIn)
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }.padding(.top, hieght(num: 7))
            

            HStack{
                
               
                
                Image("money")
                    .resizable()
                    .frame(width: width(num: 20), height: hieght(num: 20))
                    .padding(.leading, width(num: 20))
                Text("\(card.OfferInfo.price) SAR")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.black.opacity(0.5))
                    .animation(.easeIn)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)



            }.padding(.top, hieght(num: 15))
            
            HStack{
                Spacer()
                Spacer()
                //accept button
                Button(action: {
                    withAnimation(.spring()){
                        model.order
                            .acceptOffer(orderID: model.orderPreview(c: card).OrderId, courierID: model.orderPreview(c: card).courierId, deliveryPrice: Double(model.orderPreview(c: card).price),courierLocation:model.orderPreview(c: card).courierLocation)
                        model.showContent = false
                        notificationT = .AcceptOffer
                        Env.notificationMSG = true
                        Env.getCards()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.easeIn){
                                Env.showOffers = false
                                Env.showCard = false
                            }
                        }
                        
                    }
                }, label: {
                    Text("Accept")
                        .font(.custom("Roboto Bold", size: fontSize(num: 22)))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .multilineTextAlignment(.center)
                        .padding(1.0)
                        .textCase(.none)
                })
                .frame(width: width(num: 130), height: hieght(num: 40))
                .background(Color("ButtonColor"))
                .clipShape(RoundedRectangle(cornerRadius: 5))
                Spacer()
                
                //decline button
                Button(action: {
                    model.order.cancelOffer(CourierID: model.orderPreview(c: card).courierId, OrderId: model.orderPreview(c: card).OrderId, MemberID: model.orderPreview(c: card).memberId, Price: model.orderPreview(c: card).price)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        model.order.getOffers(OrderId: model.orderPreview(c: card).OrderId) { success in
                            print("inside getOrderForCourierCurrentOrder success")
                            guard success else { return }
                            //model.Offers = model.order.offers
                            notificationT = .DeclineOffer
                            model.updatePage = true
                            model.getCards()
                            
                        }
                    
                    }
                    //model.Offers = model.order.offers
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        model.getCards()
                    }
                    notificationT = .DeclineOffer
                    model.updatePage = true
                    if model.cards.count == 0 {
                        Env.showCard = false
                        Env.showContent = false
                        Env.showOffers = false
                    }
                }, label: {
                    Text("Decline")
                        .font(.custom("Roboto Bold", size: fontSize(num: 22)))
                        .foregroundColor(Color("ButtonColor"))
                        .multilineTextAlignment(.center)
                        .padding(1.0)
                        .textCase(.none)
                        
                })
                .frame(width: width(num: 130), height: hieght(num: 40))
                .background(Color("ButtonWhite"))
                .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("ButtonColor"), lineWidth: 2)
                        )
                .clipShape(RoundedRectangle(cornerRadius: 5))
                
                Spacer()
                Spacer()
                
            }
            .padding(.vertical, hieght(num: 20))
        }//end vStack
        .frame(maxWidth: width(num:.infinity), maxHeight: hieght(num:.infinity))
        .background(
            card.cardColor
                .cornerRadius(25)
                .matchedGeometryEffect(id: "bgColor-\(card.id)", in: animation)
        )
        
        
    }
}

// CurrentCarouselMViewModel
class OfferCarousel: ObservableObject {
    
    //Add obs obje from type member?
    @ObservedObject var order = Order()
    
    //each order has card
    @Published var cards: [OfferCardInfo] = []
    
    // Detail Content....
    @Published var selectedCard = OfferCardInfo(cardColor: .clear )
    
    @Published var haveOffers = true
    @Published var showContent = false
    @Published var OrderId: String = ""
    @Published var status: String = ""
    @Published var pickupLoc : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @Published var Offers : [Offer] = []
    //when user press decline
    @Published var updatePage =  false
    //return order details
    func orderPreview(c: OfferCardInfo) -> Offer {
        return c.OfferInfo
    }
    
    func getCards(){
        print("number of cards inside OfferCarousel getCards: \(order.offers.count)")
        if order.offers.isEmpty{
            print("there is no offer")
            haveOffers = false
            return
        }else{
            haveOffers = true
            cards.removeAll()
            for index in order.offers {
                //Check the state of the order
                cards.append(contentsOf: [ OfferCardInfo( cardColor: Color(.white), OfferInfo : index )])
            }
            self.cards = self.cards.sorted(by: { $0.OfferInfo.price >= $1.OfferInfo.price })
        }
        
        
    }
    
}

//current card M info
struct OfferCardInfo: Identifiable {
    var id = UUID().uuidString
    var cardColor: Color
    var offset: CGFloat = 0
    //var courier : Courier
    var OfferInfo = Offer( id: "", OrderId: "" , memberId: "",courierId: "", courier: Courier(id: "", name: "", email: "", phN: ""), price: 0, courierLocation: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))// change to get offer info
    
    
}

