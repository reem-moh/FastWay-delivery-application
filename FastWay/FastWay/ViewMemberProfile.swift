//
//  ViewMemberProfile.swift
//  FastWay
//
//  Created by taif.m on 2/8/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ViewMemberProfile: View {
    @ObservedObject var member = Member()
    
    /* @State var name = ""
     @State var email = ""
     @State var phoneNum = ""*/
    @State var password = ""
    @State var newPassword = ""
    @State var reNewPassword = ""
    
    
    @StateObject var viewRouter: ViewRouter
    
    
    var body: some View {
        ZStack{
            
            //Background+BarMenue
            ZStack{
                
                //background
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 30)
                
                
                
            }/*.onAppear {
             self.member.getMember(id: UserDefaults.standard.getUderId())
             print("view M")
             }*/
            
            VStack{
                //Cancel and Done button
                HStack {
                    Spacer()
                    //Cancel button
                    Button(action: {
                        returnHomePage()
                    }) {
                        Text("Cancel").font(.custom("Roboto Bold", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.5045552254, green: 0.2118494511, blue: 0.6409354806, alpha: 1))).padding(1.0).textCase(.uppercase).offset(y: 10)
                    }
                    Spacer()
                    Spacer()
                    
                    Image("profileM").font(.system(size: 56.0)).padding(.bottom,50).offset(x: -12 ,y: 45)
                    Spacer()
                    Spacer()
                    
                    //save button
                    Button(action: {
                        //action here
                    }) {
                        Text("Done").font(.custom("Roboto Bold", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.5045552254, green: 0.2118494511, blue: 0.6409354806, alpha: 1))).padding(1.0).textCase(.uppercase).offset(y: 10)
                    }
                    Spacer()
                }
                
                ScrollView{
                    
                    VStack(alignment: .leading){
                        
                        Group {
                            
                            //name field
                            Text("").font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            Text("name:").font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).offset(x: 18,y: 10)
                            
                            TextField(" \(self.member.member.name)", text: $member.member.name)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            
                            //email field
                            Text("").font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            Text("email:").font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).offset(x: 18,y: 10)
                            
                            TextField("\(self.member.member.email)", text: $member.member.email)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            //print("email \((self.member.email))")
                            
                            //phone field
                            Text("").font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            Text("phone number:").font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).offset(x: 18,y: 10)
                            
                            TextField("\(self.member.member.phoneNo)", text: $member.member.phoneNo)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            //print("Phone number \(self.member.phoneNo)")
                            
                            //Password
                            Group {
                                Text("Change the Password").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                                    .multilineTextAlignment(.center).offset(x: 18,y: 10).padding(.bottom,-20)
                                
                                //current password
                                Text("").font(.custom("Roboto Regular", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                                SecureField("Current Password", text: $password)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .font(.custom("Roboto Regular", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                                //New Pass
                                SecureField("New Password", text: $newPassword)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .font(.custom("Roboto Regular", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                                //reNew pass
                                SecureField("Repeat New Password", text: $reNewPassword)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .font(.custom("Roboto Regular", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                                
                            }// end group password
                            
                        }//end group field
                        
                        //logout button
                        Button(action: {
                            logout()
                        }) {
                            Text("Log out").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.none)
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                        .padding(.top,25).offset(x: 24).padding(.bottom,100)
                        
                    }.padding(.bottom, 60) //VStack
                    
                }//scrollview
                
            }//vstack
            
            //BarMenue
            ZStack{
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        Spacer()
                        Spacer()
                        HStack {
                            //Home icon
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .HomePageM,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
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
                                    notificationT = .None
                                    viewRouter.currentPage = .AboutUs
                                }.foregroundColor(viewRouter.currentPage == .AboutUs ? Color("TabBarHighlight") : .gray)
                            }.offset(y: -geometry.size.height/8/2)
                            //Profile icon
                            TabBarIcon(viewRouter: viewRouter, assignedPage: .ViewProfileM ,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Profile") //change assigned page
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBackground").shadow(radius: 2))
                    }
                }
            }.edgesIgnoringSafeArea(.all)//zstack
            
        }//zstack
    } //body
    
    
    func logout(){
        let auth=Auth.auth()
        do {
            try auth.signOut()
            
            UserDefaults.standard.setIsLoggedIn(value: false)
            UserDefaults.standard.setUserId(Id: "")
            UserDefaults.standard.setUserType(Type: "")
            print("LoggedOut")
            notificationT = .None
            viewRouter.currentPage = .LogIn
        } catch let signOutError {
            print ("Error signing out: %@", signOutError)
        }
        print("succes Loggout")
    }
    
    
    func returnHomePage(){
        //check if user loggedin
        if UserDefaults.standard.isLoggedIn(){
            notificationT = .None
            viewRouter.currentPage = .HomePageM
        }//end if logged in
    }
    
    func printdata(){
        print("email \(self.member.email)")
        print("name \((self.member.name))")
        print("Phone number \(self.member.phoneNo)")
    }
}




struct ViewMemberProfile_Previews: PreviewProvider {
    static var previews: some View {
        ViewMemberProfile(viewRouter: ViewRouter())
    }
}
