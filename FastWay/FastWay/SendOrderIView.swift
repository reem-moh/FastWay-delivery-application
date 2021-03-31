//
//  SendOrderIView.swift
//  FastWay
//
//  Created by Ghaida . on 21/06/1442 AH.
//

import SwiftUI
import Firebase
import FirebaseFirestore
//import UIKit

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
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()
    
    
    var body: some View {
        
        
        ZStack{
            ZStack{
                //background image
                VStack{
                    //background image
                    Image("Rectangle 49")
                        .resizable() //add resizable
                        .frame(width: width(num: 375)) //addframe
                        .ignoresSafeArea()
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
                            .frame(width: width(num: 30) , height: hieght(num: 30))
                            .clipped()
                    }.position(x:width(num: 30)  ,y:hieght(num: 70))
                    
                    
                    //white rectangle
                    Spacer(minLength: 100)
                    Image("Rectangle 48").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                }
                //Send order
                VStack{
                    Text("Send order ").font(.custom("Roboto Medium", size: fontSize(num: 25))).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading,width(num: 12.0) ).offset(x:width(num: 0) ,y:hieght(num: -360))
                }
                //ProgressBar
                Image("progressBar3")
                    .resizable()
                    .frame(width: width(num: UIImage(named: "progressBar3")!.size.width ), height: hieght(num: UIImage(named: "progressBar3")!.size.height))
                    .position(x: UIScreen.main.bounds.width/2, y: hieght(num: 140))
                    .offset(x: width(num: 10))
                //Main Page
                VStack(){
                    //Order Details
                    Group{
                        Text("Order Details ").font(.custom("Roboto Medium", size: fontSize(num: 18))).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                            .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading,width(num: 12.0) ).offset(x: width(num: -125),y:hieght(num: -50))
                        
                        
                        if error{
                            //Show Error message if the email feild empty
                            Text(nErr).font(.custom("Roboto Medium", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: width(num: -90),y:hieght(num: -50))
                        }
                        
                        TextView(txt: $txt).padding() .background(Color.clear).border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/).cornerRadius(0).frame(width: width(num: 355), height: hieght(num: 250), alignment: .center).offset(x: width(num: 0),y:hieght(num: -50))
                        
                        Text("\(txt.count) /80")
                            .font(.headline)
                            .foregroundColor(.secondary).offset(x: width(num: -150),y:hieght(num: -50))
                        
                    }
                    //Payment method
                    Group{
                        Text("Payment method").font(.custom("Roboto Medium", size: fontSize(num: 18))).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                            .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading,width(num: 12.0) ).offset(x: width(num: -110),y:hieght(num: -35))
                        Text("Cash on Delivery").frame(width: width(num: 330), height:  hieght(num: 30))
                            .font(.system(size: fontSize(num: 18)))
                            .padding(12).offset(x: width(num: -100),y:hieght(num: 0))
                            .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)) .keyboardType(.emailAddress).padding(.horizontal,width(num: 11.0) ).offset(x: width(num: 0),y:hieght(num: -40))
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
                        .padding(.top,hieght(num: 25) ).offset(x: width(num: 0),y:hieght(num: 10))
                        
                    }
                }.offset(y:hieght(num: 20))
            }.onTapGesture {
                self.hideKeyboard()
            }
            
            
        }.alert(isPresented: $ADDORDER) {
            Alert(title: Text("Important message"),
                  message: Text("Your Order will be deleted automatically if there are no offers in 15 minutes."),
                  dismissButton: .default(Text("Got it!") , action: {
                    notificationT = .SendOrder
                    viewRouter.currentPage = .CurrentOrder
                  })
            )
         }
        .onAppear(){
            //for the in app notification
            //call it before get notification
            /*UNUserNotificationCenter.current().delegate = delegate
           getNotificationMember(memberId: UserDefaults.standard.getUderId()){ success in
                print("after calling method get notification")
                guard success else { return }
            }*/
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



//#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
//#endif
