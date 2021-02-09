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
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 30)
            
            VStack{
                ScrollView{
                    VStack(alignment: .leading){
                        
                        Text("SwiftUI’s TextField view is similar to UITextField, although it looks a little different by default and relies very heavily on binding to state.To create one, you should pass in a placeholder to use inside the text field, plus the state value it should bind to. For example, this creates a TextField` bound to a local string, then places a text view below it that shows the text field’s output as you type:").font(.custom("Roboto Regular", size: 18))
                            .padding(EdgeInsets.init(top: 250, leading: 0, bottom: 0, trailing: 0)).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).offset(x: 0, y: 0).padding(.horizontal, 16)
                        
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
