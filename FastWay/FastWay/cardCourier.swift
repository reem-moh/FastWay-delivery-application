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
        
        //Card
        VStack{
            //orderDetails
            HStack {
                Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).padding(.leading)
                Text("\(model.orderPreview(c: card).orderDetails)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black.opacity(0.5))
                    .animation(.easeIn) //if the user press it it show Detail
                Spacer(minLength: 0)
            }.padding(.top,15)
            
            //location
            VStack {
                    
                    Image(uiImage: #imageLiteral(resourceName: "IMG_0526 1"))
                    .animation(.easeIn)
                    HStack {
                        Text("Bulding \(model.orderPreview(c: card).pickUpBulding)\t\t\t\t\t\tBulding \(model.orderPreview(c: card).dropOffBulding)")
                            .fontWeight(.light)
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
                model.selectedCard.cardColor = Color(.white)
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

// DetailView
struct DetailView: View {
    @EnvironmentObject var model: CarouselViewModel
    var animation: Namespace.ID
    
    //for drop down menu
    @State var expandOffer = false
    @State var expand = false
    @State var offer = 0
    @State var offerList : String = ""
    
    var body: some View {
        
        ZStack {
            
                //content
                VStack{
                    
                    if model.showContent{
                        
                        // CLose Button..
                        VStack{
                            
                            Button(action: CloseView, label: {
                                    
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.gray)
                                    .padding(.horizontal,18)
                                    .shadow(radius: 2)
                                // to let the arrow left the card
                                Spacer(minLength: 0)
                                
                            })
                        }.padding(.top,25)
                        
                        //Detiles card
                        ScrollView{
                            //map
                            Image(uiImage: #imageLiteral(resourceName: "map"))
                                .padding(.top,20)
                                .animation(.easeIn)
                            
                            //orderDetails
                            Text(model.getOrderDetails(c:model.selectedCard))
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .padding()
                                .padding(.trailing)
                                .animation(.easeIn)
                            
                            //Offer price
                            VStack(spacing: 0){
                         
                                HStack() {
                                    Text("Offer")
                                        .font(.custom("Roboto Medium", size: 18))
                                        .fontWeight(.bold).multilineTextAlignment(.leading)
                                        .frame(width: 295, height: 6)
                                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                                        .resizable()
                                        .frame(width: 13, height: 6)
                                }.onTapGesture {
                                    self.expand.toggle()
                                    self.expandOffer = false
                                }
                                if (expand && !expandOffer) {
                                    Group {
                                    ScrollView {
                                                                               
                                            ForEach((1...20), id: \.self) { i in
                                               
                                                Button(action: {
                                                    self.expand.toggle()
                                                    offer = i
                                                    offerList="\(i) SAR"
                                                })
                                                {
                                                    Text("\(i) SAR").padding(5)
                                                }
                                                .foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                                .frame(width: 297, height: 30)
                                                
                                            }//end for each
                                        }.frame(width: 300, height: 70)//end scroll view
                                    }.offset(x: -15, y: 10.0)//end group
                                }//end if statment
                            
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color(.gray), lineWidth: 1))
                            .colorMultiply(.init(#colorLiteral(red: 0.9654662013, green: 0.9606762528, blue: 0.9605932832, alpha: 1)))
                            
                            //make an offer button
                            Button(action: {
                                //Call DB
                            }) {
                                Text("Make an Offer")
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
                            .padding(.bottom,100)

                        }//end scroll
                        
                        
                    }// end if statment of show content
                    
                }//end vstack
                .frame(maxWidth: .infinity, maxHeight: 630)
                .background(
                    model.selectedCard.cardColor
                        .cornerRadius(25)
                        //to add animation
                        .matchedGeometryEffect(id: "bgColor-\(model.selectedCard.id)", in: animation)
                        .ignoresSafeArea(.all, edges: .bottom)
                )
                
        }//end zStack
    }//end body
    
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
    
    //each order has card
    @Published var cards: [Card] = []
    
    // Detail Content....
    @Published var showCard = false
    @Published var selectedCard = Card(cardColor: .clear)
    @Published var showContent = false
    
    init(){
       
        order.getOrder()
        print("number of oreders inside init: \(order.orders.count)")
        getCards()
       
    }
    
    //Delete this method? because we have orderPerview return order
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
        
        let all="\n \(orderDetails) \n\n PickUp: \nBulding: \(pickUPB),Floor: \(pickUPF),Room: \(pickUPR) \n\n dropOff: \n Bulding: \(dropOffB),Floor: \(dropOffF),Room: \(dropOffR)"
        return all;
    }
    
    func orderPreview(c: Card) -> OrderDetails {
        return c.orderD
    }
    
    //check if map return string ?
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
        
        cards.removeAll()
        for index in order.orders {
            cards.append(contentsOf: [ Card( cardColor: Color("CardColor"), orderD : index )])
        }
    }
    
}

struct Card: Identifiable {
    
    var id = UUID().uuidString
    var cardColor: Color
    var offset: CGFloat = 0
    var orderD = OrderDetails(id: "", pickUP: "", pickUpBulding: 0, pickUpFloor: 0, pickUpRoom: "", dropOff: "", dropOffBulding: 0, dropOffFloor: 0, dropOffRoom: "", orderDetails: "", memberId: "", isAdded: false)
}
