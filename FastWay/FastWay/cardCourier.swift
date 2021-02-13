//
//  cardCourier.swift
//  FastWay
//
//  Created by Reem on 10/02/2021.
//
import SwiftUI


// CardView
struct CardView: View {
    @EnvironmentObject var model : CarouselViewModel
    var card: Card
    var animation: Namespace.ID
    var body: some View {
        
        
        VStack{
            
            /*Text("Monday 28 December")
                .font(.caption)
                .foregroundColor(Color.black.opacity(0.85))
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
                .padding(.top,10)
                .matchedGeometryEffect(id: "Date-\(card.id)", in: animation)*/
            
            HStack { //title
                
                Text("\(model.getMemberName(Id: card.orderD.memberId)) \n\n \(model.getOrderDetails(c:card))")
                    .fontWeight(.semibold)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding()
                    .animation(.easeIn)
                    .matchedGeometryEffect(id: "Title-\(card.id)", in: animation)
                Spacer(minLength: 0)
            }
            //preview of order details
            Spacer(minLength: 0)
            
            HStack{
                
                Spacer(minLength: 0)
                
                if !model.showContent{
                    
                    Text("Read More")
                    
                    Image(systemName: "arrow.right")
                }
            }
            .foregroundColor(Color.gray.opacity(0.9))
            .padding(20)
        }
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
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    
                    withAnimation(.easeIn){
                        
                        model.showContent = true
                    }
                }
            }
        }
    }
}

// DetailView
struct DetailView: View {
    @EnvironmentObject var model: CarouselViewModel
    var animation: Namespace.ID
    var body: some View {
        
        ZStack {
            ScrollView{
                //content
                VStack{
                    
                    Text("Monday 28 December")
                        .font(.caption)
                        .foregroundColor(Color.black.opacity(0.85))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding()
                        .padding(.top,10)
                        .matchedGeometryEffect(id: "Date-\(model.selectedCard.id)", in: animation)
                    
                    HStack {
                        Text("\(model.getMemberName(Id: model.selectedCard.orderD.memberId))")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .frame(width: 250, alignment: .leading)
                            .padding()
                            .matchedGeometryEffect(id: "Title-\(model.selectedCard.id)", in: animation)
                        
                        Spacer(minLength: 0)
                    }
                    
                    // Detail Text Content....
                    // Showing content Some Delay For Better Animation...
                    
                    if model.showContent{
                        
                        Text(model.getOrderDetails(c:model.selectedCard))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .padding()
                            .animation(.easeIn)
                    }
                    
                    Spacer(minLength: 0)
                    
                    // CLose Button..
                    VStack{
                        
                        if model.showContent{
                            
                            Button(action: CloseView, label: {
                                
                                Image(systemName: "arrow.down")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.blue)
                                    .padding()
                                    .background(Color.white.opacity(0.6))
                                    .clipShape(Circle())
                                    .padding(5)
                                    .background(Color.white.opacity(0.7))
                                    .clipShape(Circle())
                                    .shadow(radius: 3)
                            })
                            .padding(.bottom)
                        }
                        
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 630)
                .background(
                
                    model.selectedCard.cardColor
                        .cornerRadius(25)
                        .matchedGeometryEffect(id: "bgColor-\(model.selectedCard.id)", in: animation)
                        .ignoresSafeArea(.all, edges: .bottom)
                )
                
            }
        }
    }
    
    func CloseView(){
        
        withAnimation(.spring()){
            model.showCard.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                withAnimation(.easeIn){
                    
                    model.showContent = false
                }
            }
        }
    }
}

// CarouselViewModel
class CarouselViewModel: ObservableObject {
    
    @ObservedObject var order = Order()
    
    //orders array here
    //initialize the cards array with orders array
    @Published var cards: [Card] = []//[Card( cardColor: Color("CardColor1")),]
    
    @Published var swipedCard = 0
    
    // Detail Content....
    @Published var showCard = false
    @Published var selectedCard = Card(cardColor: .clear)
    @Published var showContent = false
    
    init(){
        order.getOrder()
        print("number of oreders inside init: \(order.orders.count)")
        getCards()
    }
    
    func getMemberName(Id: String) -> String {
        print("Id: \(Id)")
        return order.getMemberName(Id: Id)
    }
    
    func getOrderDetails(c: Card) -> String{
        //dropOff
        let dropOffB = c.orderD.dropOffBulding
        let dropOffF = c.orderD.dropOffFloor
        let dropOffR = c.orderD.dropOffRoom
        let orderDetails = c.orderD.orderDetails
        //pickUp
        let pickUPB = c.orderD.pickUpBulding
        let pickUPF = c.orderD.pickUpFloor
        let pickUPR = c.orderD.pickUpRoom
        
        let all="OrderDetails: \(orderDetails) \n\n PickUp: \nBulding: \(pickUPB),Floor: \(pickUPF),Room: \(pickUPR) \n\n dropOff: \n Bulding: \(dropOffB),Floor: \(dropOffF),Room: \(dropOffR)"
        return all;
    }
    
    func getMap(c: Card) -> String{
        let dropOff = c.orderD.dropOff
        let pickUP = c.orderD.pickUP
        let all = "" + dropOff + "" + pickUP
        return all
    }
    
    func setOrderOffer(){
        
    }
    
    func getCards(){
        
        print("number of cards inside getCards: \(order.orders.count)")
        if order.orders.isEmpty{
            print("there is no order")
        }
        
        var x = 1
        cards.removeAll()
        for index in order.orders {
            if( x == 10){
                x=1
            }
            print("inside loop added order to card")
            cards.append(contentsOf: [ Card( cardColor: Color("CardColor\(x)"), orderD : index )])
            x+=1
        }
            
        
    }
    
}

struct Card: Identifiable {
    
    var id = UUID().uuidString //takes the order id instead?
    var cardColor: Color
    var offset: CGFloat = 0
    //order object passed from the cards array
    var orderD = OrderDetails(id: "", pickUP: "", pickUpBulding: 0, pickUpFloor: 0, pickUpRoom: "", dropOff: "", dropOffBulding: 0, dropOffFloor: 0, dropOffRoom: "", orderDetails: "", memberId: "", isAdded: false)
}
