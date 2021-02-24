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

var order = Order()

struct AddNewOrderView: View {
    
    
    
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    
    
    @State var bulding = 0
    @State var floorNum = -1
    //@State var room = ""
    @State var Floor = "Floor"
    @ObservedObject var room = TextfieldManager(limit: 40)
    
    
    @State var location = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    @State var errorlocation = false
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
    
    
    var columns = Array(repeating: GridItem(.flexible()), count: 1)
    @State var text = ""
    
    
    var body: some View {
        
        
        
        ZStack{
            
            
            
            
            ZStack{
                
                
                VStack{
                    //background image
                    Image("Rectangle 49").ignoresSafeArea()
                    Spacer()
                }//END VStack
                
                
                
                VStack{
                    //arrow_back image
                    Button(action: {
                        viewRouter.currentPage = .HomePageM
                        
                        pickAndDrop = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
                    }) {
                        Image("arrow_back")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipped()
                    }.position(x:30 ,y:20)
                    
                    
                    
                    Text("Pick up location ").font(.custom("Roboto Medium", size: 25)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:0 ,y:-735)
                    
                    
                    
                }//END VStack
                
                
                
                
                
                
                //MAP
                ZStack{
                    
                    
                    
                    
                    EntireMapView(map: self.$map, manager: self.$manager).frame(width: 380, height: 400, alignment: .center)
                        .clipped().offset(y:50)
                    
                    Text("Select location:").font(.custom("Roboto Medium", size: 18)).fontWeight(.bold).multilineTextAlignment(.leading).frame(width: 295, height: 6).offset(x:-115,y:-135)
                    
                    if errorlocation{
                        Text(lErr).font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x:-35,y:-115) }
                    
                    
                    
                }.offset(x:0 ,y:-180)
                
                
            }
            
            
            
            //white rectangle
            Spacer(minLength: 100)
            Image("Rectangle 48").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/).offset(x:0 ,y:430)
            
            VStack(spacing: 10){
                
                
                
                
                
                
                
                // Bulding
                VStack(spacing: -10){
                    
                    
                    
                    //Show Error message if no bulding selected
                    if errorBuldingPick {
                        Text(bErr).font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: -95,y:-10)
                    }
                    
                    
                    
                    VStack(spacing: 0){
                        
                        
                        HStack() {
                            TextField("Search Building here", text: $text).multilineTextAlignment(.leading).frame(width: 295, height: 6)
                            Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
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
                                                            Text(Bulding.title).padding(5)
                                                        }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))}
                                                }
                                                
                                                
                                                
                                            }
                                            
                                            
                                            
                                            
                                            
                                        }
                                    }
                                    
                                    
                                    
                                    
                                    
                                }.frame(width: 300, height: 70)
                            }.offset(x: -5, y: 10.0)
                        }
                        
                    }.padding().background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).colorMultiply(.init(#colorLiteral(red: 0.9654662013, green: 0.9606762528, blue: 0.9605932832, alpha: 1)))
                    
                    
                    
                    
                    
                }// END Bulding
                
                
                
                
                
                
                
                
                //Floor
                VStack(spacing: -10){
                    
                    
                    //Show Error message if no floor selected
                    if errorFloorPick {
                        Text(fErr).font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: -105,y:-10)
                    }
                    
                    
                    
                    VStack(spacing: 0){
                        HStack() {
                            Text(Floor).font(.custom("Roboto Medium", size: 18)).fontWeight(.bold).multilineTextAlignment(.center).frame(width: 295, height: 6).offset(x: -130, y: 0)
                            Image(systemName: expandFloor ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
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
                                    }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).frame(width: 297, height: 30)
                                    
                                }.frame(width: 300, height:  70)
                            }.offset(x: -10, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        }
                    }.padding().background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).colorMultiply(.init(#colorLiteral(red: 0.9654662013, green: 0.9606762528, blue: 0.9605932832, alpha: 1)))
                    
                    
                }//END Floor
                
                
                
                
                
                
                VStack(spacing: -10){
                    
                    //Show Error message if the ROOM feild empty
                    if errorRoomPick {
                        Text(rErr).font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: -75,y:-10)
                    }
                    
                    
                    //room numbers
                    TextField("room numbers , more details...", text: $room.text)
                        .font(.system(size: 18))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).keyboardType(.default).padding(.horizontal, 14).offset(x: 0,y:0)
                    
                }
                
                
                
                VStack(spacing: -10){
                    
                    //NEXT
                    Button(action: {
                        print("helooooooo")
                        
                        location = pickAndDrop
                        
                        self.PICKUPlocation()
                        
                        if (!errorlocation && !errorRoomPick && !errorBuldingPick && !errorFloorPick ) {
                            
                            
                            if (order.setpickUPAndpickUpDetails(pickUP:location,pickUpBulding: bulding, pickUpFloor: floorNum, pickUpRoom: room.text)){
                                print("pick up saved")
                                
                                pickAndDrop = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
                                viewRouter.currentPage = .DROPOFFlocation
                            }
                            
                            else
                            {
                                print("pick up  not saved")
                                
                            }
                            
                        }
                        
                    })   {
                        Text("Next").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                    .padding(.top,25)
                    //END NEXT
                    
                    
                    
                }  //END NEXT
                
                
                
                
                
                
                
                
            }.offset(x: 0,y:215)
            
            
            
            
            
            
        }//END ZStack
        
        
        
        
        
        
        
        
        
        
    }//END BODY
    
    
    
    
    
    func PICKUPlocation(){
        
        self.errorlocation = false
        
        
        
        if(!isInRegion(map: map, coordinate: location)){
            print(location)
            self.lErr="*The region out of our service "
            self.errorlocation = true
        }
        
        
        if(!isInRegion(map: map, coordinate: map.userLocation.coordinate)){
            print(location)
            self.lErr="*Your current location\'s out of the campus "
            self.errorlocation = true
        }
        
        
        
        
        
        if (self.location.latitude == 0 && self.location.longitude == 0)  {
            print(location)
            self.lErr="*must enter pick up location"
            self.errorlocation = true
        }
        
        
        
        
        
        
        self.errorRoomPick = false
        
        if self.room.text.count == 0 {
            self.rErr="*must enter more details"
            self.errorRoomPick = true
        }
        
        self.errorBuldingPick = false
        
        if self.bulding == 0 {
            self.bErr="*must select building"
            self.errorBuldingPick = true
        }
        
        self.errorFloorPick = false
        
        if self.floorNum == -1 {
            self.fErr="*must select floor"
            self.errorFloorPick = true
        }
        
    }
    
    
    
    
    
    
    
    struct Bulding: Identifiable {
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
        Bulding(title: "College Of Arts", id: 13),
        Bulding(title: "College Of Languages And Translation", id: 14),
        Bulding(title: "College Of Business Administration", id: 15),
        Bulding(title: "College of Sports Sciences and Physical Activity", id: 16),
        Bulding(title: "College of Law and Political Sciences", id: 17),
    ]
}

func isInRegion (map: MKMapView ,coordinate : CLLocationCoordinate2D) -> Bool {
    print("yeeeeeeeeeeeeeeeeeeeeeees")
    print(coordinate)
    // let region = map.region
    //  let center = region.center
     let northWestCorner = CLLocationCoordinate2D(latitude: 24.721403088472876, longitude: 46.63310307596481)
        let southEastCorner = CLLocationCoordinate2D(latitude: 24.731403088473066, longitude: 46.64356199669078)
    
    
    
    
  //  let northWestCorner = CLLocationCoordinate2D(latitude: 24.82206099999995, longitude:  46.649935497370215)
 //   let southEastCorner = CLLocationCoordinate2D(latitude:   24.832061000000028, longitude:  46.66040290262989)
  //   let northWestCorner = CLLocationCoordinate2D(latitude: center.latitude  - (region.span.latitudeDelta  / 2.0), longitude: center.longitude - (region.span.longitudeDelta / 2.0))
    print(northWestCorner)
   //   let southEastCorner = CLLocationCoordinate2D(latitude: center.latitude  + (region.span.latitudeDelta  / 2.0), longitude: center.longitude + (region.span.longitudeDelta / 2.0))
    print(southEastCorner)
    return (
        ( coordinate.latitude  >= northWestCorner.latitude &&
            coordinate.latitude  <= southEastCorner.latitude &&
            
            coordinate.longitude >= northWestCorner.longitude &&
            coordinate.longitude <= southEastCorner.longitude)
    )
}



struct AddNewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddNewOrderView(viewRouter: ViewRouter())
        }
    }
}

