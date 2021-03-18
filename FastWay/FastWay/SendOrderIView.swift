//
//  SendOrderIView.swift
//  FastWay
//
//  Created by Ghaida . on 21/06/1442 AH.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import UIKit

struct SendOrderIView: View {
    
    @State var txt=""
    @State private var wordCount: Int = 0
    
    @State var CashonDelivery=""
    @State var sendorder=""
    @ObservedObject var Orderhere = TextfieldManager(limit: 80)
    
    @State private var ADDORDER = false
    @State var error = false
    @State var nErr = ""
    
    //Navg bar
    @StateObject var viewRouter: ViewRouter
    
    
    var body: some View {
        
        
        ZStack{
            
            //background image
            VStack{
                //background image
                Image("Rectangle 49").ignoresSafeArea()
                Spacer()
            }
            .onAppear(){
                checkOrders(ID:  UserDefaults.standard.getUderId())
            }
            //white rectangle
            VStack{
                //arrow_back image
                Button(action: {
                    notificationT = .None
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
            //Send order
            VStack{
                Text("Send order ").font(.custom("Roboto Medium", size: 25)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:0 ,y:-360)
            }
            //ProgressBar
            Image("progressBar3")
                .position(x: UIScreen.main.bounds.width/2, y: 140)
                .offset(x: 10)
            //Main Page
            VStack(){
                //Order Details
                Group{
                    Text("Order Details ").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                        .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:-125 ,y:-50)
                    
                    
                    if error{
                        //Show Error message if the email feild empty
                        Text(nErr).font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: -90,y: -50)
                    }
                    
                    TextView(txt: $txt).padding() .background(Color.clear).border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/).cornerRadius(0).frame(width: 355, height: 250, alignment: .center).offset(x:0,y:-50)
                    
                    Text("\(txt.count) /80")
                        .font(.headline)
                        .foregroundColor(.secondary).offset(x:-150,y:-50)
                    
                }
                //Payment method
                Group{
                    Text("Payment method").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                        .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:-110 ,y:-35)
                    Text("Cash on Delivery").frame(width: 330, height: 30)
                        .font(.system(size: 18))
                        .padding(12).offset(x:-100 ,y:0)
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)) .keyboardType(.emailAddress).padding(.horizontal, 11.0).offset(x:0 ,y:-40)
                }
                //Add new Order Button
                Group{
                    Button(action: {
                        self.SendOrder()
                        
                        if !error {
                            if (order.setOrderDetails(orderDetails:txt)){
                                print("order details saved")
                            }
                            ADDORDER.toggle()
                            //notificationT = .SendOrder
                            //viewRouter.currentPage = .CurrentOrder
                        }
                        if order.addOrder(){
                            print("order added")
                        }
                        /*DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if ADDORDER {
                                notificationT = .SendOrder
                                viewRouter.currentPage = .CurrentOrder
                            }
                        }*/
                        
                        
                    })  {
                        Text("Send order").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                    .padding(.top,25).offset(x: 0, y:10)
                    
                }
            }.offset(y: 20)
        }.alert(isPresented: $ADDORDER) {
            Alert(title: Text("Important message"),
                  message: Text("Your Order will be deleted automatically if there are no offers in 15 minutes."),
                  dismissButton: .default(Text("Got it!") , action: {
                    notificationT = .SendOrder
                    viewRouter.currentPage = .CurrentOrder
                  })
            )
         }
        .onTapGesture {
            hideKeyboard()
        }
           
    }
    
    
    
    func SendOrder() {
        
        
        self.error = false
        if self.txt.count <= 0 {
            self.nErr="*This field is required"
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



#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
