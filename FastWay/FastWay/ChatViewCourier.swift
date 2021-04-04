//
//  ChatViewCourier.swift
//  FastWay
//
//  Created by taif.m on 3/23/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct ChatViewCourier: View {
    @ObservedObject var member = Member(id: "", name: "", email: "", phN: "")
    @StateObject var viewRouter: ViewRouter
    @StateObject var model: CurrentCarouselCViewModel
    @Namespace var animation

    @State var msgs = [ChatMsg]()
    @State var txt = ""
    @State var nomsgs = false
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()
    @State var token = ""
    
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
                
                HStack {
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    Spacer()
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
                                            //.offset(y: hieght(num:20))
                                            .padding(1.0)
                                            .position(y:hieght(num:70))
                                    }
                                    Image("profileM")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 55,height:55)
                                        //.font(.system(size: fontSize(num: 56.0)))
                                        .position(x: width(num: -50), y:hieght(num:70))
                                    Text("\(model.order.nameSender)")
                                        //.font(.body, size: fontSize(num: 25))
                                        //.font(.body)
                                        .font(.system(size: fontSize(num: 26)))
                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                        .multilineTextAlignment(.center)
                                        .position(x: width(num: -90),y:hieght(num:70))
                                    Spacer(minLength: 0)
                                }

                
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear(){
                self.getMsgs()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.member.getMemberToken(memberId: model.selectedCard.orderD.memberId){ success in
                        print("After getMemberToken in send \(self.member.member.token)")
                        self.token = self.member.member.token
                        guard success else { return }
                    }
                }
                model.order.getMemberName(memberId: model.selectedCard.orderD.memberId) { success in
                  print("\n\n\n\n\n\n\n\nchange name in msg \(model.order.nameSender)")
                }
            }
            
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
                                                
                                                ForEach(msgs.lazy.indices.reversed(),id: \.self) { i in
                                                    HStack{
                                                                                                            if msgs[i].senderID == UserDefaults.standard.getUderId(){
                                                                                                                
                                                                                                                Spacer(minLength: 0)
                                                                                                                VStack{
                                                                                                                    Text(msgs[i].msg)
                                                                                                                        .padding()
                                                                                                                        .background(Color.blue)
                                                                                                                        .clipShape(ChatBubble(mymsg: true))
                                                                                                                        .foregroundColor(.white)
                                                                                                                    
                                                                                                                    Text(msgs[i].timeSent.addingTimeInterval(600), style: .time)
                                                                                                                        .font(.footnote)
                                                                                                                        .fontWeight(.light)
                                                                                                                        .fontWeight(.regular)
                                                                                                                        .foregroundColor(Color.black.opacity(0.5))
                                                                                                                    Spacer(minLength: 0)
                                                                                                                }
                                                                                                                
                                                                                                             
                                                                                                                    
                                                                                                            }
                                                                                                            else{
                                                                                                                VStack{
                                                                                                                    Text(msgs[i].msg)
                                                                                                                        .padding()
                                                                                                                        .background(Color.white)
                                                                                                                        .clipShape(ChatBubble(mymsg: false))
                                                                                                                        .foregroundColor(.gray)
                                                                                                                    Text(msgs[i].timeSent.addingTimeInterval(600), style: .time)
                                                                                                                        .font(.footnote)
                                                                                                                        .fontWeight(.light)
                                                                                                                        .fontWeight(.regular)
                                                                                                                        .foregroundColor(Color.black.opacity(0.5))
                                                                                                                }
                                                                                                                Spacer(minLength: 0)
                                                                                                            }
                                                                                                            
                                                                                                            
                                                                                                        }
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
                            
                                //send notification to member
                               
                                //change token
                                sendMessageTouser(to: self.token, title: "New Message", body: "The order \(model.selectedCard.orderD.orderDetails.suffix(20)).. has new message from the courier")

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
                        Spacer()
                        Spacer()
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
                
                self.msgs = model.order.chat
                self.msgs.sort {
                    $0.timeSent > $1.timeSent
                }
                print("after msgs assignment")
                for index in self.msgs{
                    print("\(index.msg)")
                    
                }
            }
        }
        
    }
}


