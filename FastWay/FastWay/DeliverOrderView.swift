//
//  DeliverOrderView.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.
//

// Home
import SwiftUI
// width...
var width = UIScreen.main.bounds.width

struct DeliverOrderView: View {
    
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
            }
            
            VStack{
                HStack{Spacer()}.padding()
                // Carousel....
                Spacer()
                ZStack{
                    //call method calculate the number of orders
                    //add this method in class model
                    
                    ForEach(model.cards.lazy.indices.reversed(),id: \.self){index in
                        
                        HStack {
                            
                            CardView(card: model.cards[index], animation: animation)
                                .frame(width: getCardWidth(index: index), height: getCardHeight(index: index))
                                .offset(x: getCardOffset(index: index))
                                .rotationEffect(.init(degrees: getCardRotation(index: index)))
                            
                            Spacer(minLength: 0)
                        }
                        .frame(height: 400)
                        .contentShape(Rectangle())
                        .offset(x: model.cards[index].offset)//.shadow(radius: 4)
                        .gesture(DragGesture(minimumDistance: 0)
                                    .onChanged({ (value) in
                                        onChanged(value: value, index: index)
                                    }).onEnded({ (value) in
                                        onEnd(value: value, index: index)
                                    }))
                    }
                }
                .padding(.top,25)
                .padding(.horizontal,30)

                
               Button(action: ResetViews, label: {
                    
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                })
               .padding(.top,10)//.padding(.top,35)//.offset(y:20)
                
                Spacer()
            }
            
            if model.showCard {
                
                DetailView(animation: animation)
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
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .HomePageC,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
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
                                    viewRouter.currentPage = .AboutUs
                                }.foregroundColor(viewRouter.currentPage == .AboutUs ? Color("TabBarHighlight") : .gray)
                            }.offset(y: -geometry.size.height/8/2)
                            //Profile icon
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .ViewProfileC ,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Profile") //change assigned page
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBackground").shadow(radius: 2))
                    }
                }
            }.edgesIgnoringSafeArea(.all)//zstack
            
        }//endZStack
    }//end Body
    
    // Resting Views...
    
    func ResetViews(){
        
        for index in model.cards.indices{
            
            withAnimation(.spring()){
                
                model.cards[index].offset = 0
                model.swipedCard = 0
            }
        }
    }
    
    func onChanged(value: DragGesture.Value,index: Int){
        
        // Only Left Swipe...
        
        if value.translation.width < 0{
            
            model.cards[index].offset = value.translation.width
        }
        
    }
    
    func onEnd(value: DragGesture.Value,index: Int){
        
        withAnimation{
            
            if -value.translation.width > width / 3{
                
                model.cards[index].offset = -width
                model.swipedCard += 1
            }
            else{
                
                model.cards[index].offset = 0
            }
        }
    }
    
    // Getting Rotation When Card is being Swiped...
    func getCardRotation(index: Int)->Double{
        
        let boxWidth = Double(width / 3)
        
        let offset = Double(model.cards[index].offset)
        
        let angle : Double = 5
        
        return (offset / boxWidth) * angle
    }
    
    // Getting Width And Height For Card ....
    func getCardHeight(index: Int)->CGFloat{
        
        let height : CGFloat = 400
        // Again First Three Cards...
        let cardHeight = index - model.swipedCard <= 2 ? CGFloat(index - model.swipedCard) * 35 : 70
        return height - cardHeight
    }
    
    func getCardWidth(index: Int)->CGFloat{
        
        let boxWidth = UIScreen.main.bounds.width - 60 - 20
        
        // For First Three Cards....
        //let cardWidth = index <= 2 ? CGFloat(index) * 30 : 60
        
        return boxWidth
    }
    
    // Getting Offset...
    func getCardOffset(index: Int)->CGFloat{
        
        return index - model.swipedCard <= 2 ? CGFloat(index - model.swipedCard) * 30 : 60
    }
}

struct DeliverOrderView_Previews: PreviewProvider {
    static var previews: some View {
        DeliverOrderView(viewRouter: ViewRouter())
    }
}
