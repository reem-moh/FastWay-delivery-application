//
//  AboutUs.swift
//  FastWay
//
//  Created by taif.m on 2/8/21.
//

import SwiftUI

struct AboutUs: View {
    @StateObject var viewRouter: ViewRouter
    //let abuotPage: Page = .AboutUs
    var body: some View {
        ZStack{
            
            //background
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 90)
            
            VStack{
             
                
                
                Text("About us ").font(.custom("Roboto Medium", size: 35)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0).offset(x:0 ,y:-340)
                
               
                
            }//END VStack
            

            
            
            
            VStack{
                ScrollView{
                    VStack(alignment: .leading){
                        
                        Text("As some members of the university have tight schedules, waiting in queues wastes their valuable time. The application fastway helps them by providing a delivery service within the university and a part-time job for anyone who has some free time to put into use. The user can order things to be delivered to him/her or to send things to other places such as the library, office, pharmacy, and shop.").font(.custom("Roboto Regular", size: 25))
                            .padding(EdgeInsets.init(top: 200, leading: 0, bottom: 0, trailing: 0)).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).offset(x: 0,y: 0).padding(.horizontal, 16)
                        
                    }.padding(.bottom, 60) //VStack
                }//scrollview
            }
            
            //bar menue
            ZStack{
                GeometryReader { geometry in
                        VStack {
                            Spacer()
                            
                            Spacer()
                           HStack {
                                //Home
                               TabBarIcon(viewRouter: viewRouter, assignedPage: checkTypeForHome(),width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
                               
                                //AboutUs
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
                                                        viewRouter.currentPage = .AboutUs
                                                    }.foregroundColor(viewRouter.currentPage == .AboutUs ? Color("TabBarHighlight") : .gray)
                                    }.offset(y: -geometry.size.height/8/2)
                            
                                //Profile
                               TabBarIcon(viewRouter: viewRouter, assignedPage: checkTypeForProfile() ,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Profile") //change assigned page
                            }
                                .frame(width: geometry.size.width, height: geometry.size.height/8)
                                .background(Color("TabBarBackground").shadow(radius: 2))
                        }
                 }
            }.edgesIgnoringSafeArea(.all)//zstack bar menu
        }//ZStack
        
    }//body
    
    func checkTypeForHome() -> Page{
        if UserDefaults.standard.getUderType() == "M"{
            return .HomePageM
        }else if UserDefaults.standard.getUderType() == "C"{
            return .HomePageC
        }
        return .HomePageM
    }
    
    func checkTypeForProfile() -> Page{
        if UserDefaults.standard.getUderType() == "M"{
            return .ViewProfileM
        }else if UserDefaults.standard.getUderType() == "C"{
            return .ViewProfileC
        }
        return .ViewProfileM
    }
}

struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs(viewRouter: ViewRouter())
    }
}
