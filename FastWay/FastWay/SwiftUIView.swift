//
//  SwiftUIView.swift
//  FastWay
//
//  Created by Raghad AlOtaibi on 26/06/1442 AH.
//.foregroundColor(.white)

import SwiftUI

struct SwiftUIView: View {
    @State var expandFloor = false
    @State var expand = false
    @State var buldingNum = 0

    
    var body: some View {
        ZStack{
           /* VStack() {
                VStack(spacing: 30){
                    HStack() {
                        //  Text("$buldingNum").fontWeight(.bold) ?????
                        Text("Bulding").fontWeight(.bold).frame(width: 270, height: 6)
                        Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                    }.onTapGesture {
                        self.expand.toggle()
                    }
                    if expand {
                        Group {
                        ScrollView {
                        Group {
                        //1
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 0
                        })
                        {
                            Text("5 Sciences").padding(10)
                        }.foregroundColor(.black)
                        
                        //2
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 6
                        })
                        {
                            Text("6 Computer and Information Sciences").padding(10)
                        }.foregroundColor(.black)
                        
                        //3
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 8
                        })
                        {
                            Text("8 Pharmacy").padding(10)
                        }.foregroundColor(.black)
                        
                        //4
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 9

                        })
                        {
                            Text("9 Medicine").padding(10)
                        }.foregroundColor(.black)
                        
                        //5
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 10

                        })
                        {
                            Text("10 Dentistry").padding(10)
                        }.foregroundColor(.black)
                            
                        
                        //6
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 11

                        })
                        {
                            Text("11 Applied Medical Sciences").padding(10)
                        }.foregroundColor(.black)
                        
                        //7
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("12 Nursing").padding(10)
                        }.foregroundColor(.black)
                            
                            //8
                            Button(action: {
                                self.expand.toggle()
                                buldingNum = 12

                            })
                            {
                                Text("12 Nursing").padding(10)
                            }.foregroundColor(.black)
                            
                            //9
                            Button(action: {
                                self.expand.toggle()
                                buldingNum = 12

                            })
                            {
                                Text("12 Nursing").padding(10)
                            }.foregroundColor(.black)
                            
                            //10
                            Button(action: {
                                self.expand.toggle()
                                buldingNum = 12

                            })
                            {
                                Text("12 Nursing").padding(10)
                            }.foregroundColor(.black)
                            
                        }
                            
                        Group {
                        //1
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("5 Sciences").padding(10)
                        }.foregroundColor(.black)
                        
                        //2
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("6 Computer and Information Sciences").padding(10)
                        }.foregroundColor(.black)
                        
                        //3
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("8 Pharmacy").padding(10)
                        }.foregroundColor(.black)
                        
                        //4
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("9 Medicine").padding(10)
                        }.foregroundColor(.black)
                        
                        //5
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("10 Dentistry").padding(10)
                        }.foregroundColor(.black)
                        
                        //6
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("11 Applied Medical Sciences").padding(10)
                        }.foregroundColor(.black)
                        
                        //7
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("12 Nursing").padding(10)
                        }.foregroundColor(.black)
                            
                            //8
                        Button(action: {
                                self.expand.toggle()
                            buldingNum = 12

                            })
                            {
                                Text("12 Nursing").padding(10)
                            }.foregroundColor(.black)
                            
                            //9
                        Button(action: {
                                self.expand.toggle()
                            buldingNum = 12

                            })
                            {
                                Text("12 Nursing").padding(10)
                            }.foregroundColor(.black)
                            
                            //10
                        Button(action: {
                                self.expand.toggle()
                            buldingNum = 12

                            })
                            {
                                Text("12 Nursing").padding(10)
                            }.foregroundColor(.black)
                            
                        }
                        
                        Group {
                        //1
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("5 Sciences").padding(10)
                        }.foregroundColor(.black)
                        
                        //2
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("6 Computer and Information Sciences").padding(10)
                        }.foregroundColor(.black)
                        
                        //3
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("8 Pharmacy").padding(10)
                        }.foregroundColor(.black)
                        
                        //4
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("9 Medicine").padding(10)
                        }.foregroundColor(.black)
                        
                        //5
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("10 Dentistry").padding(10)
                        }.foregroundColor(.black)
                        
                        //6
                            VStack(alignment: .center) {
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("11 Applied Medical Sciences").padding(10)
                        }.foregroundColor(.black)
                            }
                        //7
                        Button(action: {
                            self.expand.toggle()
                            buldingNum = 12

                        })
                        {
                            Text("12 Nursing").padding(10)
                        }.foregroundColor(.black)
                            
                            //8
                            Button(action: {
                                self.expand.toggle()
                                buldingNum = 12

                            })
                            {
                                Text("12 Nursing").padding(10)
                            }.foregroundColor(.black)
                            
                            //9
                            Button(action: {
                                self.expand.toggle()
                                buldingNum = 12

                            })
                            {
                                Text("12 Nursing").padding(10)
                            }.foregroundColor(.black)
                            
                            //10
                            Button(action: {
                                self.expand.toggle()
                                buldingNum = 12

                            })
                            {
                                Text("12 Nursing").padding(10)
                            }.foregroundColor(.black)
                            
                        }
                        }
                        }
                    }
                }.padding().background(LinearGradient(gradient: .init(colors: [.white, .purple]), startPoint: .top, endPoint: .bottom)).cornerRadius(15).shadow(color: .gray, radius: 2).position(x:184 ,y: 500)
            }*/
            VStack() {
                            VStack(spacing: 30){
                                VStack{
                                HStack() {
                                    Text("Bulding").fontWeight(.bold).multilineTextAlignment(.center).frame(width: 270, height: 6)
                                    Image(systemName:  expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                                }.onTapGesture {
                                    self.expand.toggle()
                                }
                                if expand {
                                    //1
                                    Button(action: {
                                        self.expand.toggle()
                                    })
                                    {
                                        Text("5 Sciences").padding(10)
                                    }.foregroundColor(.black)
                                    
                                    //2
                                    Button(action: {
                                        self.expand.toggle()
                                    })
                                    {
                                        Text("6 Computer and Information Sciences").padding(10)
                                    }.foregroundColor(.black)
                                    
                                    //3
                                    Button(action: {
                                        self.expand.toggle()
                                    })
                                    {
                                        Text("8 Pharmacy").padding(10)
                                    }.foregroundColor(.black)
                                    
                                    //4
                                    Button(action: {
                                        self.expand.toggle()
                                    })
                                    {
                                        Text("9 Medicine").padding(10)
                                    }.foregroundColor(.black)

                                }
                            }
                        }.padding().background(LinearGradient(gradient: .init(colors: [.white, .purple]), startPoint: .top, endPoint: .bottom)).cornerRadius(15).shadow(color: .gray, radius: 2).position(x:184,y: 500)
                        }
            
            
            VStack() {
                VStack(spacing: 30){
                    VStack{
                    HStack() {
                        Text("Floor").fontWeight(.bold).multilineTextAlignment(.center).frame(width: 270, height: 6)
                        Image(systemName: expandFloor ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                    }.onTapGesture {
                        self.expandFloor.toggle()
                    }
                    if expandFloor {
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
                        }.foregroundColor(.black)

                    }
                }
            }.padding().background(LinearGradient(gradient: .init(colors: [.white, .purple]), startPoint: .top, endPoint: .bottom)).cornerRadius(15).shadow(color: .gray, radius: 2).position(x:184,y: 430)
            }
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
            
    }
}


