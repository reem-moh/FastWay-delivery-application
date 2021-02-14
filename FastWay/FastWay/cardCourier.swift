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
                Text("\(model.orderPreview(c: card).orderDetails)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black.opacity(0.5))
                    .animation(.easeIn) //if the user press it it show Detail
                    
            }.padding(.top,15)
            
            //location
            VStack {
                if( model.showMap ){
                    HStack {
                        //Spacer(minLength: 0)
                        Text("Bulding \(model.orderPreview(c: card).pickUpBulding)\t\t\t\t\t\tBulding \(model.orderPreview(c: card).dropOffBulding)")
                            .fontWeight(.light)
                            .foregroundColor(Color.black.opacity(0.5))
                            .animation(.easeIn) //if the user press it it show Detail
                        //Spacer(minLength: 0)
                    }.padding(5)
                    Image(uiImage: #imageLiteral(resourceName: "PickUp&DropOffPreview"))
                    .animation(.easeIn)
                    //.padding(10)
                    
                }//end if statment
                
            }.padding(15)//end v stack for pickup&dropOff image
            
            HStack{
                
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
                model.showMap.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    
                    withAnimation(.easeIn){
                        
                        model.showContent = true
                        model.showMap = false
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
                    
                    HStack {
                        Text("")
                            .font(.headline)
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
                        
                        ScrollView{
                            Image(uiImage: #imageLiteral(resourceName: "map"))
                                .padding()
                                .animation(.easeIn)
                            
                            Text(model.getOrderDetails(c:model.selectedCard))
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .padding()
                                .padding(.trailing)
                                .animation(.easeIn)
                            
                            VStack(spacing: 0){
                         

                                HStack() {
                                    Text("Offer").font(.custom("Roboto Medium", size: 18)).fontWeight(.bold).multilineTextAlignment(.leading).frame(width: 295, height: 6)
                                    Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
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
                                                }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).frame(width: 297, height: 30)
                                                
                                            }
                                    
                                    
                                    }.frame(width: 300, height: 70)
                                    }.offset(x: -15, y: 10.0)
                                }
                            
                            }.padding().background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).colorMultiply(.init(#colorLiteral(red: 0.9654662013, green: 0.9606762528, blue: 0.9605932832, alpha: 1)))
                            
                            //make an offer button
                            Button(action: {
                                //
                            }) {
                                Text("Make an Offer").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.none)
                            }
                            .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                            .padding(.top,25).offset(x: 0).padding(.bottom,50)
                            
                            // CLose Button..
                            VStack{
                                
                                if model.showContent{
                                    
                                    Button(action: CloseView, label: {
                                        
                                        Image(systemName: "arrow.left")
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(.gray)
                                            .padding()
                                            //.background(Color.white.opacity(0.6))
                                            //.clipShape(Circle())
                                            .padding(5)
                                            //.background(Color.white.opacity(0.7))
                                            //.clipShape(Circle())
                                            .shadow(radius: 3)
                                    })
                                    .padding(.bottom)
                                }
                                
                                
                            }.padding(.bottom,100)
                            
                        }//end scroll
                        
                        
                    }// end show content
                    
                    Spacer(minLength: 0)
                    
                   
                    
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
    
    func CloseView(){
        
        withAnimation(.spring()){
            model.showCard.toggle()
            model.showMap.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                withAnimation(.easeIn){
                    
                    model.showContent = false
                    model.showMap = true
                }
            }
        }
    }
}

// CarouselViewModel
class CarouselViewModel: ObservableObject {
    
    @ObservedObject var order = Order()
   // @ObservedObject var member: Member
    
    //orders array here
    //initialize the cards array with orders array
    @Published var cards: [Card] = []//[Card( cardColor: Color("CardColor1")),]
    
    @Published var swipedCard = 0
    
    // Detail Content....
    @Published var showCard = false
    @Published var selectedCard = Card(cardColor: .clear)
    @Published var showContent = false
    @Published var showMap = true
    
    init(){
        //member = Member()
        order.getOrder() //if this in onapear then delete it
        print("number of oreders inside init: \(order.orders.count)")
        getCards()
       
    }
    
    func getMemberName(name: String) -> String {
        print("name: \(name)")
        return ""
        //return order.getMemberName(Id: Id)
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
        
        let all="\n \(orderDetails) \n\n PickUp: \nBulding: \(pickUPB),Floor: \(pickUPF),Room: \(pickUPR) \n\n dropOff: \n Bulding: \(dropOffB),Floor: \(dropOffF),Room: \(dropOffR)"
        return all;
    }
    
    func orderPreview(c: Card) -> OrderDetails {
        return c.orderD
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
            //member = Member(id: index.memberId)
           // member.name = "Reem algabani"
           // print("member name inside getCards: " + member.name)
            cards.append(contentsOf: [ Card( cardColor: Color("CardColor"), orderD : index )])
            x+=1
            
        }
            
        
    }
    
}

struct Card: Identifiable {
    
    var id = UUID().uuidString //takes the order id instead?
    var cardColor: Color
    var offset: CGFloat = 0
   // var memberName: String
    //order object passed from the cards array
    var orderD = OrderDetails(id: "", pickUP: "", pickUpBulding: 0, pickUpFloor: 0, pickUpRoom: "", dropOff: "", dropOffBulding: 0, dropOffFloor: 0, dropOffRoom: "", orderDetails: "", memberId: "", isAdded: false)
}
