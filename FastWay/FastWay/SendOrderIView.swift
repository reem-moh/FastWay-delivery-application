//
//  SendOrderIView.swift
//  FastWay
//
//  Created by Ghaida . on 21/06/1442 AH.
//

import SwiftUI

struct SendOrderIView: View {
    @State var Orderhere=""
    @State var CashonDelivery=""
    @State var sendorder=""
    
    
    //error variables
    @State var nErr=false
    @State var eErr=false
    @State var phErr=false
    @State var pErr=false
    @State var rpErr=false

    var body: some View {
        
      
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
        VStack(){
            if nErr{
                Text("*A valid name contains more than 5 characters")
            }
            
         
            
            Text("Order Details ").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:-125 ,y:-50)
            
            TextField("Order here", text: $Orderhere)
                .font(.system(size: 18))
                .padding(110)
                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).padding(.horizontal, 11.0).offset(x:0 ,y:-50)
            
            
            
            
            
            
            Text("Payment method").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:-110 ,y:-35)
            
            Text("Cash on Delivery").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:-105 ,y:-20)
            
            TextField("", text: $CashonDelivery)
                .font(.system(size: 18))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).keyboardType(.emailAddress).padding(.horizontal, 11.0).offset(x:0 ,y:-60)
            
            
            
            
            
            
            Button()   {
                                    Text("SEND ORDER").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color( colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.uppercase)
                                }
                                .background(Image(uiImage:  imageLiteral(resourceName: "LogInFeild")))
                                .padding(.top,25).offset(x: 24)
            
               
              
            
       
        }
    
    
    
    
        }
    }}

struct SendOrderIView_Previews: PreviewProvider {
    static var previews: some View {
        SendOrderIView()
    }
}
