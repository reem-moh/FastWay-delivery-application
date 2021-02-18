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
    
    //Navg bar
    @StateObject var viewRouter: ViewRouter
    

    var body: some View {
        
      
        ZStack{
            
            
            VStack{
                //background image
                Image("Rectangle 49").ignoresSafeArea()
                Spacer()
            }
            
            VStack{
                
                
                
           
                //arrow_back image
                
               Button(action: {
                viewRouter.currentPage = .DROPOFFlocation

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
                 
                 
                 Text("Send order ").font(.custom("Roboto Medium", size: 25)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                     .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:0 ,y:-360)
                 
                }
                
       
             
            
        VStack(){
            
          
            
            
            
            Group{
            Text("Order Details ").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:-125 ,y:-50)
           
                
                       if error{
                   //Show Error message if the email feild empty
                       Text(nErr).font(.custom("Roboto Regular", size: 18))
                           .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: -35,y: -50)
                       }
                
                
            TextField("Order here", text: $Orderhere)
                .font(.system(size: 18))
            .offset(x:-100 ,y:-100).padding(110)
                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).padding(.horizontal, 11.0).offset(x:0 ,y:-50)
            
            }
            
            
            
            Group{
                
            Text("Payment method").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:-110 ,y:-35)
            
        
            
                Text("Cash on Delivery").frame(width: 330, height: 30)
                .font(.system(size: 18))
                .padding(12).offset(x:-100 ,y:0)
                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)) .keyboardType(.emailAddress).padding(.horizontal, 11.0).offset(x:0 ,y:-40)
            
            
            }
            
           
            Group{
                
            Button(action: {
                self.SendOrder()
                
                if !error {
                if (order.setOrderDetails(orderDetails:Orderhere)){
                    print("order details saved")
                }
                    viewRouter.currentPage = .HomePageM

                }
                if order.addOrder(){
                    print("order added")
                }
            })  {
                Text("Send order").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50)
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
        

    }
    
    

}

struct SendOrderIView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SendOrderIView(viewRouter: ViewRouter())
        }
    }
}
