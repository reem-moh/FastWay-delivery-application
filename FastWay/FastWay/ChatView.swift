//
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
    var name : String
    @Binding var chat : Bool
    @State var msgs = [ChatMsg]()
    @State var txt = ""
    @State var nomsgs = false
    
    var body : some View{
        
        VStack{
            
            
            if msgs.count == 0{
                
                if self.nomsgs{
                    
                    Text("").foregroundColor(Color.black.opacity(0.5)).padding(.top)
                    
                    Spacer()
                }
            }
            else{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 8){
                        
                        ForEach(self.msgs){i in
                            HStack{
                                
                                if i.senderID == UserDefaults.standard.getUderId(){
                                    
                                    Spacer()
                                    
                                    Text(i.msg)
                                        .padding()
                                        .background(Color.blue)
                                        .clipShape(ChatBubble(mymsg: true))
                                        .foregroundColor(.white)
                                }
                                else{
                                    
                                    Text(i.msg).padding().background(Color.green).clipShape(ChatBubble(mymsg: false)).foregroundColor(.white)
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            
            HStack{
                
                TextField("Enter Message", text: self.$txt).textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    
                   // sendMsg(user: self.name, uid: self.uid, pic: self.pic, date: Date(), msg: self.txt)
                    model.order.sendChatRoom(orderId: model.selectedCard.orderD.id, sender_msg: self.txt)
                    self.txt = ""
                    
                }) {
                    
                    Text("Send")
                }
            }

            
        }.padding()
        .onAppear {
            self.getMsgs()
        }
    }
    
    func getMsgs(){
                    
        if model.order.chat.isEmpty{
                
                self.nomsgs = true
        }else{
            for index in model.order.chat{
                let id = index.id
                let senderID = index.senderID
                let timeSent = index.timeSent
                let msg = index.msg
                self.msgs.append(ChatMsg(id: id, senderID: senderID, timeSent: timeSent, msg: msg))

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
