//
//  Offers.swift
//  FastWay
//
//  Created by Reem on 27/02/2021.
//

import SwiftUI
import MapKit

struct Offers: View {
    
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var model: OfferCarousel
    @Namespace var animation
    //@State var orderID : String
    //@State var status : String
    
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
                
            }.onAppear(){
                //calling Methods
                order.getOffers(OrderId: model.selectedCard.OfferInfo.OrderId)
                                model.getCards()
                /*if(status == "have an offer"){
                    model.order.getOffers(OrderId: orderID)
                    model.getCards()
                }*/
                
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
                                            OfferCard(card: model.cards[index], animation: animation)
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
            else {
                Text("waiting for offers")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black.opacity(0.5))
                    .animation(.easeIn)
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
                                    //model.showCard.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn){
                                            //model.showContent = false
                                        }
                                    }
                                    
                                }
                                viewRouter.notificationT = .None
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
                                        //model.showCard.toggle()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            withAnimation(.easeIn){
                                                //model.showContent = false
                                                
                                            }
                                        }
                                        
                                    }
                                    viewRouter.notificationT = .None
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
                                    //model.showCard.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn){
                                            //model.showContent = false
                                            
                                        }
                                    }
                                    
                                }
                                viewRouter.notificationT = .None
                                viewRouter.currentPage = .ViewProfileM
                            }.foregroundColor(viewRouter.currentPage == .ViewProfileM ? Color("TabBarHighlight") : .gray)
                            
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBackground").shadow(radius: 2))
                        
                    }
                }
            }.edgesIgnoringSafeArea(.all)//zstack
            
        }//end ZStack
    }
    
}

//OfferCard
struct OfferCard: View {
    @EnvironmentObject var model : OfferCarousel
    var card: OfferCardInfo
    var animation: Namespace.ID
    
    var body: some View {
        
        //Card
        VStack{
            //Courier name
            HStack{
                Text("\(model.orderPreview(c: card).OrderId)")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.black.opacity(0.5))
                    .animation(.easeIn)
                Spacer(minLength: 0)
            }.padding(.top,15)
            //Offer price
            HStack {
                Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).padding(.leading)
                Text("\(model.orderPreview(c: card).price)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black.opacity(0.5))
                    .animation(.easeIn) //if the user press it. It shows detailes
                Spacer(minLength: 0)
                
            }.padding(.top,15)
            
            //Offers state
            HStack{
                VStack{
                    //Accept offer button
                    Button(action: {
                        //Call method to change assign in order collection to true, add price and courier to order collection, remove all offers in offers subCollection that has the same orderID
                    }) {
                        Text("Accept")
                            .font(.custom("Roboto Bold", size: 22))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .multilineTextAlignment(.center)
                            .padding(1.0)
                            .frame(width: UIScreen.main.bounds.width - 50)
                            .textCase(.none)
                    }
                    .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                    .padding(.all,25)
                    .offset(x: 0)
                    //deny offer button
                    Button(action: {
                        //Call method to remove this offer from offers subCollection that has the same (orderID and member id and courier id)
                    }) {
                        Text("Decline")
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
                }
                //Spacer(minLength: 0)
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
                //model.showCard.toggle() //change the value of showCard to true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.easeIn){
                        //model.showContent = true
                    }//end with animation
                }//end dispatch
            }//end with animation
        }//end on tap gesture
    }
}

// CurrentCarouselMViewModel
class OfferCarousel: ObservableObject {
    
    //Add obs obje from type member?
    @ObservedObject var order = Order()
    
    //each order has card
    @Published var cards: [OfferCardInfo] = []
    
    // Detail Content....
    @Published var selectedCard = OfferCardInfo(cardColor: .clear)
    
    @Published var haveOffers = false
    @Published var showContent = false
    
    init(){
   
        //order.getOffers(OrderId: selectedCard.OfferInfo.OrderId)
        print("number of offers inside init: \(order.offers.count)")
        getCards()
        
    }
    
    //return order details
    func orderPreview(c: OfferCardInfo) -> Offer {
        return c.OfferInfo
    }
    
    func getCards(){
        //if there are offers change haveOffers=true
        ///Change all this info memberOrder
        print("number of cards inside getCards: \(order.offers.count)")
        if order.offers.isEmpty{
            print("there is no offer")
        }
        
        cards.removeAll()
        for index in order.offers {
            //Check the state of the order
            cards.append(contentsOf: [ OfferCardInfo( cardColor: Color(.white), OfferInfo : index )])
        }
    }
    
}

//current card M info
struct OfferCardInfo: Identifiable {
    var id = UUID().uuidString
    var cardColor: Color
    var offset: CGFloat = 0
    //var price: Int = 0
    //var courierId: String = ""
    //var orderId: String = ""
    var OfferInfo = Offer( id: "", OrderId: "" , memberId: "",courierId: "", price: 0, courierLocation: CLLocationCoordinate2D (latitude: 0.0, longitude: 0.0))// change to get offer info
    
    
    //var OfferInfo = Offer( id: "", OrderId: "" , memberId: "",courierId: "", price: 0, courierLocation: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))// change to get offer info
}

struct Offers_Previews: PreviewProvider {
    static var previews: some View {
        Offers(viewRouter: ViewRouter())
       // Offers(viewRouter: ViewRouter(), orderID: "", status: "")
    }
}
