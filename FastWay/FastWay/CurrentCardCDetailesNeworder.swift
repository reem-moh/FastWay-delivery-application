//
//  CurrentCardCDetailesNeworder.swift
//  FastWay
//
//  Created by Reem on 19/03/2021.
//
import SwiftUI
import MapKit

//courierrrrr
//Current card c details New order
struct CurrentCardCDetailesNeworder: View {
    @ObservedObject var member = Member(id: "", name: "", email: "", phN: "")
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
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State var stat = ""
    @State var oneDouble = 0.0
    @State var tDouble = 0.0
    //for status
    @State var showAssign = false
    @State var showPickUp = false
    @State var showOnTheWay = false
    @State var showDropOff = false
    @State var showComplete = false
    @State private var changeState = false
    @State private var State = -1
    @State private var StateString = ""
    @State var liveS = ""
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()
    @State var token = ""

    var body: some View{
        
        ZStack{
            
            //map
            Newtracking(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$model.selectedCard.orderD.pickUP, destination: self.$model.selectedCard.orderD.dropOff, distance: self.$distance, time: self.$time, CourierID: self.$model.selectedCard.orderD.courierId)
                .cornerRadius(35)
                .frame(width: width(num:390), height: hieght(num:300)).padding(.bottom, 0)
                .clipped().position(x: width(num:188),y: hieght(num:100))
                .offset(y: hieght(num:50))
                .onAppear(){
                    self.manager.requestAlwaysAuthorization()
                  
                
                }
            
            
            // VStack{
            
            ZStack {
                //go back button
                //arrow_back image
                Group{
                    RoundedRectangle(cornerRadius: 10).frame(width: width(num:45), height: hieght(num:35)).foregroundColor(Color(.white))
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
                            .frame(width: width(num:30), height: hieght(num:30))
                            .clipped()
                            .background(Color(.white))
                    }.padding(1.0)
                }.position(x: width(num:50), y: hieght(num:50))
                .onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.member.getMemberToken(memberId: model.selectedCard.orderD.memberId){ success in
                        print("After getMemberToken in send \(self.member.member.token)")
                        self.token = self.member.member.token
                        guard success else { return }
                    }
                    }
                }
                
                
                //white background
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                    .resizable() //add resizable
                    .frame(width: width(num: 375)) //addframe
                    .edgesIgnoringSafeArea(.bottom).offset(y: hieght(num:240)).shadow(radius: 2)
                
                VStack{
                    
                    ScrollView{
                        //time && price
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

                            
                            
                            Image(uiImage: #imageLiteral(resourceName: "money"))
                                .foregroundColor(Color.black.opacity(0.5))
                                .offset(x: width(num:10), y: hieght(num:10))
                                .padding(.leading)
                            
                            Text("\(model.selectedCard.orderD.deliveryPrice) SR")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color.black.opacity(0.5))
                                .animation(.easeIn)
                                .offset(x: width(num:10), y: hieght(num:10))
                            Spacer(minLength: 0)
                        }
                        //Status
                        ZStack{
                            VStack{
                                HStack{
                                    Text("Status of the order:")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.black.opacity(0.5))
                                        .animation(.easeIn)
                                        .offset(x: width(num:10), y: hieght(num:10))
                                    Spacer(minLength: 0)
                                }
                                
                                //white background
                                RoundedRectangle(cornerRadius: 15)
                                    .padding()
                                    .frame(width: width(num:350), height: hieght(num:350))
                                    .foregroundColor(.white)
                                    .shadow(radius: 1)
                            }
                            //status of the order
                            VStack{
                                Spacer()
                                Spacer()
                                Spacer()
                                Group{
                                    //Assign
                                    HStack{
                                        
                                        Image(systemName: "checkmark.circle.fill" )
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: width(num:30), height: hieght(num:30))
                                            .foregroundColor(Color("ButtonColor"))
                                        
                                        Text("Assigned").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:230), alignment: .leading)
                                    }
                                    Spacer()
                                    //pick up
                                    HStack{
                                        Image(systemName:  self.liveS  == model.order.status[4] || self.liveS  == model.order.status[5] || self.liveS  == model.order.status[6] || self.liveS  == model.order.status[7] ? "checkmark.circle.fill" : "checkmark.circle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: width(num:30), height: hieght(num:30))
                                            .foregroundColor(Color("ButtonColor"))
                                        
                                        Text("Pick up ").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:230), alignment: .leading)
                                     
                                    }.onTapGesture {
                                        State = 4
                                        StateString = "pick Up"
                                        //[0, 1,2,"assigned","pick Up","on The Way" , "drop off", "completed"]
                                        if let row = model.order.status.firstIndex(where: {$0 == model.order.liveStatus}){
                                            if row < State {
                                                alertTitle = "Change State"
                                                alertMessage = "Are you sure you want to change the state of this order?"
                                                showingAlert.toggle()
                                            }
                                            print("model.order.liveStatus State = 4: \(model.order.liveStatus) row: \(row)")
                                        }else{
                                            print("model.order.liveStatus State = 4: \(model.order.liveStatus)")
                                        }
                                        self.liveS = model.order.liveStatus
                                    }
                                    Spacer()
                                    //on the way
                                    HStack{
                                        Image(systemName: self.liveS == model.order.status[5] || self.liveS == model.order.status[6] || self.liveS == model.order.status[7] ? "checkmark.circle.fill" : "checkmark.circle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: width(num:30), height: hieght(num:30))
                                            .foregroundColor(Color("ButtonColor"))
    
                                        Text("On the way").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:230), alignment: .leading)
                                    }.onTapGesture {
                                        State = 5
                                        StateString = "on The Way"
                                        //[0, 1,2,"assigned","pick Up","on The Way" , "drop off", "completed"]
                                        if let row = model.order.status.firstIndex(where: {$0 == model.order.liveStatus}){
                                            if row < State {
                                                alertTitle = "Change State"
                                                alertMessage = "Are you sure you want to change the state of this order?"
                                                showingAlert.toggle()
                                            }
                                            print("model.order.liveStatus State = 5: \(model.order.liveStatus) row: \(row)")
                                        }else{
                                            print("model.order.liveStatus State = 5: \(model.order.liveStatus)")
                                        }
                                        self.liveS = model.order.liveStatus
                                    }
                                    Spacer()
                                }
                                
                                Group{
                                    //drop off
                                    HStack{
                                        Image(systemName: self.liveS == model.order.status[6] || self.liveS == model.order.status[7]  ? "checkmark.circle.fill" : "checkmark.circle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: width(num:30), height: hieght(num:30))
                                            .foregroundColor(Color("ButtonColor"))
                                      
                                        Text("Drop off").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:230), alignment: .leading)
                                    }.onTapGesture {
                                        State = 6
                                        StateString = "drop off"
                                        //[0, 1,2,"assigned","pick Up","on The Way" , "drop off", "completed"]
                                        if let row = model.order.status.firstIndex(where: {$0 == model.order.liveStatus}){
                                            if row < State {
                                                alertTitle = "Change State"
                                                alertMessage = "Are you sure you want to change the state of this order?"
                                                showingAlert.toggle()
                                            }
                                            print("model.order.liveStatus State = 6: \(model.order.liveStatus) row: \(row)")
                                        }else{
                                            print("model.order.liveStatus State = 6: \(model.order.liveStatus)")
                                        }
                                        self.liveS = model.order.liveStatus
                                    }
                                    Spacer()
                                    //delivered
                                    HStack{
                                        Image(systemName: self.liveS == model.order.status[7] ? "checkmark.circle.fill" : "checkmark.circle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: width(num:30), height: hieght(num:30))
                                            .foregroundColor(Color("ButtonColor"))
                                        Text("Delivered").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:230), alignment: .leading)
                                    }.onTapGesture {
                                        State = 7
                                        StateString = "completed"
                                        //[0, 1,2,"assigned","pick Up","on The Way" , "drop off", "completed"]
                                        if let row = model.order.status.firstIndex(where: {$0 == model.order.liveStatus}){
                                            if row < State {
                                                alertTitle = "Change State"
                                                alertMessage = "Are you sure you want to change the state of this order?"
                                                showingAlert.toggle()
                                            }
                                            print("model.order.liveStatus State = 7: \(model.order.liveStatus) row: \(row)")
                                        }else{
                                            print("model.order.liveStatus State = 7: \(model.order.liveStatus)")
                                        }
                                        self.liveS = model.order.liveStatus
                                    }
                                    //Spacer()
                                    HStack{
                                        Text("* please press the status you are in")
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .foregroundColor(Color.black.opacity(0.5))
                                            .animation(.easeIn)
                                    }
                                    Spacer()
                                }
                            }
                        }.onAppear(){
                            model.order.getStatus(courierId: UserDefaults.standard.getUderId(), memberId: model.selectedCard.orderD.memberId, order: model.selectedCard.orderD.orderDetails){ success in
                                print("after calling method getStatus in success")
                                self.liveS = model.order.liveStatus
                                guard success else { return }
                            }
                            self.liveS = model.order.liveStatus
                        }
                        .onChange(of: model.order.liveStatus) { value in
                            self.liveS = value
                        }
                        
                        
                        //pick up
                        ZStack{
                            RoundedRectangle(cornerRadius: 15).padding().frame(width: width(num:350), height: hieght(num:160)).foregroundColor(.white).shadow(radius: 1)
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 1")).offset(x: width(num:-125))
                            HStack {
                                
                                Text("Building \(self.getBuilding(id: model.selectedCard.orderD.pickUpBulding)), \nfloor \(model.selectedCard.orderD.pickUpFloor),  \(model.selectedCard.orderD.pickUpRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:200), alignment: .leading)
                            }
                            
                        }
                        //drop off
                        ZStack{
                            RoundedRectangle(cornerRadius: 15).padding().frame(width: width(num:350), height: hieght(num:160)).foregroundColor(.white).shadow(radius: 1)
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 3")).offset(x: width(num:-125))
                            HStack{
                                
                                Text("Building \(self.getBuilding(id: model.selectedCard.orderD.dropOffBulding)), \nfloor \(model.selectedCard.orderD.dropOffFloor),  \(model.selectedCard.orderD.dropOffRoom)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:200), alignment: .leading)
                            }
                            
                        }
                        //order items
                        ZStack{
                           
                            Image(uiImage: #imageLiteral(resourceName: "IMG_0528 copy 2 1")).offset(x: width(num:-125))
                            HStack() {
                                
                                Text("\(model.selectedCard.orderD.orderDetails)").multilineTextAlignment(.leading).frame(minWidth: 0, maxWidth: width(num:220), alignment: .leading)
                            }
                        }.contentShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: width(num:325))
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 1)
                      
                       
                        //cancel button
                        HStack{
                            Spacer(minLength: 0)
                            Button(action: {
                                alertTitle = "Order confirmed"
                                alertMessage = "Are you sure you want cancel this order"
                                //showingAlert.toggle()
                                showingAlert = true
                               
                            }) {
                                Text("Cancel order")
                                    .font(.custom("Roboto Bold", size: fontSize(num:22)))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                    .multilineTextAlignment(.center)
                                    .padding(1.0)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                                    .textCase(.none)
                            }
                            .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild"))
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.width - 84, height: hieght(num: 50)))
                            .padding(.top,25)
                            .offset(x: 0)
                            .padding(.bottom,450)
                        }
                        
                        
                        
                    }
                }.position(x: width(num:188),y: hieght(num:700))
                
                //Chat
                Group{
                    
                    
                    Button(action: {
                        model.showChat.toggle()
                        
                   }) {
                        ZStack{
                            Circle()
                            .frame(width: width(num:60), height:hieght(num: 60))
                                .foregroundColor(Color(.white))
                                .shadow(radius: 1)
                            Image(systemName: "message.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: width(num:50), height: hieght(num:50))
                                .foregroundColor(Color("ButtonColor"))
                                //.clipped()
                        }
                       
                           //.background(Color(.white))
                   }.padding(1.0)
               }.position(x: width(num:35), y: hieght(num:650))
            }
  
       }.edgesIgnoringSafeArea(.all)
        .alert(isPresented: $showingAlert) {Alert(title: Text(alertTitle), message: Text(alertMessage), primaryButton: .default((Text("YES")), action: {
            if alertTitle == "Order confirmed"{
                model.cancelOrder(Id:  model.selectedCard.orderD.id)
                notificationT =  .CancelOrder
                model.notificationCancel = true
                model.showCard = false
                model.showContent = false
                //send notification to member
                sendMessageTouser(to: self.token, title: "Order Canceled", body: "The order \(model.selectedCard.orderD.orderDetails.suffix(20)).. has been canceled by the courier")
            }
            else {
                model.order.changeState(OrderId: model.selectedCard.orderD.id, Status: StateString){ success in
                    print("after calling method changeState in success")
                    guard success else { return }
                    model.order.getStatus(courierId: UserDefaults.standard.getUderId(), memberId: model.selectedCard.orderD.memberId, order: model.selectedCard.orderD.orderDetails){ success in
                        print("after calling method getStatus in success")
                        self.liveS = model.order.liveStatus
                        guard success else { return }
                    }
                    self.liveS = model.order.liveStatus
                }
                if(State == 6 ){
                    //send notification to member
                    sendMessageTouser(to: self.token, title: "Order Arrived", body: "The order \(model.selectedCard.orderD.orderDetails.suffix(20)).. is at the drop off location")
                }
            }

            
                   }) , secondaryButton: .cancel((Text("NO"))))

        }
        
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
