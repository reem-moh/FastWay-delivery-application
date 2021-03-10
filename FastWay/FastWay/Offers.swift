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
    @StateObject var CurrentOrdersModel: CurrentCarouselMViewModel
    @Namespace var animation
    @State var orderID : String
    @State var status : String
    @State var pickupLocation : CLLocationCoordinate2D
    @State var Offers : [Offer] = []
    
    var body: some View {
        ZStack {
            //Background
            HStack{
                GeometryReader{ geometry in
                    //background
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
                    //CurrentOrderView
                    Text("Offers").font(.custom("Roboto Medium", size: 25)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .multilineTextAlignment(.center).position(x:170 ,y:50).offset(x:20,y:20)
                    //white rectangle
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).edgesIgnoringSafeArea(.bottom).offset(y: 100)
                    
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
                            //.colorInvert()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width(num:30), height: hieght(num:30))
                            .clipped()
                           // .background(Color(.white))
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
                    model.Offers = self.Offers
                    model.pickupLoc = self.pickupLocation
                    //print("n\(Offers[0].courier.courier.name)")
                    /*if(self.Offers.isEmpty){
                        model.order.getOffers(OrderId: orderID)
                        model.Offers = model.order.offers
                    }*/
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeIn){
                            model.getCards()
                        }//end with animation
                    }
                    //model.getCards()
                }
                
            }
            
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
                    }
                    .padding(.top,80)
                    Spacer()
                }.padding(.bottom,80)
            }
           
            
        }//end ZStack
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
                Image("dollar")
                    .resizable()
                    .frame(width: 20, height: 20)
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
                    model.order
                        .acceptOffer(orderID: model.orderPreview(c: card).OrderId, courierID: model.orderPreview(c: card).courierId, deliveryPrice: Double(model.orderPreview(c: card).price))
                    model.showContent = false
                    notificationT = .None
                    //viewRouter.currentPage = .CurrentOrder
                    notificationT = .AcceptOffer
                    Env.getCards()
                    Env.AcceptOfferNotification.toggle()
                    print("Env.selectedCard.orderD.deliveryPrice Before: \(Env.selectedCard.orderD.deliveryPrice)")
                    Env.selectedCard.orderD.deliveryPrice = card.OfferInfo.price
                    print("Env.selectedCard.orderD.deliveryPrice After:offer price \(card.OfferInfo.price)OrderPrice\(Env.selectedCard.orderD.deliveryPrice)")
                    Env.showOffers = false
                    Env.showCard = false
                }, label: {
                    Text("Accept")
                        .font(.custom("Roboto Bold", size: 22))
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        //withAnimation(.easeIn){
                        model.order.cancelOffer(CourierID: model.orderPreview(c: card).courierId, OrderId: model.orderPreview(c: card).OrderId, MemberID: model.orderPreview(c: card).memberId, Price: model.orderPreview(c: card).price)
                        //}//end with animation
                    }
                    
                    model.order.getOffers(OrderId: model.orderPreview(c: card).OrderId)
                    model.Offers = model.order.offers
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        //withAnimation(.easeIn){
                        model.getCards()
                        //}//end with animation
                    }
                   
                }, label: {
                    Text("Decline")
                        .font(.custom("Roboto Bold", size: 22))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .multilineTextAlignment(.center)
                        .padding(1.0)
                        .textCase(.none)
                })
                .frame(width: width(num: 130), height: hieght(num: 40))
                .background(Color("ButtonColor"))
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
        
    //return order details
    func orderPreview(c: OfferCardInfo) -> Offer {
        return c.OfferInfo
    }
    
    func getCards(){
        //if there are offers change haveOffers=true
        ///Change all this info memberOrder
        //order.getOffers(OrderId: selectedCard.OfferInfo.OrderId)
        //print("number of cards inside OfferCarousel getCards: \(order.offers.count)")Offers
        print("number of cards inside OfferCarousel getCards: \(Offers.count)")
        if Offers.isEmpty{
            print("there is no offer")
            haveOffers = false
            return
        }else{
            haveOffers = true
            cards.removeAll()
            for index in Offers {
                //Check the state of the order
                cards.append(contentsOf: [ OfferCardInfo( cardColor: Color(.white), OfferInfo : index )])
            }
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

