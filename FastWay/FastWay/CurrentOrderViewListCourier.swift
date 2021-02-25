//
//  CurrentOrderViewList.swift
//  FastWay
//
//  Created by Ghaida . on 13/07/1442 AH.
//

import SwiftUI

struct CurrentOrderViewList: View {
    
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var model: CarouselViewModel
    @Namespace var animation
    
    var body: some View {
        
        ZStack {
            //Background
            HStack{
                GeometryReader{ geometry in
                    //background
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
                    //DeliverOrderView
                    Text("Available Orders").font(.custom("Roboto Medium", size: 25)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .multilineTextAlignment(.center).position(x:170 ,y:50).offset(x:20,y:20)
                    //white rectangle
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).edgesIgnoringSafeArea(.bottom).offset(y: 100)
                    
                }.edgesIgnoringSafeArea(.all)
                
            }.onAppear(){
                model.order.getOrder()
                model.getCards()
                model.showCard = false
            }
            
            VStack{
                // Carousel....
                Spacer()
                ZStack{
                    GeometryReader{ geometry in
                        HStack {
                            ScrollView {
                                
                                ForEach(model.cards.lazy.indices.reversed(),id: \.self) { index in
                                    HStack{
                                        CardView(card: model.cards[index], animation: animation)
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
            
            if model.showCard {
               // CurrentOrderViewList(viewRouter: viewRouter, animation: animation)
                CurrentOrderViewList(viewRouter: <#ViewRouter#>)
                
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
                            // TabBarIcon(viewRouter: viewRouter, assignedPage: .HomePageC,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
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
                                viewRouter.currentPage = .HomePageC
                            }.foregroundColor(viewRouter.currentPage == .HomePageC ? Color("TabBarHighlight") : .gray)
                            
                            ZStack {
                                //about us icon
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
                                    viewRouter.currentPage = .AboutUs
                                    
                                }.foregroundColor(viewRouter.currentPage == .AboutUs ? Color("TabBarHighlight") : .gray)
                            }.offset(y: -geometry.size.height/8/2)
                            
                            //Profile icon
                            // TabBarIcon(viewRouter: viewRouter, assignedPage: .ViewProfileC ,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Profile")//change assigned page
                            
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
                                viewRouter.currentPage = .ViewProfileC
                            }.foregroundColor(viewRouter.currentPage == .ViewProfileC ? Color("TabBarHighlight") : .gray)
                            
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBackground").shadow(radius: 2))
                        
                    }
                }
            }.edgesIgnoringSafeArea(.all)//zstack
            
        }//end ZStack
    }
}

struct CurrentOrderViewList_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOrderViewList(viewRouter: <#ViewRouter#>)
        //CurrentOrderViewList(viewRouter: ViewRouter())
    }
}
