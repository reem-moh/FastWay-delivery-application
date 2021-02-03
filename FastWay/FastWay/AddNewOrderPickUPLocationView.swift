//
//  AddNewOrderView.swift
//  FastWay
//
//  Created by Raghad AlOtaibi on 20/06/1442 AH.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct AddNewOrderView: View {
    @State var name = ""
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
            
         /*   VStack{
                Text("pick up location").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .tracking(-0.01).multilineTextAlignment(.center)
            //Available in iOS 14 only
            .textCase(.uppercase)
            }*/
         
           VStack{
            Image(uiImage: #imageLiteral(resourceName: "map"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 346, height: 292)
                .clipped()
                .frame(width: 346, height: 292).position(x:188,y:280)
            }
            
        /*    VStack {
                      RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.41999998688697815)), lineWidth: 1).position(x:170,y:100)
            }
            .frame(width: 340, height: 54)
            
            VStack {
                    RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.41999998688697815)), lineWidth: 1).position(x:170,y:200)
            }
            .frame(width: 340, height: 54)*/
            VStack(alignment: .leading){
                
                TextField("2890,KSU,7579-12372 RIYADH", text: $name)
                    .font(.system(size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).padding(.horizontal, 11.0)

                TextField("Email", text: $name)
                    .font(.system(size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).keyboardType(.emailAddress).padding(.horizontal, 11.0)
            }.offset(x: 10.0, y: 100)
                
                /* ZStack {
                RoundedRectangle(cornerRadius: 8)
                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5099999904632568)))

                RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.41999998688697815)), lineWidth: 1)
            }
            .frame(width: 340, height: 54)*/
        
            
            
        
}

    }
struct AddNewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewOrderView()
    }
}
}
