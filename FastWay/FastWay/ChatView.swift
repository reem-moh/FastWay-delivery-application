
//  ChatView.swift
//  FastWay
//
//  Created by Reem on 19/03/2021.
//

import SwiftUI
import MapKit
import CoreLocation

struct ChatView : View {
    
    @StateObject var viewRouter: ViewRouter
    @StateObject var model: CurrentCarouselMViewModel
    @Namespace var animation

    @State var msgs = [ChatMsg]()
    @State var txt = ""
    @State var nomsgs = false
    
    var body : some View{
        ZStack{
            //Background
            ZStack{
                
                //background
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 49"))
                    .resizable() //add resizable
                    .frame(width: width(num: 375)) //addframe
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .offset(y:hieght(num: -100))
                
                //CurrentOrderView
                Text("Chat").font(.custom("Roboto Medium", size: fontSize(num: 25))).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .multilineTextAlignment(.center).position(x:width(num:170) ,y:hieght(num:50)).offset(x:width(num:20),y:hieght(num:20))
                
                //back button
                Group{
                    //RoundedRectangle(cornerRadius: 10)
                      //  .frame(width: width(num:45), height:hieght(num: 35))
                        //.foregroundColor(Color(.white))
                    Button(action: {
                        withAnimation(.spring()){
                            model.showChat.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation(.easeIn){
                                    model.showChat = false
                                    
                                }
                            }
                            
                        }
                    }) {
                        Image("arrow_back")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width(num: 30) , height: hieght(num: 30))
                            .clipped()
                    }.padding(1.0)
                }
                .position(x: width(num:45), y: hieght(num:70))
                
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear(){
                self.getMsgs()
            }
            /*.onChange(of: model.order.chat) { value in
                self.getMsgs()
            }*/
            VStack{
                ZStack{
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                        .resizable() //add resizable
                        .frame(width: width(num: 375)) //addframe
                        .edgesIgnoringSafeArea(.bottom)
                        .offset(y:hieght(num:  65))
                  
                    VStack{
                        if self.nomsgs{
                            Text("No Message")
                        }
                        else{
                            // Carousel....
                            VStack{
                                Spacer()
                                ZStack{
                                    GeometryReader{ geometry in
                                        HStack {
                                            ScrollView {
                                                
                                                ForEach(msgs) { i in
                                                    HStack{
                                                        if i.senderID == UserDefaults.standard.getUderId(){
                                                            
                                                            Spacer(minLength: 0)
                                                            
                                                            Text(i.msg)
                                                                .padding()
                                                                .background(Color.blue)
                                                                .clipShape(ChatBubble(mymsg: true))
                                                                .foregroundColor(.white)
                                                        }
                                                        else{
                                                            
                                                            Text(i.msg)
                                                                .padding()
                                                                .background(Color.green)
                                                                .clipShape(ChatBubble(mymsg: false))
                                                                .foregroundColor(.white)
                                                            
                                                            Spacer(minLength: 0)
                                                        }
                                                        
                                                    }//.frame(height: 100)
                                                    .padding(.horizontal)
                                                    .contentShape(Rectangle())
                                                    .gesture(DragGesture(minimumDistance: 20))
                                                    .padding(.vertical, hieght(num: 5))
                                                    .shadow(radius: 1)
                                                    
                                                    
                                                }.padding(.bottom,hieght(num: 25))//end of for each
                                                
                                                
                                            }

                                        }
                                    }
                                }
                                .padding(.top,hieght(num: 80))
                                Spacer()
                            }.padding(.bottom,hieght(num: 20))
                        }
                    }
                    //Enter message
                    HStack{
                        Spacer()
                        TextField("Enter Message", text: self.$txt)
                            .font(.custom("Roboto Regular", size: fontSize(num:18)))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                            .strokeBorder(Color(.gray), lineWidth: 2))
                            .padding(.top, hieght(num: 10))
                            .padding(.horizontal, width(num:16))
                        Spacer()
                        Button(action: {
                            if(self.txt != ""){
                                model.order.sendChatRoom(orderId: model.selectedCard.orderD.id, sender_msg: self.txt)
                            }
                            self.txt = ""
                            
                        }) {
                           
                            Image(systemName: "paperplane.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: width(num:45), height: hieght(num:45))
                                .clipped()
                                
                                
                        }
                        Spacer()
                    }
                    .background(Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).resizable())
                    .position(x: width(num:UIScreen.main.bounds.width/2),y: hieght(num:700))
                    
                }
                
            }
            
        }.onTapGesture {
            self.hideKeyboard()
        }
        
    }
    
    func getMsgs(){
        self.msgs.removeAll()
        model.order.getChatRoom(orderId: model.selectedCard.orderD.id){ success in
            print("inside getMsgs success")
            guard success else { return }
            if model.order.chat.isEmpty{
                self.nomsgs = true
            }else{
                self.nomsgs = false
                for index in model.order.chat{
                    print("\(index.msg)")
                    let id = index.id
                    let senderID = index.senderID
                    let timeSent = index.timeSent
                    let msg = index.msg
                    self.msgs.append(ChatMsg(id: id, senderID: senderID, timeSent: timeSent, msg: msg))

                }
            }
        }
        
    }
}


struct ChatBubble : Shape {
    
    var mymsg : Bool
    
    func path(in rect: CGRect) -> Path {
            
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,mymsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
}
/*

 

 */
