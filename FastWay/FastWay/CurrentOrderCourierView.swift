//
//  CurrentOrderViewDetailsCourier.swift
//  FastWay
//
//  Created by Ghaida . on 13/07/1442 AH.
//


import SwiftUI
import MapKit

struct CurrentOrderCourierView: View {
    
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var model: CurrentCarouselCViewModel
   // @StateObject var courierOrderModel = CarouselViewModel()
    @Namespace var animation
    //for notification
    @State var show = false
    @State var imgName = "shoppingCart"


    
    var body: some View {
        
        ZStack {
            //Background
            HStack{
                GeometryReader{ geometry in
                    //background
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
                    //CurrentOrderView
                    Text("Current Orders").font(.custom("Roboto Medium", size: 25)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .multilineTextAlignment(.center).position(x:170 ,y:50).offset(x:20,y:20)
                    //white rectangle
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).edgesIgnoringSafeArea(.bottom).offset(y: 100)
                    
                }.edgesIgnoringSafeArea(.all)
                
            }.onAppear(){
                //retrieve ordered assigned to the user
                model.order.getCourierOrderAssign(Id: UserDefaults.standard.getUderId())
                //retrieve order waiting for accept
                model.order.getAllOffersFromCourierInCurrentOrder(){ success in
                    print("inside Delivery order view success ")
                    //if success false return
                    guard success else { return }
                    model.getCards()
                }
                //model.getCards()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    //withAnimation(.easeIn){
                    model.getCards()
                    //}//end with animation
                }
                model.showCard = false
                model.showContent = false
            }
           /* .onChange(of: model.cards.count) { value in
                print("\n\ninside onchange!!!!!!!!!!!\n\n")
                model.order.getCourierOrderAssign(Id: UserDefaults.standard.getUderId())
                //retrieve order waiting for accept
                model.order.getAllOffersFromCourierInCurrentOrder(){ success in
                    print("inside Delivery order view success ")
                    //if success false return
                    guard success else { return }
                    model.getCards()
                }
                //model.getCards()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    //withAnimation(.easeIn){
                    model.getCards()
                    //}//end with animation
                }
            }*/
            
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            //Notification
            VStack{
                
                if show{
                    Notifications(type: notificationT, imageName: self.imgName)
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
            }
        
            //Cancel offer
            .onChange(of: model.notificationMSG, perform: { value in
                if value {
                    if notificationT == .CancelOffer  {
                        animateAndDelayWithSeconds(0.05) {
                            self.imgName = "cancelTick"
                            self.show = true }
                        animateAndDelayWithSeconds(4) {
                            self.show = false
                            model.notificationMSG = false
                            notificationT = .None
                        }
                    }
                }
            })
         /*   .onChange(of: cancelNoti, perform: { value in
                if value {
                    notificationT = .CancelByDefault
                    if notificationT == .CancelByDefault{
                         
                            animateAndDelayWithSeconds(0.05) {
                                self.imgName = "cancelTick"
                                self.show = true }
                            animateAndDelayWithSeconds(4) {
                                self.show = false
                                notificationT = .None
                            }
                        
                    }
                }
            }) */
            
            ///////////////////////////////////////////////////////////////////////////////////////////////
            
            
            // Carousel....
            VStack{
                Spacer()
                ZStack{
                    GeometryReader{ geometry in
                        HStack {
                            ScrollView {
                                
                                ForEach(model.cards.lazy.indices.reversed(),id: \.self) { index in
                                    HStack{
                                        CurrentCardCView(card: model.cards[index], animation: animation)
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
                Spacer()
            }.padding(.bottom,80)
            
            //Press detailes
            if model.showCard && model.assigned == false{
                CurrentCardCDetailes(viewRouter: viewRouter, animation: animation)
            }else{
                if model.showCard && model.assigned == true{
                    //change to the assigned order view
                    CurrentCardCDetailes(viewRouter: viewRouter, animation: animation)
                }
            }
                        
            //notification
            VStack{
                if show{
                    Notifications(type: notificationT, imageName: self.imgName)
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
            }.onAppear(){
                if notificationT == .SendOffer || notificationT == .CancelOffer {
                    animateAndDelayWithSeconds(0.05) { self.show = true }
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
                                    .frame(width: geometry.size.width/5, height: geometry.size.height/28)
                                    .padding(.top, 10)
                                Text("Home")
                                    .font(.footnote)
                                Spacer()
                            }.padding(.horizontal, 14).onTapGesture {
                                withAnimation(.spring()){
                                    model.showCard.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn){
                                            model.showContent = false
                                            
                                        }
                                    }
                                    
                                }
                                notificationT = .None
                                viewRouter.currentPage = .HomePageC
                            }.foregroundColor(viewRouter.currentPage == .HomePageC ? Color("TabBarHighlight") : .gray)
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
                                    model.showCard.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn){
                                            model.showContent = false
                                            
                                        }
                                    }
                                    
                                }
                                notificationT = .None
                                viewRouter.currentPage = .ViewProfileC
                            }.foregroundColor(viewRouter.currentPage == .ViewProfileC ? Color("TabBarHighlight") : .gray)
                            
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBackground").shadow(radius: 2))
                        
                    }
                }
            }.edgesIgnoringSafeArea(.all)//zstack
            //notification here
            VStack{
                if show{
                    Notifications(type: notificationT, imageName: self.imgName)
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
                
                
                
                
            }.onAppear(){
                if notificationT == .SendOffer  {
                    animateAndDelayWithSeconds(0.05) { self.show = true }
                    animateAndDelayWithSeconds(4) { self.show = false }
                }
                if notificationT == .CancelOffer  {
                    animateAndDelayWithSeconds(0.05) { self.show = true }
                    animateAndDelayWithSeconds(4) { self.show = false }
                }

            }

            
        }//end ZStack
    }}

//Current card M View
struct CurrentCardCView: View {
    @EnvironmentObject var model : CurrentCarouselCViewModel
    var card: currentCardC
    var animation: Namespace.ID
    //@State var StateACCEPT = false
    @State var StateWaiting = true
    @State var stat = ""
    var body: some View {
        
        //Card
        VStack{
            //State of the card
            /*HStack{
             Image(systemName: "wait")
             .foregroundColor(Color.black.opacity(0.5))
             .padding(.leading)
             Text("\(card.state)")
             .font(.body)
             .fontWeight(.regular)
             .foregroundColor(Color.black.opacity(0.5))
             .animation(.easeIn)
             Spacer(minLength: 0)
             }.padding(.top,15)*/
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

            
            //Time
          
                Image(uiImage: #imageLiteral(resourceName: "dollar"))
                    .foregroundColor(Color.black.opacity(0.5))
                    .padding(.leading)
                    
                Text("\(model.orderPreview(c: card).deliveryPrice) SR")
                    
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.black.opacity(0.5))
                    .animation(.easeIn)
                
            
                
                Spacer(minLength: 0)
            }.padding(.top,15)
            
            //orderDetailes
            HStack {
                Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).padding(.leading)
                Text("\(model.orderPreview(c: card).orderDetails)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black.opacity(0.5))
                    .frame(maxWidth: 220, maxHeight: 50, alignment: .leading)
                    .animation(.easeIn) //if the user press it. It shows detailes
                Spacer(minLength: 0)
                
            }.padding(.top,15)
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
                
                //to let an arrow in the right of the card
                Spacer(minLength: 0)
                
                if !model.showContent{
                    //have an offer
                    
                    if(self.stat == "assigned"){
                    Text("Detailes").offset(x: 130, y: -10)
                    
                   
                    }
                    
                    
                    else{
                       // Text("Waiting for Accept").offset(x: -130, y: -10)
                    
                        Text("Waiting for Accept")
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        Spacer(minLength: 0)
                        HStack{
                            DotView(frame: 10)
                            DotView(delay: 0.2, frame: 10)
                            DotView(delay: 0.4, frame: 10)
                        }
                        
                     }
                    Image(systemName: "arrow.right")

                    
                    
                }
            }
            .foregroundColor(Color.gray.opacity(0.9))
            .padding(20)
            .onAppear(){
                
                model.getCards()
                self.stat = model.orderPreview(c: card).status
            }
            .onChange(of: model.orderPreview(c: card).status) { value in
                model.getCards()
                self.stat = value
                
            }
            
           
            
            
            
            
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

//Current card M detailes
struct CurrentCardCDetailes: View {
    @EnvironmentObject var model : CurrentCarouselCViewModel
    @StateObject var viewRouter: ViewRouter
    var animation: Namespace.ID
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var distance = ""
    @State var time = ""
    @State var expandOffer = false
    @State var expand = false
    @State private var showingPaymentAlert = false
    @State var stat = ""

    
    var body: some View{
        
        ZStack{
            
            //map
            MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$model.selectedCard.orderD.pickUP, destination: self.$model.selectedCard.orderD.dropOff, distance: self.$distance, time: self.$time)
                .cornerRadius(35)
                .frame(width: 390, height: 300).padding(.bottom, 0)
                .clipped().position(x: 188,y: 100)
                .offset(y: 50)
                .onAppear {
                    
                    self.manager.requestAlwaysAuthorization()
                }
            
            // VStack{
            
            ZStack {
                //go back button
                //arrow_back image
               
                
                Group{
                    RoundedRectangle(cornerRadius: 10).frame(width: 45, height: 35).foregroundColor(Color(.white))
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
                            .frame(width: 30, height: 30)
                            .clipped()
                            .background(Color(.white))
                    }.padding(1.0)
                }.position(x: 50, y: 50)
                
                
                //white background
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).edgesIgnoringSafeArea(.bottom).offset(y: 240).shadow(radius: 2)
                
                VStack{
                    
                    ScrollView{
                        HStack{
                            Image(systemName: "clock")
                                .foregroundColor(Color.black.opacity(0.5))
                                .offset(x: 10, y: 10)
                                .padding(.leading)
                            Text("\(model.selectedCard.orderD.createdAt.calenderTimeSinceNow())")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color.black.opacity(0.5))
                                .animation(.easeIn)
                                .offset(x: 10, y: 10)
                            Spacer(minLength: 0)
                            Spacer(minLength: 0)

                            
                            Image(uiImage: #imageLiteral(resourceName: "dollar"))
                                .foregroundColor(Color.black.opacity(0.5))
                                .offset(x: 10, y: 10)
                                .padding(.leading)
                            
                            Text("\(model.selectedCard.orderD.deliveryPrice) SR")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color.black.opacity(0.5))
                                .animation(.easeIn)
                                .offset(x: 10, y: 10)
                            Spacer(minLength: 0)
                        }
                       
                        
                        //pick up
                        ZStack{
                            RoundedRectangle(cornerRadius: 15).padding().frame(width: 350, height: 160).foregroundColor(.white).shadow(radius: 1)
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 1")).offset(x: -125)
                            HStack {
                                
                                Text("Building \(self.getBuilding(id: model.selectedCard.orderD.pickUpBulding)), \nfloor \(model.selectedCard.orderD.pickUpFloor),  \(model.selectedCard.orderD.pickUpRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 200, alignment: .leading)
                            }
                            
                        }
                        //drop off
                        ZStack{
                            RoundedRectangle(cornerRadius: 15).padding().frame(width: 350, height: 160).foregroundColor(.white).shadow(radius: 1)
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 3")).offset(x: -125)
                            HStack{
                                
                                Text("Building \(self.getBuilding(id: model.selectedCard.orderD.dropOffBulding)), \nfloor \(model.selectedCard.orderD.dropOffFloor),  \(model.selectedCard.orderD.dropOffRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 200, alignment: .leading)
                            }
                            
                        }
                        //order items
                        ZStack{
                           
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).offset(x: -125)
                            HStack() {
                                
                                Text("\(model.selectedCard.orderD.orderDetails)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: 220, alignment: .leading)
                            }
                        }.contentShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: 325)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 1)
                      
                       
                        //make an offer button
                        Button(action: {
                            
                            showingPaymentAlert.toggle()


                           // if(true){
                           //     viewRouter.notificationT =  .CancelOffer

                            //    viewRouter.currentPage = .CurrentOrderCourier
                           // }
                            
                      
                            
                            

                        }) {
                            Text("Cancel Offer")
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
                }.position(x: 188,y: 700)
            }
            
            // }
                       
                   }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).alert(isPresented: $showingPaymentAlert) {Alert(title: Text("Order confirmed"), message: Text("Are you sure you want cancel this offer"), primaryButton: .default((Text("YES")), action: {
                    
                    
                    notificationT =  .CancelOffer
                    
                    canelOffer()
                    
                    model.notificationMSG = true
                    model.showCard = false
                    model.showContent = false
                    
                    
                   }) , secondaryButton: .cancel((Text("NO"))))

        }
        
    }// end body
    func canelOffer(){
        
        model.cancelCardOrderId = model.selectedCard.orderD.id
        model.order.cancelOffer(CourierID: model.selectedCard.orderD.courierId, OrderId: model.selectedCard.orderD.id, MemberID: model.selectedCard.orderD.memberId, Price: model.selectedCard.orderD.deliveryPrice)
        
        
        
        /*model.order.getCourierOrderAssign(Id: UserDefaults.standard.getUderId())
        //retrieve order waiting for accept
        model.order.getAllOffersFromCourierInCurrentOrder(){ success in
            print("inside Delivery order view success ")
            //if success false return
            guard success else { return }
            model.getCards()
        }*/
        //model.getCards()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //withAnimation(.easeIn){
            model.getCards()
            //}//end with animation
        }
}
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

// CurrentCarouselCViewModel
class CurrentCarouselCViewModel: ObservableObject {
    
    //Add obs obje from type member?
    @ObservedObject var order = Order()
    
    //each order has card
    @Published var cards: [currentCardC] = []
    
    // Detail Content....
    @Published var selectedCard = currentCardC(cardColor: .clear)
    //user press details
    @Published var showCard = false
    @Published var showContent = false
    
    @Published var cancelCardOrderId : String = ""
    @Published var notificationMSG =  false
    @Published var assigned = false
    
    
    
    //return order details
    func orderPreview(c: currentCardC) -> OrderDetails {
        return c.orderD
    }
    
    func getCards(){//update CourierOrderOffered
        print("number of cards inside get couerier Cards: \(order.CourierOrderOfferedAssign.count + order.CourierOrderOfferedWaiting.count)")
        
        if order.CourierOrderOfferedAssign.isEmpty{
            print("there is no order in Assign")
        }
        if order.CourierOrderOfferedWaiting.isEmpty{
            print("there is no order in waiting")
        }
        
        cards.removeAll()
        print("number of cards after remove the cards:\(cards.count)")
        for index in order.CourierOrderOfferedWaiting {
            print("index in loop waiting \(index.orderDetails)")
            if ( index.id != "") {
                cards.append(contentsOf: [ currentCardC( cardColor: Color(.white),state : 0, orderD : index )])
            }
        }
        
        for index in order.CourierOrderOfferedAssign {
            print("index in loop assign \(index.orderDetails)")
            cards.append(contentsOf: [ currentCardC( cardColor: Color(.white),state : 0, orderD : index )])
        }
        cards.sort {
            $0.orderD.createdAt < $1.orderD.createdAt
        }
        
    }
    
}


//current card C info
struct currentCardC: Identifiable {
    var id = UUID().uuidString
    var cardColor: Color
    var offset: CGFloat = 0
    //check if not assign then check this varable
    //States [NoOffer=0, Offers=-1, Assigned = 1]
    var state : Int = 0
    var orderD = OrderDetails(id: "", pickUP: CLLocationCoordinate2D (latitude: 0.0, longitude: 0.0), pickUpBulding: 0, pickUpFloor: 0, pickUpRoom: "", dropOff: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), dropOffBulding: 0, dropOffFloor: 0, dropOffRoom: "", orderDetails: "", memberId: "", courierId: "" ,deliveryPrice: 0, isAdded: false, status: "")
}


struct CurrentOrderCourierView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOrderCourierView(viewRouter: ViewRouter())
    }
}

