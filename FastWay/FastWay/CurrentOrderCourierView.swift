//
//  CurrentOrderView.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.
//

import SwiftUI

struct CurrentOrderCourierView: View {
    
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var model: CurrentCarouselMViewModel
    @Namespace var animation
    //for notification
    @State var show = false
    
    var body: some View {
        
        ZStack {
            //Background
            HStack{
                GeometryReader{ geometry in
                    //background
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
                    //CurrentOrderView
                    Text("Current Orders").font(.custom("Roboto Medium", size: 25)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .multilineTextAlignment(.center).position(x:170 ,y:50).offset(x:20,y:20)
                    //white rectangle
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).edgesIgnoringSafeArea(.bottom).offset(y: 100)
                    
                }.edgesIgnoringSafeArea(.all)
                
            }.onAppear(){
                //calling Methods
                model.order.getMemberOrder(Id: UserDefaults.standard.getUderId())
                model.getCards()
                model.showCard = false
                model.showContent = false
            }
            // Carousel....
            VStack{
                Spacer()
                ZStack{
                    GeometryReader{ geometry in
                        HStack {
                            ScrollView {
                                
                                ForEach(model.cards.lazy.indices.reversed(),id: \.self) { index in
                                    HStack{
                                        CurrentCardMView(card: model.cards[index], animation: animation)
                                        Spacer(minLength: 0)
                                    }//.frame(height: 100)
                                    .padding(.horizontal)
                                    .contentShape(Rectangle())
                                    .gesture(DragGesture(minimumDistance: 20))
                                    .padding(.vertical, 5)
                                    .shadow(radius: 1)
                                    
                                    
                                }.padding(.bottom,25)//end of for each
                                
                                
                            }
                            
                        }
                    }
                }.padding(.top,80)
                Spacer()
            }.padding(.bottom,80)
            //Press detailes
            if model.showCard {
                //Calling detailed card
                CurrentCardMDetailes(viewRouter: viewRouter, animation: animation)
            }
            
            //notification
            VStack{
                if show{
                    Notifications(type: viewRouter.notificationT, imageName: "shoppingCart")
                        .offset(y: self.show ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
            }.onAppear(){
                if viewRouter.notificationT == .SendOrder {
                    animateAndDelayWithSeconds(0.05) { self.show = true }
                    animateAndDelayWithSeconds(4) { self.show = false }
                }
            }
            
            //BarMenue
            ZStack{
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        Spacer()
                        Spacer()
                        HStack {
                            //Home icon
                            VStack {
                                Image(systemName: "homekit")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/5, height: geometry.size.height/28)
                                    .padding(.top, 10)
                                Text("Home")
                                    .font(.footnote)
                                Spacer()
                            }.padding(.horizontal, 14).onTapGesture {
                                withAnimation(.spring()){
                                    model.showCard.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn){
                                            model.showContent = false
                                            
                                        }
                                    }
                                    
                                }
                                viewRouter.notificationT = .None
                                viewRouter.currentPage = .HomePageM
                            }.foregroundColor(viewRouter.currentPage == .HomePageM ? Color("TabBarHighlight") : .gray)
                            //about us icon
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                                    .shadow(radius: 4)
                                VStack {
                                    Image(uiImage:  #imageLiteral(resourceName: "FastWay")) //logo
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width/7-6 , height: geometry.size.width/7-6)
                                }.padding(.horizontal, 14).onTapGesture {
                                    withAnimation(.spring()){
                                        model.showCard.toggle()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            withAnimation(.easeIn){
                                                model.showContent = false
                                                
                                            }
                                        }
                                        
                                    }
                                    viewRouter.notificationT = .None
                                    viewRouter.currentPage = .AboutUs
                                    
                                }.foregroundColor(viewRouter.currentPage == .AboutUs ? Color("TabBarHighlight") : .gray)
                            }.offset(y: -geometry.size.height/8/2)
                            //profile icon
                            VStack {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/5, height: geometry.size.height/28)
                                    .padding(.top, 10)
                                Text("Profile")
                                    .font(.footnote)
                                Spacer()
                            }.padding(.horizontal, 14).onTapGesture {
                                withAnimation(.spring()){
                                    model.showCard.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn){
                                            model.showContent = false
                                            
                                        }
                                    }
                                    
                                }
                                viewRouter.notificationT = .None
                                viewRouter.currentPage = .ViewProfileM
                            }.foregroundColor(viewRouter.currentPage == .ViewProfileM ? Color("TabBarHighlight") : .gray)
                            
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBackground").shadow(radius: 2))
                        
                    }
                }
            }.edgesIgnoringSafeArea(.all)//zstack
            
        }//end ZStack
    }}




struct CurrentOrderCourierView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOrderCourierView(viewRouter: ViewRouter())
    }
}
