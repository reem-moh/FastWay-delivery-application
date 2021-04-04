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
    
     @State var name = ""
     @State var email = ""
     @State var phoneNum = ""
    @State var password = ""
    @State var newPassword = ""
    @State var reNewPassword = ""
    
    @State var error = false
    @State var nErr=""
    @State var eErr=""
    @State var pErr=""
    @State var rpErr=""
    @State var phErr=""
    @State var uErr=""

    
    @StateObject var viewRouter: ViewRouter
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()
    
    var body: some View {
        ZStack{
            
            //Background+BarMenue
            ZStack{
                
                //background
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 49"))
                    .resizable() //add resizable
                    .frame(width: width(num: 375)) //addframe
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:hieght(num: -100))
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                    .resizable() //add resizable
                    .frame(width: width(num: 375)) //addframe
                    .offset(y: hieght(num: 30))
                
                
            }.onAppear(){
                checkOrders(ID:  UserDefaults.standard.getUderId())
                self.name = self.member.member.name
                self.email = self.member.member.email
                self.phoneNum = self.member.member.phoneNo
            }
            
            VStack{
                //Cancel and Done button
                HStack{
                    //Cancel button
                    /*Button(action: {
                        returnHomePage()
                    }) {
                        Text("Cancel").font(.custom("Roboto Bold", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.5045552254, green: 0.2118494511, blue: 0.6409354806, alpha: 1))).padding(1.0).textCase(.uppercase).offset(y: 10)
                    }*/
                    
                    //save button
                    /*Button(action: {
                        //action here
                    }) {
                        Text("Done").font(.custom("Roboto Bold", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.5045552254, green: 0.2118494511, blue: 0.6409354806, alpha: 1))).padding(1.0).textCase(.uppercase).offset(y: 10)
                    }*/
                }
                HStack {
                    Spacer()
                    
                    Spacer()
                    Spacer()
                    
                    Image("profileM").font(.system(size: fontSize(num: 56.0))).padding(.bottom, hieght(num: 50) ).offset(x:width(num: -12) ,y:hieght(num: 45))
                    
                    Spacer()
                    Spacer()
                    
                    
                    Spacer()
                }
                
                ScrollView{
                    
                    VStack(alignment: .leading){
                        
                        Group {
                            
                            //name field
                            Text(self.nErr).font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x:width(num: 12) ,y:hieght(num: 10))
                            
                            Text("name:").font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).offset(x: 18,y: 10)
                            
                            TextField(" \(self.member.member.name)", text: $name, onCommit: {
                                self.error = false
                                self.nErr=""
                                if self.name.count < 3 {
                                    self.nErr="*Name must be more than 2 characters"
                                    self.error = true
                                }
                                
                            })
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top,hieght(num: 10) ).padding(.horizontal,width(num: 16) )
                            
                            //email field
                            Text(self.eErr).font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x:width(num: 12) ,y:hieght(num: 10))
                            
                            Text("email:").font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).offset(x:width(num: 18) ,y:hieght(num: 10))
                            
                            TextField("\(self.member.member.email)", text: $email, onCommit: {
                                self.error = false
                                self.eErr=""
                                if (self.email == "") || !(self.email.isEmail()){
                                    self.eErr="*Valid email is required"
                                    self.error = true
                                }
                            })
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, hieght(num: 10) ).padding(.horizontal,width(num: 16) )
                            //print("email \((self.member.email))")
                            
                            //phone field
                            Text(self.phErr).font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x:width(num: 12) ,y:hieght(num: 10))
                            
                            Text("phone number:").font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).offset(x:width(num: 18) ,y:hieght(num: 10))
                            
                            TextField("\(self.member.member.phoneNo)", text: $phoneNum, onCommit: {
                                self.error = false
                                self.phErr=""
                                if !(self.phoneNum.isValidPhoneNumber()){
                                    self.phErr="*Phone number must be 05********"
                                    self.error = true
                                }
                            })
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, hieght(num: 10) ).padding(.horizontal,width(num: 16) )
                            //print("Phone number \(self.member.phoneNo)")
                            
                            //Password
                            Group {
                                Text("Change the Password").font(.custom("Roboto Medium", size: fontSize(num: 18))).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                                    .multilineTextAlignment(.center).offset(x: width(num: 18) ,y: hieght(num: 10)).padding(.bottom,hieght(num: -20) )
                                
                                //current password
                                Text(self.pErr).font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                    .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: width(num: 12) ,y: hieght(num: 10))
                                SecureField("Current Password", text: $password, onCommit: {
                                    //get pass from Auth and compare
                                })
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                    .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, hieght(num: 10) ).padding(.horizontal,width(num: 16) )
                                //New Pass
                                SecureField("New Password", text: $newPassword, onCommit: {
                                    self.error = false
                                    self.pErr=""
                                    if self.newPassword.count < 8 || !checkPass(pass: self.newPassword){
                                        self.pErr="*Password must be 8 or more characters, conatins a capital letter, a small letter and a digit"
                                        self.error = true
                                    }
                                })
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                    .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top,hieght(num: 10) ).padding(.horizontal,width(num: 16) )
                                
                                //error for repeat pass
                                Text(self.rpErr).font(.custom("Roboto Regular", size: fontSize(num:18)))
                                    .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: width(num: 12), y: hieght(num: 10))
                                
                                //reNew pass
                                SecureField("Repeat New Password", text: $reNewPassword, onCommit: {
                                    self.error = false
                                    self.rpErr=""
                                    if self.reNewPassword != self.newPassword{
                                        self.rpErr="*Password mismatch"
                                        self.error = true
                                    }
                                })
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                    .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, hieght(num: 10) ).padding(.horizontal,width(num: 16) )
                                
                            }// end group password
                            
                        }//end group field
                        
                        //logout button
                        Button(action: {
                            logout()
                        }) {
                            Text("Log out").font(.custom("Roboto Bold", size: fontSize(num: 22))).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.none)
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                        .padding(.top,hieght(num: 25) ).offset(x: width(num: 24)).padding(.bottom,hieght(num: 100) )
                        
                    }.padding(.bottom,hieght(num: 60) ) //VStack
                    
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
                                }.padding(.horizontal,width(num: 14) ).onTapGesture {
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
        .onAppear(){
            //for the in app notification
            //call it before get notification
            /*UNUserNotificationCenter.current().delegate = delegate
           getNotificationMember(memberId: UserDefaults.standard.getUderId()){ success in
                print("after calling method get notification")
                guard success else { return }
            }*/
        }
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
