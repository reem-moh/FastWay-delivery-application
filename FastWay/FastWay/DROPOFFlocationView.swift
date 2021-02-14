//
//  AddNewOrderView.swift
//  FastWay
//
//  Created by Shahad AlOtaibi on 20/06/1442 AH.
//

import SwiftUI
import Firebase
import FirebaseFirestore
//var order = Order()
struct DROPOFFlocationView: View {
    @State var name = ""
    @State var location = ""
    @State var buldingPick = 0
    @State var floorPick = -1
    @State var roomPick = ""
    @State var Bulding = "Bulding"
    @State var Floor = "Floor"
        
    
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
    
    var body: some View {
        
        
        
        //pick up location
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
            viewRouter.currentPage = .AddNewOrder
           }) {
             Image("arrow_back")
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .frame(width: 30, height: 30)
               .clipped()
           }.position(x:30 ,y:70)
        
            
            //white rectangle
            Spacer(minLength: 100)
            Image("Rectangle 48").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            
        }//END VStack
        

     
       VStack{
    
        Text("DROP OFF LOCATION ").font(.custom("Roboto Medium", size: 25)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:0 ,y:-360)
        
       }//END VStack
            
            
                //MAP
                Group{
                Image(uiImage: #imageLiteral(resourceName: "map"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 360, height: 280)
                    .clipped()
                   
                }.offset(x:0 ,y:-180)
            
            }
            
            VStack(spacing: 10){

            
            //LOCATION
            VStack(spacing: -10){
                
                
                     
                 //Show Error message if the location feild empty
                     if errorlocation{
                     Text(lErr).font(.custom("Roboto Regular", size: 18))
                         .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: -60,y:5) }
             
                  Image(uiImage: #imageLiteral(resourceName: "location"))
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .frame(width: 25, height: 25)
                      .clipped()
                      .offset(x:-160 ,y:23)
             
             
         TextField("", text: $location)
             .font(.system(size: 18))
             .offset(x:20 ,y:-5).padding(12)
             .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).keyboardType(.emailAddress).padding(.horizontal, 11.0)
         
           
            }//.offset(x:0 ,y:5)
            
            
            

                
                // Bulding
                VStack(spacing: 0){
                
                    
                
            //Show Error message if no bulding selected
                    if errorBuldingPick {
                        Text(bErr).font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: -95,y:0)
                    }
                
                
                    
                        VStack(spacing: 0){
                     

                            HStack() {
                                Text(Bulding).font(.custom("Roboto Medium", size: 18)).fontWeight(.bold).multilineTextAlignment(.leading).frame(width: 295, height: 6)
                                Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                            }.onTapGesture {
                                self.expand.toggle()
                                self.expandFloor = false
                            }
                            if (expand && !expandFloor) {
                                Group {
                                ScrollView {
                                Group {
                                //1
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 5
                                    Bulding="5 Sciences"
                                })
                                {
                                    Text("5 Sciences").padding(5)
                                }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                                //2
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 6
                                    Bulding="6 Computer and Information Sciences"

                                })
                                {
                                    Text("6 Computer and Information Sciences").padding(5)
                                }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                                //3
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 8
                                    Bulding="8 Pharmacy"

                                })
                                {
                                    Text("8 Pharmacy").padding(5)
                                }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                                //4
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 9
                                    Bulding="9 Medicine"

                                })
                                {
                                    Text("9 Medicine").padding(5)
                                }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                                //5
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 10
                                    Bulding="10 Dentistry"

                                })
                                {
                                    Text("10 Dentistry").padding(5)
                                }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                                
                                //6
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 11
                                    Bulding="11 Applied Medical Sciences"

                                })
                                {
                                    Text("11 Applied Medical Sciences").padding(5)
                                }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                                //7
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 12
                                    Bulding="12 Nursing"

                                })
                                {
                                    Text("12 Nursing").padding(5)
                                }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                                    //8
                                    Button(action: {
                                        self.expand.toggle()
                                        buldingPick = 12
                                        Bulding="12 Nursing"

                                    })
                                    {
                                        Text("12 Nursing").padding(5)
                                    }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                                    //9
                                    Button(action: {
                                        self.expand.toggle()
                                        buldingPick = 12
                                        Bulding="12 Nursing"

                                    })
                                    {
                                        Text("12 Nursing").padding(5)
                                    }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                                    //10
                                    Button(action: {
                                        self.expand.toggle()
                                        buldingPick = 12
                                        Bulding="12 Nursing"

                                    })
                                    {
                                        Text("12 Nursing").padding(5)
                                    }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                                }
                                    
                                Group {
                                //1
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 12
                                    Bulding="5 Sciences"

                                })
                                {
                                    Text("5 Sciences").padding(5)
                                }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                                //2
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 12
                                    Bulding="6 Computer and Information Sciences"

                                })
                                {
                                    Text("6 Computer and Information Sciences").padding(5)
                                }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                    
                                }
                                
                                
                                }.frame(width: 300, height: 70)
                                }.offset(x: -5, y: 10.0)
                            }
                        
                        }.padding().background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).colorMultiply(.init(#colorLiteral(red: 0.9654662013, green: 0.9606762528, blue: 0.9605932832, alpha: 1)))
                    
                   
                  //  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                   
                   
                   }//.offset(x:0 ,y:20)// END Bulding
                    
                
                    
                
                
             
                
                
                    //Floor
            VStack(spacing: 0){
                
                
                //Show Error message if no floor selected
        if errorFloorPick {
            Text(fErr).font(.custom("Roboto Regular", size: 18))
                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: -105,y:0)
        }
                    
            

                    VStack(spacing: 0){
                        HStack() {
                            Text(Floor).font(.custom("Roboto Medium", size: 18)).fontWeight(.bold).multilineTextAlignment(.center).frame(width: 295, height: 6)
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
                                floorPick = 0
                                Floor="0"
                            })
                            {
                                Text("0").padding(3)
                            }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                            //2
                            Button(action: {
                                self.expandFloor.toggle()
                                floorPick = 1
                                Floor="1"

                            })
                            {
                                Text("1").padding(3)
                            }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                            //3
                            Button(action: {
                                self.expandFloor.toggle()
                                floorPick = 2
                                Floor="2"

                            })
                            {
                                Text("2").padding(3)
                            }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))

                            //4
                                Button(action: {
                                self.expandFloor.toggle()
                                floorPick = 3
                                    Floor="3"

                            })
                            {
                                Text("3").padding(3)
                                }.foregroundColor(.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).frame(width: 297, height: 30)

                            }.frame(width: 300, height:  70)
                    }.offset(x: -10, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        }
                    }.padding().background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).colorMultiply(.init(#colorLiteral(red: 0.9654662013, green: 0.9606762528, blue: 0.9605932832, alpha: 1)))
                
                    
        }//.offset(x:0 ,y:173)//END Floor
            
       
           
       
                
                
            VStack(spacing: -10){

               //Show Error message if the ROOM feild empty
                    if errorRoomPick {
                        Text(rErr).font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: -75,y:-10)
                    }
                    
                
                //room numbers
            TextField("room numbers , more details...", text: $roomPick)
                .font(.system(size: 18))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).keyboardType(.emailAddress).padding(.horizontal, 14)
                
        }//.offset(x:0 ,y:235)
                
          
            
            VStack(spacing: -10){

                //NEXT
                Button(action: {
                    
                    self.DROPOFFlocation()

                    if (!errorlocation && !errorRoomPick && !errorBuldingPick && !errorFloorPick ) {

     
                         if (order.setDropOffAndDropOffDetails(dropOff:location,dropOffBulding: buldingPick, dropOffFloor: floorPick, dropOffRoom: roomPick)){
                            print("drop off saved")
                            viewRouter.currentPage = .SendOrder

                        }
  
                        else
                        {
                            print("drop off  not saved")

                        }
                    
                    }
                
                })   {
                    Text("Next").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.none)
                                    }
                .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                .padding(.top,25)
                //END NEXT
                
                
                
            }//.offset(x: 0,y:65)  //END NEXT

            
           
  
            
   
        
            
            }.offset(x: 0,y:160)



                
        
            
        }//END ZStack

                
                
            
            
        
            
            

    
}//END BODY
    
    
        
    
    
    func DROPOFFlocation() {
        
       self.errorlocation = false
    
        if self.location.count <= 0 {
         self.lErr="*must  enter drop off location "
            self.errorlocation = true
        }
        
         self.errorRoomPick = false
        
           if self.roomPick.count == 0 {
               self.rErr="*must enter  more details"
               self.errorRoomPick = true
         }
         
         self.errorBuldingPick = false
        
        if self.buldingPick == 0 {
             self.bErr="*must select bulding"
             self.errorBuldingPick = true
         }
        
        self.errorFloorPick = false
        
        if self.floorPick == -1 {
            self.fErr="*must select floor"
            self.errorFloorPick = true
        }
         
}
    
}




/*if order.addOrder(){
    print("added")}*/

struct DROPOFFlocationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DROPOFFlocationView(viewRouter: ViewRouter())
        }
    }
}
