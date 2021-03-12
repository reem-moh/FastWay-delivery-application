//
//  TabBarMenu.swift
//  FastWay
//
//  Created by taif.m on 2/8/21.
//

import SwiftUI

struct TabBarMenuM: View {
    @StateObject var viewRouter: ViewRouter
    let abuotPage: Page = .AboutUs
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Text("Home")
                Spacer()
                HStack { //bar menu M
                    TabBarIcon(viewRouter: viewRouter, assignedPage: .HomePageM,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
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
                        }.padding(.horizontal, width(num: 14)).onTapGesture {
                            notificationT = .None
                            viewRouter.currentPage = abuotPage
                        }.foregroundColor(viewRouter.currentPage == abuotPage ? Color("TabBarHighlight") : .gray)
                    }.offset(y: -geometry.size.height/8/2)
                    TabBarIcon(viewRouter: viewRouter, assignedPage: .ViewProfileM ,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Profile") //change assigned page
                }
                .frame(width: geometry.size.width, height: geometry.size.height/8)
                .background(Color("TabBarBackground").shadow(radius: 2))
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct TabBarMenuC {
    @StateObject var viewRouter: ViewRouter
    let abuotPage: Page = .AboutUs
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Text("Home")
                Spacer()
                HStack { //bar menu C
                    
                    TabBarIcon(viewRouter: viewRouter, assignedPage: .HomePageC,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
                    
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
                        }.padding(.horizontal, width(num: 14)).onTapGesture {
                            notificationT = .None
                            viewRouter.currentPage = abuotPage
                        }.foregroundColor(viewRouter.currentPage == abuotPage ? Color("TabBarHighlight") : .gray)
                    }.offset(y: -geometry.size.height/8/2)
                    
                    TabBarIcon(viewRouter: viewRouter, assignedPage: .ViewProfileC ,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Profile")
                    //change assigned page
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height/8)
                .background(Color("TabBarBackground").shadow(radius: 2))
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}


struct TabBarIcon: View {
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Page
    let width, height: CGFloat
    let systemIconName, tabName: String
    
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, hieght(num: 10))
            Text(tabName)
                .font(.footnote)
            Spacer()
        }.padding(.horizontal, UIScreen.main.bounds.width/(375/14)).onTapGesture {
            notificationT = .None
            viewRouter.currentPage = assignedPage 
        }.foregroundColor(viewRouter.currentPage == assignedPage ? Color("TabBarHighlight") : .gray)
    }
}


struct TabBarMenu_Previews: PreviewProvider {
    static var previews: some View {
        TabBarMenuM(viewRouter: ViewRouter())
    }
}

