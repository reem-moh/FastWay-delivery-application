//
//  SwiftUIView.swift
//  FastWay
//
//  Created by Raghad AlOtaibi on 26/06/1442 AH.
//.foregroundColor(.white)

import SwiftUI

struct SwiftUIView: View {
    @State var expand = false
    
    var body: some View {
        VStack() {
            VStack(spacing: 30){
                HStack() {
                    Text("Bulding").fontWeight(.bold)
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
                    
                    //5
                    Button(action: {
                        self.expand.toggle()
                    })
                    {
                        Text("10 Dentistry").padding(10)
                    }.foregroundColor(.black)
                    
                    //6
                    Button(action: {
                        self.expand.toggle()
                    })
                    {
                        Text("11 Applied Medical Sciences").padding(10)
                    }.foregroundColor(.black)
                    
                    //7
                    Button(action: {
                        self.expand.toggle()
                    })
                    {
                        Text("12 Nursing").padding(10)
                    }.foregroundColor(.black)
                    
                    //8

                    
                    //9

                    
                    //10

                    
                }
            }
        }.position(x:100 ,y: 500)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}


