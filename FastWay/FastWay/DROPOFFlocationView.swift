//
//  AddNewOrderView.swift
//  FastWay
//
//  Created by Shahad AlOtaibi on 20/06/1442 AH.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import MapKit
import CoreLocation

//var order = Order()

struct DROPOFFlocationView: View {
    
    
    
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    
    
    @State var bulding = 0
    @State var floorNum = -1
    //@State var room = ""
    @State var Floor = "Floor"
    @ObservedObject var room = TextfieldManager(limit: 40)
    
    @State var location = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    @State var errorlocation = false
    @State var errorlocation1 = false
    @State var errorlocation2 = false
    @State var errorBuldingPick = false
    @State var errorFloorPick = false
    @State var errorRoomPick = false
    @State var lErr = ""
    @State var bErr = ""
    @State var fErr = ""
    @State var rErr = ""
    
    @StateObject var viewRouter: ViewRouter
    
    //for drop down menu
    @State var expandFloor = false
    @State var expand = false
    @State var buldingNum = 0
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()
    
    var columns = Array(repeating: GridItem(.flexible()), count: 1)
    @State var text = ""
    
    
    var body: some View {

        ZStack{
            
            
            
            
            ZStack{
                
                
                VStack{
                    //background image
                    Image("Rectangle 49")
                        .resizable() //add resizable
                        .frame(width: width(num: 375)) //addframe
                        .ignoresSafeArea()
                    Spacer()
                }//END VStack
                .onAppear(){
                    checkOrders(ID:  UserDefaults.standard.getUderId())
                }
                
                
                
                VStack{
                    //arrow_back image
                    Button(action: {
                        notificationT = .None
                        viewRouter.currentPage = .AddNewOrder
                        
                        pickAndDrop = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
                    }) {
                        Image("arrow_back")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width(num: 30) , height: hieght(num: 30))
                            .clipped()
                    }.position(x:width(num: 30)  ,y:hieght(num: 20))
                    
                    
                    
                    Text("Drop off location ").font(.custom("Roboto Medium", size: fontSize(num: 25) )).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading,width(num: 12.0) ).offset(x:width(num: 0) ,y:hieght(num: -735))
                    
                    
                    
                }//END VStack
                
                //white background
                Image("Rectangle 48").resizable().aspectRatio(contentMode: .fill).offset(y:hieght(num:45))
                Image("progressBar2")
                    .resizable()
                    .frame(width: width(num: UIImage(named: "progressBar2")!.size.width ), height: hieght(num: UIImage(named: "progressBar2")!.size.height))
                    .position(x: UIScreen.main.bounds.width/2, y: hieght(num: 80))
                    .offset(x: width(num: 10))
                
                
                
                
                
                //MAP
                ZStack{
                    
                    
                    
                    
                    EntireMapView(map: self.$map, manager: self.$manager)
                        .frame(width: width(num: 380), height: hieght(num: 350), alignment: .center)
                        .clipped().offset(y: hieght(num: 90))
                    
                    
                    Text("Select location:").font(.custom("Roboto Medium", size: fontSize(num: 18))).fontWeight(.bold).multilineTextAlignment(.leading).frame(width: width(num: 295), height:  hieght(num: 6))
                        .offset(x: width(num: -115),y:hieght(num: -75))
                    
                    
                    
                    if errorlocation1{
                        Text(lErr).font(.custom("Roboto Regular", size: fontSize(num: 18)))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x:width(num: -10),y:hieght(num: -55)) }
                    
                    
                    if(errorlocation2)&&(errorlocation==false)&&(errorlocation1==false){
                        Text(lErr).font(.custom("Roboto Regular", size: fontSize(num: 18)))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x:width(num: -65),y: hieght(num: -55)) }
                    
                    
                    
                    if (errorlocation)&&(errorlocation1==false){
                        Text(lErr).font(.custom("Roboto Regular", size: fontSize(num: 18)))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x:width(num: -65),y: hieght(num: -55)) }
                    
                    
                    
                }.offset(x:width(num: 0),y: hieght(num: -180))
                
                
            }
            
            
            
            //white rectangle
            Spacer(minLength: 100)
            Image("Rectangle 48").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/).offset(x:width(num: 0),y: hieght(num: 450))
            
            VStack(spacing: 10){
                
                
                
                
                
                
                
                // Bulding
                VStack(spacing: -10){
                    
                    
                    
                    //Show Error message if no bulding selected
                    if errorBuldingPick && !errorlocation && !errorlocation1 && !errorlocation2 {
                        Text(bErr).font(.custom("Roboto Regular", size: fontSize(num: 18)))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x:width(num: -95),y: hieght(num: -10))
                    }
                    
                    
                    
                    VStack(spacing: 0){
                        
                        
                        HStack() {
                            
                            
                            Button(action: {
                                
                                self.DROPOFFlocation()
                                
                            }){
                                TextField("Search Building here", text: $text).font(.custom("Roboto Regular", size: fontSize(num: 18))).foregroundColor(.black).multilineTextAlignment(.leading).frame(width:width(num: 295) , height:hieght(num: 6))
                            }
                            
                            
                            
                            Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width:width(num: 13) , height: hieght(num: 6))
                        }.onTapGesture {
                            self.expand.toggle()
                            self.expandFloor = false
                        }
                        if (expand && !expandFloor) {
                            Group {
                                ScrollView {
                                    
                                    
                                    LazyVGrid(columns: columns, spacing: 10){
                                        ForEach(fData.filter({ "\($0)".contains(text) || text.isEmpty})){ Bulding in
                                            ZStack(){
                                                VStack {
                                                    
                                                    HStack {         //2
                                                        Button(action: {
                                                            self.expand.toggle()
                                                            bulding = Bulding.id
                                                            text=Bulding.title
                                                            
                                                        })
                                                        {
                                                            Text(Bulding.title).font(.custom("Roboto Regular", size: fontSize(num:13 ) )).foregroundColor(.black).padding(5)
                                                        }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))}
                                                }
                                                
                                                
                                                
                                            }
                                            
                                            
                                            
                                            
                                            
                                        }
                                    }
                                    
                                    
                                    
                                    
                                    
                                }.frame(width:width(num: 300) , height:hieght(num: 70))
                            }.offset(x:width(num: -5) , y:hieght(num: 10.0))
                        }
                        
                    }.padding().background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).colorMultiply(.init(#colorLiteral(red: 0.9654662013, green: 0.9606762528, blue: 0.9605932832, alpha: 1)))
                    
                    
                    
                    
                    
                }// END Bulding
                
                
                
                
                
                
                
                
                //Floor
                VStack(spacing: -10){
                    
                    
                    //Show Error message if no floor selected
                    if errorFloorPick && !errorBuldingPick && !errorlocation && !errorlocation1 && !errorlocation2{
                        Text(fErr).font(.custom("Roboto Regular", size: fontSize(num: 18)))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: width(num: -105),y:hieght(num: -10))
                    }
                    
                    
                    
                    VStack(spacing: 0){
                        HStack() {
                            
                            Button(action: {
                                
                                self.PICKUPlocationBuilding()
                            }){
                                Text(Floor).font(.custom("Roboto Medium", size: fontSize(num: 18))).foregroundColor(.black).fontWeight(.bold).multilineTextAlignment(.center).frame(width: width(num: 295) , height: hieght(num: 6)).offset(x:width(num: -130) , y:hieght(num: 0))
                            }
                            
                            
                            
                            Image(systemName: expandFloor ? "chevron.up" : "chevron.down").resizable().frame(width: width(num: 13) , height: hieght(num: 6))
                        }.onTapGesture {
                            self.expandFloor.toggle()
                            self.expand = false
                        }
                        if (expandFloor && !expand) {
                            Group{
                                ScrollView {
                                    //1
                                    Button(action: {
                                        self.expandFloor.toggle()
                                        floorNum = 0
                                        Floor="0"
                                    })
                                    {
                                        Text("0").padding(3)
                                    }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                    
                                    //2
                                    Button(action: {
                                        self.expandFloor.toggle()
                                        floorNum = 1
                                        Floor="1"
                                        
                                    })
                                    {
                                        Text("1").padding(3)
                                    }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                    
                                    //3
                                    Button(action: {
                                        self.expandFloor.toggle()
                                        floorNum = 2
                                        Floor="2"
                                        
                                    })
                                    {
                                        Text("2").padding(3)
                                    }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                    
                                    //4
                                    Button(action: {
                                        self.expandFloor.toggle()
                                        floorNum = 3
                                        Floor="3"
                                        
                                    })
                                    {
                                        Text("3").padding(3)
                                    }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).frame(width: width(num: 297) , height: hieght(num: 30))
                                    
                                }.frame(width: width(num: 300), height: hieght(num: 70))
                            }.offset(x: width(num: -10), y: hieght(num: 10.0))
                        }
                    }.padding().background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).colorMultiply(.init(#colorLiteral(red: 0.9654662013, green: 0.9606762528, blue: 0.9605932832, alpha: 1)))
                    
                    
                }//END Floor
                
                
                
                
                
                
                VStack(spacing: -10){
                    
                    //Show Error message if the ROOM feild empty
                    if errorRoomPick && !errorFloorPick && !errorBuldingPick && !errorlocation && !errorlocation1 && !errorlocation2 {
                        Text(rErr).font(.custom("Roboto Regular", size: fontSize(num: 18)))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: width(num: -75) ,y:hieght(num: -10))
                    }
                    
                    Button(action: {
                        self.PICKUPlocationFloor()
                    })
                    {
                        //room numbers
                        TextField("room numbers , more details...", text: $room.text)
                            .font(.system(size: fontSize(num: 18))).foregroundColor(.black)
                            .padding(12)
                            .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).keyboardType(.default).padding(.horizontal,width(num: 14) ).offset(x: width(num: 0),y:hieght(num: 0))
                        
                    }}
                
                
                
                VStack(spacing: -10){
                    
                    //NEXT
                    Button(action: {
                        print("helooooooo")
                        location = pickAndDrop
                        self.DROPOFFlocation()
                        self.PICKUPlocationBuilding()
                        self.PICKUPlocationFloor()
                        self.PICKUPlocationRoom()
                        
                        
                        if (!errorlocation && !errorRoomPick && !errorBuldingPick && !errorFloorPick ) {
                            
                            
                            if (order.setDropOffAndDropOffDetails(dropOff: location, dropOffBulding: bulding, dropOffFloor: floorNum, dropOffRoom: room.text)){
                                print("drop up saved")
                                notificationT = .None
                                viewRouter.currentPage = .SendOrder
                            }
                            
                            else
                            {
                                print("drop up not saved")
                                
                            }
                            
                        }
                        
                    })   {
                        Text("Next").font(.custom("Roboto Bold", size: fontSize(num: 22) )).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                    .padding(.top,hieght(num: 25) )
                    //END NEXT
                    
                    
                    
                }  //END NEXT
                
                
                
                
                
                
                
                
            }.offset(x: width(num: 0) ,y: hieght(num: 215))
            
            
            
            
            
            
        }//END ZStack
        .onAppear(){
            //for the in app notification
            //call it before get notification
            /*UNUserNotificationCenter.current().delegate = delegate
           getNotificationMember(memberId: UserDefaults.standard.getUderId()){ success in
                print("after calling method get notification")
                guard success else { return }
            }*/
        }
  
    }//END BODY
    
    
    
    
    func DROPOFFlocation(){
        
        self.errorlocation = false
        self.errorlocation1 = false
        self.errorlocation2 = false
        
        
        
        
        if(!isInRegion(map: map, coordinate: map.userLocation.coordinate)){
            print(location)
            self.lErr="*Your current location\'s out of the campus "
            self.errorlocation1 = true
        }
        
        
        if((errorlocation1==false)&&(!isInRegion(map: map, coordinate: location))){
            print(location)
            self.lErr="*The region out of our service "
            self.errorlocation2 = true
        }
        
        
        
        
        
        
        
        if ((errorlocation1==false)&&(self.location.latitude == 0 && self.location.longitude == 0) ) {
            print(location)
            self.lErr="*must enter Drop off location"
            self.errorlocation = true
        }
        
        
        
        
        
        
    }
    
    
    
    func PICKUPlocationBuilding(){
        
        
        
        
        self.errorBuldingPick = false
        
        if self.bulding == 0 {
            self.bErr="*must select building"
            self.errorBuldingPick = true
        }
        
        
        
    }
    
    
    
    func PICKUPlocationFloor(){
        
        
        
        
        self.errorFloorPick = false
        
        if self.floorNum == -1 {
            self.fErr="*must select floor"
            self.errorFloorPick = true
        }
        
    }
    
    
    func PICKUPlocationRoom(){
        
        
        
        self.errorRoomPick = false
        
        if self.room.text.count == 0 {
            self.rErr="*must enter more details"
            self.errorRoomPick = true
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    struct Bulding: Identifiable {
        //   var id = UUID()
        var title: String
        var id: Int
        
    }
    
    
    var fData = [
        Bulding(title: "College Of Sciences 5", id: 5),
        Bulding(title: "College Of Computer and Information Sciences 6", id: 6),
        Bulding(title: "College Of Pharmacy 8", id: 8 ),
        Bulding(title: "College Of Medicine 9", id: 9),
        Bulding(title: "College Of Dentistry 10", id: 10),
        Bulding(title: "College Of Applied Medical Science 11", id: 11),
        Bulding(title: "College Of Education", id: 12),
        Bulding(title: "COLLEGE OF ARTS", id: 13),
        Bulding(title: "COLLEGE OF LANGUAGES AND TRANSLATION", id: 14),
        Bulding(title: "COLLEGE OF BUSINESS ADMINISTRATION", id: 15),
        Bulding(title: "College of Sports Sciences and Physical Activity", id: 16),
        Bulding(title: "College of Law and Political Sciences", id: 17),
        
        
        
        
    ]
}



struct DROPOFFlocationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DROPOFFlocationView(viewRouter: ViewRouter())
        }
    }
}

