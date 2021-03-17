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
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 49"))
                .resizable() //add resizable
                .frame(width: width(num: 375)) //addframe
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .offset(y:hieght(num: -100))
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                .resizable() //add resizable
                .frame(width: width(num: 375)) //addframe
                .edgesIgnoringSafeArea(.all)
                .offset(y:hieght(num:  90))
            
            VStack{
                Text("About us ").font(.custom("Roboto Medium", size:fontSize(num: 35))).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading,width(num: 12.0)).offset(x: width(num: 0) ,y:hieght(num: -340))
            }.onAppear(){
                if UserDefaults.standard.getUderType() == "M"{
                    checkOrders(ID:  UserDefaults.standard.getUderId())
                }
            }//END VStack

            VStack{
                ScrollView{
                    VStack(alignment: .leading){
                       /* Spacer()
                        HStack{
                            Image("KSU")
                                .resizable()
                                .frame(width: width(num: 40), height: hieght(num: 45))
                            Text("As some members of the university have tight schedules, waiting in queues wastes their valuable time.")
                                .font(.custom("Roboto Regular", size: fontSize(num:25)))
                                //.padding(EdgeInsets.init(top: hieght(num:200), leading: 0, bottom: 0, trailing: 0))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .offset(x: width(num:0),y:hieght(num:  0))
                                .padding(.horizontal, width(num: 16))
                        }
                        Text("FastWay helps by providing a delivery service within the KSU female campus, and a part-time job for anyone who has some free time to put into use.")
                            .font(.custom("Roboto Regular", size: fontSize(num:25)))
                            .padding(EdgeInsets.init(top: hieght(num:200), leading: 0, bottom: 0, trailing: 0)).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).offset(x: width(num:0),y:hieght(num:  0)).padding(.horizontal, width(num: 16))
                        Spacer()*/
                    }.padding(.bottom, hieght(num: 60)) //VStack
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
                            TabBarIcon(viewRouter: viewRouter, assignedPage: checkTypeForHome(),width: width(num:geometry.size.width/5), height:hieght(num:  geometry.size.height/28), systemIconName: "homekit", tabName: "Home")
                            
                            //AboutUs
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width:width(num: geometry.size.width/7), height:width(num: geometry.size.width/7))
                                    .shadow(radius: 4)
                                VStack {
                                    Image(uiImage:  #imageLiteral(resourceName: "FastWay")) //logo
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:width(num: geometry.size.width/7-6 ), height:width(num: geometry.size.width/7-6))
                                }.padding(.horizontal, width(num:  14)).onTapGesture {
                                    notificationT = .None
                                    viewRouter.currentPage = .AboutUs
                                }.foregroundColor(viewRouter.currentPage == .AboutUs ? Color("TabBarHighlight") : .gray)
                            }.offset(y: hieght(num: -geometry.size.height/8/2))
                            
                            //Profile
                            TabBarIcon(viewRouter: viewRouter, assignedPage: checkTypeForProfile() ,width: width(num:geometry.size.width/5), height: hieght(num: geometry.size.height/28), systemIconName: "person.crop.circle", tabName: "Profile") //change assigned page
                        }
                        .frame(width: width(num:geometry.size.width), height:hieght( num: geometry.size.height/8))
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
