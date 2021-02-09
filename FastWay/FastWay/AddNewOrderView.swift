//
//  AddNewOrderView.swift
//  FastWay
//
//  Created by Shahad AlOtaibi on 20/06/1442 AH.
//

import SwiftUI
import Firebase
import FirebaseFirestore
var order = Order()
struct AddNewOrderView: View {

    @State var name = ""
    @State var location = ""
    @State var buldingPick = 0
    @State var floorPick = 0
    @State var roomPick = ""
    
    //REMOVER IT
    @State var Detailslocation = ""


    
    
    @State var errorlocation = false
    @State var errorDetailslocation = false
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
        
            
            
            
            
            
        VStack{
            //background image
            Image("Rectangle 49").ignoresSafeArea()
            Spacer()
        }
        
        VStack{
            
            
            
       
            //arrow_back image
           Button(action: {
            viewRouter.currentPage = .HomePageM
               
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
        }
        

     
       VStack{
        
        
        Text("PICK UP LOCATION ").font(.custom("Roboto Medium", size: 25)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:0 ,y:-360)
        
       }
            
            
            
           
                
        
       
        

        VStack(alignment: .leading){
            
           
            
                
                Image(uiImage: #imageLiteral(resourceName: "map"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 360, height: 292)
                    .clipped()
                    .position(x:188,y:280).offset(x:0 ,y:5)
                
                
           
            
         
                
            //Show Error message if the location feild empty
                if errorlocation{
<<<<<<< Updated upstream
                Text(nErr).font(.custom("Roboto Regular", size: 18))
                    .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 10,y: 240)  }
=======
                Text(lErr).font(.custom("Roboto Regular", size: 18))
                    .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 10,y: 245)  }
>>>>>>> Stashed changes
            
            
            Group{
                
                
                
                
                     Image(uiImage: #imageLiteral(resourceName: "location"))
                         .resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 25, height: 25)
                         .clipped()
                         .offset(x:15 ,y:250)
                
                
                
            TextField("", text: $location)
                .font(.system(size: 18))
                .offset(x:20 ,y:-5).padding(12)
                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).keyboardType(.emailAddress).padding(.horizontal, 11.0).offset(x:0 ,y:205)
            
            
            }
            
            
            
            
           
        
           
            Group{
                
<<<<<<< Updated upstream
           
                
                if errorDetailslocation {
                //Show Error message if the email feild empty
                    Text(nErr1).font(.custom("Roboto Regular", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 10,y: 355)
                }
            
           TextField(" room numbers , more details...", text: $Detailslocation)
=======
            Text("Room number").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:0 ,y:340)
                
            
                
                
                    if errorRoomPick {
                    //Show Error message if the room number feild empty
                        Text(rErr).font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 10,y: 350)
                    }
            }
            
           TextField("room number", text: $roomPick)
>>>>>>> Stashed changes
                .font(.system(size: 18))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).keyboardType(.emailAddress).padding(.horizontal, 11.0).offset(x:0 ,y:350)
            }
            
                
               VStack() {
                    VStack(spacing: 30){
                        HStack() {
                            //  Text("$buldingNum").fontWeight(.bold) ?????
                            Text("Bulding").font(.custom("Roboto Medium", size: 18)).fontWeight(.bold).offset(x: -125 ,y: 0 ).multilineTextAlignment(.leading).frame(width: 295, height: 6)
                            Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                        }.onTapGesture {
                            self.expand.toggle()
                          self.expandFloor = false
                        }
                        if (expand && !expandFloor){

                            VStack {
                               /* //Show Error message if the not select bulding
                                   if (errorBuldingPick && buldingPick == 0){
                                    Text(bErr).font(.custom("Roboto Regular", size: 18))
                                        .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 10,y: 0)
                                   }*/

                            ScrollView {
                            Group {
                                
                            //1
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 0
                            })
                            {
                                Text("5 Sciences").padding(10)
                            }.foregroundColor(.black)
                            
                            //2
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 6
                            })
                            {
                                Text("6 Computer and Information Sciences").padding(10)
                            }.foregroundColor(.black)
                            
                            //3
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 8
                            })
                            {
                                Text("8 Pharmacy").padding(10)
                            }.foregroundColor(.black)
                            
                            //4
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 9

                            })
                            {
                                Text("9 Medicine").padding(10)
                            }.foregroundColor(.black)
                            
                            //5
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 10

                            })
                            {
                                Text("10 Dentistry").padding(10)
                            }.foregroundColor(.black)
                                
                            
                            //6
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 11

                            })
                            {
                                Text("11 Applied Medical Sciences").padding(10)
                            }.foregroundColor(.black)
                            
                            //7
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("12 Nursing").padding(10)
                            }.foregroundColor(.black)
                                
                                //8
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 12

                                })
                                {
                                    Text("12 Nursing").padding(10)
                                }.foregroundColor(.black)
                                
                                //9
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 12

                                })
                                {
                                    Text("12 Nursing").padding(10)
                                }.foregroundColor(.black)
                                
                                //10
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 12

                                })
                                {
                                    Text("12 Nursing").padding(10)
                                }.foregroundColor(.black)
                                
                            }
                                
                            Group {
                            //1
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("5 Sciences").padding(10)
                            }.foregroundColor(.black)
                            
                            //2
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("6 Computer and Information Sciences").padding(10)
                            }.foregroundColor(.black)
                            
                            //3
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("8 Pharmacy").padding(10)
                            }.foregroundColor(.black)
                            
                            //4
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("9 Medicine").padding(10)
                            }.foregroundColor(.black)
                            
                            //5
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("10 Dentistry").padding(10)
                            }.foregroundColor(.black)
                            
                            //6
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("11 Applied Medical Sciences").padding(10)
                            }.foregroundColor(.black)
                            
                            //7
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("12 Nursing").padding(10)
                            }.foregroundColor(.black)
                                
                                //8
                            Button(action: {
                                    self.expand.toggle()
                                buldingPick = 12

                                })
                                {
                                    Text("12 Nursing").padding(10)
                                }.foregroundColor(.black)
                                
                                //9
                            Button(action: {
                                    self.expand.toggle()
                                buldingPick = 12

                                })
                                {
                                    Text("12 Nursing").padding(10)
                                }.foregroundColor(.black)
                                
                                //10
                            Button(action: {
                                    self.expand.toggle()
                                buldingPick = 12

                                })
                                {
                                    Text("12 Nursing").padding(10)
                                }.foregroundColor(.black)
                                
                            }
                            
                            Group {
                            //1
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("5 Sciences").padding(10)
                            }.foregroundColor(.black)
                            
                            //2
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("6 Computer and Information Sciences").padding(10)
                            }.foregroundColor(.black)
                            
                            //3
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("8 Pharmacy").padding(10)
                            }.foregroundColor(.black)
                            
                            //4
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("9 Medicine").padding(10)
                            }.foregroundColor(.black)
                            
                            //5
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("10 Dentistry").padding(10)
                            }.foregroundColor(.black)
                            
                            //6
                                VStack(alignment: .center) {
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("11 Applied Medical Sciences").padding(10)
                            }.foregroundColor(.black)
                                }
                            //7
                            Button(action: {
                                self.expand.toggle()
                                buldingPick = 12

                            })
                            {
                                Text("12 Nursing").padding(10)
                            }.foregroundColor(.black)
                                
                                //8
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 12

                                })
                                {
                                    Text("12 Nursing").padding(10)
                                }.foregroundColor(.black)
                                
                                //9
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 12

                                })
                                {
                                    Text("12 Nursing").padding(10)
                                }.foregroundColor(.black)
                                
                                //10
                                Button(action: {
                                    self.expand.toggle()
                                    buldingPick = 12

                                })
                                {
                                    Text("12 Nursing").padding(10)
                                }.foregroundColor(.black)
                                                                                                 }
                            }
                            }.background(Image("Rectangle 49"))
                        
                    }
                    }.padding().background(LinearGradient(gradient: .init(colors: [ .white, .white]), startPoint: .top, endPoint: .bottom)).cornerRadius(8).shadow(color: .gray, radius: 2).position(x:185,y: 150)
                }
                
                


                
                
                    VStack(spacing: 30){
                        HStack() {
                            Text("Bliding").font(.custom("Roboto Medium", size: 18)).fontWeight(.bold).offset(x: -134 ,y: 0 ).multilineTextAlignment(.center).frame(width: 295, height: 6)
                            Image(systemName: expandFloor ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                        }.onTapGesture {
                            self.expandFloor.toggle()
                            self.expand = false
                        }
                        if expandFloor {
                            if !expand {
                            ScrollView {
                            //1
                            Button(action: {
                                self.expandFloor.toggle()
                            })
                            {
                                Text("0").padding(10)
                            }.foregroundColor(.black)
                            
                            //2
                            Button(action: {
                                self.expandFloor.toggle()
                            })
                            {
                                Text("1").padding(10)
                            }.foregroundColor(.black)
                            
                            //3
                            Button(action: {
                                self.expandFloor.toggle()
                            })
                            {
                                Text("2").padding(10)
                            }.foregroundColor(.black)
                            
                            //4
                            Button(action: {
                                self.expandFloor.toggle()
                            })
                            {
                                Text("3").padding(10)
<<<<<<< Updated upstream
                            }.foregroundColor(.black).background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1))

                        }
                    }.padding().background(LinearGradient(gradient: .init(colors: [ .white, .white]), startPoint: .top, endPoint: .bottom)).cornerRadius(8).shadow(color: .gray, radius: 2).position(x:185 ,y: 180)
                    
                

                
                
                VStack() {
                    VStack(spacing: 30){
                        HStack() {
                            Text("Floor").font(.custom("Roboto Medium", size: 18)).fontWeight(.bold).offset(x: -134 ,y: 0 ).multilineTextAlignment(.center).frame(width: 295, height: 6)
                            Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                        }.onTapGesture {
                            self.expand.toggle()
                        }
                        if expand {
                            //1
                            Button(action: {
                                self.expand.toggle()
                            })
                            {
                                Text("0").padding(10)
=======
>>>>>>> Stashed changes
                            }.foregroundColor(.black)
                        }
<<<<<<< Updated upstream
                    }.padding().background(LinearGradient(gradient: .init(colors: [ .white, .white]), startPoint: .top, endPoint: .bottom)).cornerRadius(8).shadow(color: .gray, radius: 2).position(x:185 ,y: 30)
=======
                        }
                    }
                    }.padding().background(LinearGradient(gradient: .init(colors: [ .white, .white]), startPoint: .top, endPoint: .bottom)).cornerRadius(8).shadow(color: .gray, radius: 2).position(x:185 ,y: 3)
>>>>>>> Stashed changes
                    
                }
                
           
        }
            
        
            Group{
                Button(action: {
                    
                    self.PICKUPlocation()

                    if (!errorlocation && !errorRoomPick && !errorBuldingPick) {
                        
                       
                         if (order.setpickUPAndpickUpDetails(pickUP:location,pickUpBulding: buldingPick, pickUpFloor: floorPick, pickUpRoom: roomPick)){
                            print("pick up saved")
                            viewRouter.currentPage = .DROPOFFlocation

                        }
  
                        else
                        {
                            print("pick up  not saved")

                        }
                    
                    }
                
                })   {
                    Text("NEXT").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.uppercase)
                                    }
                .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                .padding(.top,25).offset(x: 25,y:-70)
                
            }
            

            
            
            
        }//end ZStack
            

    
}//end body
    
    
        
    
    
    func PICKUPlocation() {
        
        self.errorlocation = false
    
        if self.location.count <= 0 {
            self.lErr="*must be more than one characters"
            self.errorlocation = true
            
        }
        
        self.errorRoomPick = false
        if self.roomPick.count <= 0 {
            self.rErr="*must be more than one characters"
            self.errorRoomPick = true
        }
        
        self.errorBuldingPick = false
        if buldingPick == 0 {
            self.bErr="*must select bulfing"
            self.errorRoomPick = true
        }


    }//end PickUpLocation
    

}



/*if order.addOrder(){
    print("added")}*/

struct AddNewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddNewOrderView(viewRouter: ViewRouter())
        }
    }
}
