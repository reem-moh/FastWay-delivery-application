//
//  SendOrderIView.swift
//  FastWay
//
//  Created by Ghaida . on 21/06/1442 AH.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct SendOrderIView: View {
    @State var Orderhere=""
    @State var CashonDelivery=""
    @State var sendorder=""

    
    
    @State var error = false
    @State var nErr = ""
    
   

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
            
            
    
                
                VStack{
                 
                 
                 Text("SEND ORDER ").font(.custom("Roboto Medium", size: 25)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                     .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:0 ,y:-360)
                 
                }
                
             
            
        VStack(){
            
          
            
        
            Group{
            Text("Order Details ").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:-125 ,y:-35)
           
         
                
            //Show Error message if the email feild empty
                Text(nErr).font(.custom("Roboto Regular", size: 18))
                    .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: -35,y: -40)
                
            TextField("Order here", text: $Orderhere)
                .font(.system(size: 18))
            .offset(x:-100 ,y:-100).padding(110)
                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).padding(.horizontal, 11.0).offset(x:0 ,y:-50)
            
            }
            
            
            
            Group{
                
            Text("Payment method").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:-110 ,y:-35)
            
            Text("Cash on Delivery").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:-105 ,y:-20)
            
            TextField("", text: $CashonDelivery)
                .font(.system(size: 18))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).keyboardType(.emailAddress).padding(.horizontal, 11.0).offset(x:0 ,y:-60)
            
            
            }
            
           
            Group{
                
            Button(action: {
                self.SendOrder()
            })  {
                Text("SEND ORDER").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.uppercase)
                                }
            .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
            .padding(.top,25).offset(x: 0, y:10)
            
            }
              
            
       
        }
    
    
    
    
        }
    }

func SendOrder() {
    self.error = false
    if self.Orderhere.count <= 0 {
        self.nErr="*must be more than one characters"
        self.error = true
    }
    
    

}}

struct SendOrderIView_Previews: PreviewProvider {
    static var previews: some View {
        SendOrderIView()
    }
}
