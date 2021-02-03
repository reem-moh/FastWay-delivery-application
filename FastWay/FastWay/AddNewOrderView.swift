//
//  AddNewOrderView.swift
//  FastWay
//
//  Created by Raghad AlOtaibi on 20/06/1442 AH.
//

import SwiftUI

struct AddNewOrderView: View {
    var body: some View {
        //pick up location
        ZStack{

            VStack{
                //background image
                Image("Rectangle 49").ignoresSafeArea()
                Spacer()
            }
            VStack{
                //white rectangle
                Spacer(minLength: 100)
                Image("Rectangle 48").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            }
            
            /*VStack{
                Text("pick up location").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .tracking(-0.01).multilineTextAlignment(.center)
            //Available in iOS 14 only
            .textCase(.uppercase)
            }*/
            
           /* ZStack {
                RoundedRectangle(cornerRadius: 8)
                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5099999904632568)))

                RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.41999998688697815)), lineWidth: 1)
            }
            .frame(width: 340, height: 54)*/
        
    }
}
}

struct AddNewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewOrderView()
    }
}
