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
            
            Text("Monday 28 December")
                .font(.caption)
                .foregroundColor(Color.black.opacity(0.85))
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
                .padding(.top,10)
                .matchedGeometryEffect(id: "Date-\(card.id)", in: animation)
            
            HStack { //title
                Text("\(card.orderD.id)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .frame(width: 250, alignment: .leading)
                    .padding()
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
            .padding(30)
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
                        Text("Order 1")
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
                        
                        Text(model.getOrderDetails(Id:model.selectedCard.id))
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
    @Published var checkEndGeyOrder = false
    
    init(){
        
        order.getOrder()
        //if (checkEndGeyOrder){
            print("oreders \(order.orders.count)")
            getCards()
       // }
        
        
    }
    
    func getTitle(Id: String) -> String{
        return "gg";
    }
    
    func getOrderDetails(Id: String) -> String{
        let order1 = cards[0].orderD
        let id = "ID: \(order1.id)"
        let pick = "Pick: \(order1.pickUP)"
        _ = "drop: \(order1.dropOff)"
        _ = "is added: \(order1.isAdded)"
        let all=id+"\n"+pick+"\n"
        return all;
        //return "";
    }
    
    func setOrder(){
        
    }
    
    func getCards(){
        
        print("\(order.orders.count)")
        if order.orders.isEmpty{
            print("there is no order")
        }//else {
            //var x =0
        for index in order.orders {
                print("inside loop")
                cards.append(contentsOf: [ Card( cardColor: Color("CardColor1"), orderD : index )])
            }
            
       // }
        
    }
    
}

struct Card: Identifiable {
    
    var id = UUID().uuidString //takes the order id instead?
    var cardColor: Color
    var offset: CGFloat = 0
    //order object passed from the cards array
    var orderD = OrderDetails(id: "", pickUP: "", pickUpBulding: 0, pickUpFloor: 0, pickUpRoom: "", dropOff: "", dropOffBulding: 0, dropOffFloor: 0, dropOffRoom: "", orderDetails: "", isAdded: false)
}
