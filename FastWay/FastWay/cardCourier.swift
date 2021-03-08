//
//  cardCourier.swift
//  FastWay
//
//  Created by Reem on 10/02/2021.
//
import SwiftUI
import MapKit


// CardView
struct CardView: View {
    @EnvironmentObject var model : CarouselViewModel
    // @StateObject var viewRouter: ViewRouter
    var card: Card
    var animation: Namespace.ID
    
    var body: some View {
        
        //Card
        VStack{
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
            //orderDetails
            HStack {
                Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).padding(.leading)
                Text("\(model.orderPreview(c: card).orderDetails)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black.opacity(0.5))
                    .frame(maxWidth: 220, maxHeight: 50, alignment: .leading)
                    .animation(.easeIn) //if the user press it it show Detail
                Spacer(minLength: 0)
                
            }.padding(.top,15)
            
            //location
            VStack {
                
                Image(uiImage: #imageLiteral(resourceName: "IMG_0526 1"))
                    .animation(.easeIn)
                HStack {
                    Text("Building \(model.orderPreview(c: card).pickUpBulding)\t\t\t\t\t Building \(model.orderPreview(c: card).dropOffBulding)")
                        .fontWeight(.bold)
                        .foregroundColor(Color.black.opacity(0.5))
                        .animation(.easeIn) //if the user press it it show Detail
                }.padding(5)
                
            }.padding(15)//end v stack for pickup&dropOff image
            
            
            
            
            HStack{
                
                //to let an arrow in the right of the card
                Spacer(minLength: 0)
                
                if !model.showContent{
                    
                    Text("Intrested")
                    
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

// CarouselViewModel
class CarouselViewModel: ObservableObject {
    
    @ObservedObject var order = Order()
    
    //each order has card
    @Published var cards: [Card] = []
    
    // Detail Content....
    @Published var showCard = false
    @Published var selectedCard = Card(cardColor: .clear)
    @Published var showContent = false
    
    init(){
        
        //order.getOrder()
        print("number of oreders inside init: \(order.orders.count)")
        getCards()
        
    }
    
    //return order details
    func orderPreview(c: Card) -> OrderDetails {
        return c.orderD
    }
    
    func getCards(){
        
        print("number of cards inside getCards: \(order.orders.count)")
        if order.orders.isEmpty{
            print("there is no order")
        }
        //"CardColor"
        cards.removeAll()
        for index in order.orders {
            if index.id != "" {
                cards.append(contentsOf: [ Card( cardColor: Color(.white), orderD : index )])
                
            }
            
        }
        print("num of deliver cards \(cards.count)")
    }
    
}

//Card info
struct Card: Identifiable {
    
    var id = UUID().uuidString
    var cardColor: Color
    var offset: CGFloat = 0
    var orderD = OrderDetails(id: "", pickUP: CLLocationCoordinate2D (latitude: 0.0, longitude: 0.0), pickUpBulding: 0, pickUpFloor: 0, pickUpRoom: "", dropOff: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), dropOffBulding: 0, dropOffFloor: 0, dropOffRoom: "", orderDetails: "", memberId: "", isAdded: false, status: "")
}
