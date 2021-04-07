//
//  ViewCourierProfile.swift
//  FastWay
//
//  Created by taif.m on 2/8/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ViewCourierProfile: View {
    @ObservedObject var courier = Courier()
    @StateObject var viewRouter: ViewRouter
    //for edit Profile
    @State var name = ""
    @State var email = ""
    @State var oldEmail = ""
    @State var phoneNum = ""
    @State var password = ""
    @State var newPassword = ""
    @State var reNewPassword = ""
    //for the errors in edit Profile
    @State var error = false
    @State var nErr=""
    @State var eErr=""
    @State var pErr=""
    @State var rpErr=""
    @State var phErr=""
    @State var uErr=""

    
    
    //for the in app notification
    @StateObject var delegate = NotificationDelegate()
    //alert cancel button
    @State var alertCancel = false
    //Show cancel and Done buttons
    @State var show = false
    //check before user logout if there is change not saved
    @State var showLogOut = false
    //check if the user change the email
    @State var changeEmail = false
    //check if the user press other pages without save changes
    @State var changePageHome = false
    @State var changePageAbout = false
    //display confirmation msg
    @State var imgName = "Tick"
    @State var showNoti = false
    
    var body: some View {
        ZStack{
            
            
            
            
            ZStack{
                
                //background
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 49"))
                    .resizable() //add resizable
                    .frame(width: width(num: 375)) //addframe
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:hieght(num: -100))
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 48"))
                    .resizable() //add resizable
                    .frame(width: width(num: 375)) //addframe
                    .offset(y: hieght(num: 50))
                
            }.onAppear(){
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.name = self.courier.courier.name
                    self.email = self.courier.courier.email
                    self.phoneNum = self.courier.courier.phoneNo
                    self.oldEmail = self.courier.courier.email
                    print("inside dispatch on appear \(self.name)\n \(self.email)\n\(self.phoneNum)\n\(self.oldEmail)")
                }
                print("inside on appear \(self.name)\n \(self.email)\n\(self.phoneNum)\n\(self.oldEmail)")
            }
            
            
            //Cancel and Done buttonspacing: 20
            if show {
                HStack(){
                    Spacer()
                    //Cancel button
                    Button(action: {
                        alertCancel.toggle()
                        //returnHomePage()
                    }) {
                        Text("Cancel")
                            .font(.custom("Roboto Bold", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))).padding(1.0)
                            .offset(y: 10)
                    }
                    Spacer(minLength: 1)
                    Spacer(minLength: 1)
                    Spacer(minLength: 1)
                    Spacer(minLength: 1)
                    Spacer(minLength: 1)
                    Spacer(minLength: 1)
                    //save button
                    Button(action: {
                        //action here
                       // if self.email != "" &&
                        if self.name == "" || self.email == "" || self.phoneNum == "" {
                            print(self.name + self.email + self.phoneNum)
                            self.nErr="*All fields are required"
                            self.error = true
                        }
                        if self.newPassword != "" && (self.newPassword != self.reNewPassword){
                            self.rpErr="*Password mismatch"
                            self.error = true
                        }else{
                            self.rpErr=""
                        }
                        if !error{
                            if self.email == self.oldEmail {
                                self.changeEmail = false
                            }else{
                                self.changeEmail = true
                            }
                            self.courier.editProfileCourier(courierId: self.courier.courier.id, email: self.email, name: self.name, phone:  self.phoneNum)
                            if self.newPassword != "" && (self.newPassword == self.reNewPassword){
                                changePass(ChangesPass: newPassword)
                            }
                            self.show = false
                            notificationT = .updateProfile
                        }
                        
                        
                    }) {
                        Text("Done")
                            .font(.custom("Roboto Bold", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))).padding(1.0)
                            .offset(y: 10)
                    }
                    Spacer()
                }.position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/50)
            }
            VStack{
                
                
                
                
                HStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Image("profileC").font(.system(size: fontSize(num: 56.0)))
                        .padding(.bottom, hieght(num: 50) )
                        .offset(y:hieght(num: 65))
                    //add frame to image
                    //x:width(num: -12) ,
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
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).offset(x:width(num: 18) ,y:hieght(num: 10))
                            
                            TextField("\(self.courier.courier.name)", text: $courier.courier.name, onCommit: {
                                self.error = false
                                self.nErr=""
                                if self.courier.courier.name.count < 3 {
                                    self.nErr="*Name must be more than 2 characters"
                                    self.error = true
                                }else {
                                    self.name = self.courier.courier.name
                                    self.nErr=""
                                }
                                
                            })
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, hieght(num: 10)).padding(.horizontal, width(num: 16))
                            .onTapGesture {
                                self.show = true
                            }
                            
                            //email field
                            Text(self.eErr).font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x:width(num: 12) ,y:hieght(num: 10))
                            
                            Text("email:").font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).offset(x:width(num: 18) ,y:hieght(num: 10))
                            
                            TextField("\(self.courier.courier.email)", text: $courier.courier.email, onCommit: {
                                self.error = false
                                self.eErr=""
                                if (self.courier.courier.email == "") || !(self.courier.courier.email.isEmail()){
                                    self.eErr="*Valid email is required"
                                    self.error = true
                                }else{
                                    self.email = self.courier.courier.email
                                }
                            })
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal,width(num: 16) )
                            .onTapGesture {
                                self.show = true
                            }
                            
                            
                            //phone field
                            Text(self.phErr).font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x:width(num: 12) ,y:hieght(num: 10))
                            
                            Text("phone number:").font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).offset(x:width(num: 18) ,y:hieght(num: 10))
                            
                            TextField("\(self.courier.courier.phoneNo)", text: $courier.courier.phoneNo, onCommit: {
                                self.error = false
                                self.phErr=""
                                if !(self.courier.courier.phoneNo.isValidPhoneNumber()){
                                    self.phErr="*Phone number must be 05********"
                                    self.error = true
                                }else{
                                    self.phoneNum = self.courier.courier.phoneNo
                                }
                            })
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, hieght(num: 10)).padding(.horizontal, width(num: 16))
                            .onTapGesture {
                                self.show = true
                            }
                            
                            //Password
                            Group {
                                HStack{
                                    Rectangle()
                                        .fill(Color.black.opacity(0.05))
                                        .frame(width: width(num: 100), height: hieght(num: 5))
                                    
                                    Text("Change Password")//.font(.custom("Roboto Medium", size: fontSize(num: 18)))
                                        .foregroundColor(Color.black.opacity(0.7))
                                        .fontWeight(.bold)
                                       // .multilineTextAlignment(.center)
                                        //.offset(x: width(num: 18) ,y: hieght(num: 10))
                                        //.padding(.bottom,hieght(num: -20) )
                                    
                                    Rectangle()
                                        .fill(Color.black.opacity(0.05))
                                        .frame(width: width(num: 100), height: hieght(num: 5))
                                }.padding(.top , hieght(num: 10))
                                /*
                                //current password
                                Text("").font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                    .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: width(num: 12) ,y: hieght(num: 10))
                                SecureField("Current Password", text: $password)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                    .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, hieght(num: 10)).padding(.horizontal, width(num: 16))
                                */
                                if  self.error{
                                Text(self.pErr).font(.custom("Roboto Regular", size: fontSize(num: 18)))
                                    .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: width(num: 12) ,y: hieght(num: 10))
                            }
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
                                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, hieght(num: 10)).padding(.horizontal, width(num: 16))
                                .onTapGesture {
                                    self.show = true
                                }
                                //error for repeat pass
                                if  self.error{
                                    Text(self.rpErr).font(.custom("Roboto Regular", size: fontSize(num:18)))
                                        .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: width(num: 12), y: hieght(num: 10))
                                }
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
                                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, hieght(num: 10)).padding(.horizontal, width(num: 16))
                                .onTapGesture {
                                    self.show = true
                                }

                            }// end group password
                            
                        }//end group field
                        
                        //logout button
                        Button(action: {
                                if self.show {
                                    self.showLogOut = true
                                    self.alertCancel.toggle()
                                    self.alertCancel = true
                                }else{
                                    logout()
                                }
                            
                        }) {
                            Text("Log out").font(.custom("Roboto Bold", size: fontSize(num: 22))).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.none)
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                        .padding(.top,hieght(num: 25)).offset(x: width(num: 24)).padding(.bottom,hieght(num: 100))
                        
                    }.padding(.bottom, hieght(num: 60)) //VStack
                    
                }//scrollview
                
                
            }//vstack
            
            //notification
            VStack{
                if showNoti{
                    Notifications(type: notificationT, imageName: self.imgName)
                        .offset(y: self.showNoti ? -UIScreen.main.bounds.height/2.47 : -UIScreen.main.bounds.height)
                        .transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                }
            }.onChange(of: notificationT){ value in
                if notificationT == .updateProfile {
                    self.imgName = "Tick"
                    animateAndDelayWithSeconds(0.05) { self.showNoti = true }
                    animateAndDelayWithSeconds(4) {
                        self.showNoti = false
                        notificationT = .None
                    }
                }else {
                    print("inside noti ")
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
                                    .padding(.top, hieght(num: 10))
                                Text("Home")
                                    .font(.footnote)
                                
                                Spacer()
                                
                            }.padding(.horizontal, UIScreen.main.bounds.width/(375/14))
                            .onTapGesture {
                                
                                if self.show {
                                    self.changePageHome = true
                                    self.alertCancel.toggle()
                                    self.alertCancel = true
                                }else{
                                    notificationT = .None
                                    viewRouter.currentPage = .HomePageC
                                }
                                 
                            }.foregroundColor(viewRouter.currentPage == .HomePageC ? Color("TabBarHighlight") : .gray)
                            /*TabBarIcon(viewRouter: viewRouter, assignedPage: .HomePageC,width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")*/
                            
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
                                }.padding(.horizontal, width(num: 14)).onTapGesture {
                                    if self.show {
                                        self.changePageAbout = true
                                        self.alertCancel.toggle()
                                        self.alertCancel = true
                                    }else{
                                        notificationT = .None
                                        viewRouter.currentPage = .AboutUs
                                    }
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
            
        }//zstack.
        .onAppear(){
            //for the in app notification
            //call it before get notification
            /*UNUserNotificationCenter.current().delegate = delegate
            getNotificationCourier(courierId: UserDefaults.standard.getUderId()){ success in
                print("after calling method get notification")
                guard success else { return }
            }*/
        }.alert(isPresented: $alertCancel) {
            Alert(
                title: Text("undo Changes"),
                message: Text("Do you want to undo these changes?"),
                primaryButton: .default((Text("Yes")), action: {
                    if self.showLogOut{
                        logout()
                    }else if self.changePageAbout {
                        notificationT = .None
                        viewRouter.currentPage = .AboutUs
                    }else if self.changePageHome {
                        notificationT = .None
                        viewRouter.currentPage = .HomePageC
                    }else{
                        returnHomePage()
                    }
                }) ,
                secondaryButton: .cancel((Text("No")))
            )}//end alert
    } //body
    
    
    func logout(){
        let auth = Auth.auth()
        do {
            try auth.signOut()
            
            UserDefaults.standard.setIsLoggedIn(value: false)
            UserDefaults.standard.setUserId(Id: "")
            UserDefaults.standard.setUserType(Type: "")
            notificationT = .None //chang to logout
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
            viewRouter.currentPage = .HomePageC
        }//end if logged in
    }
    
    func printdata(){
        print("email \(self.courier.email)")
        print("name \((self.courier.name))")
        print("Phone number \(self.courier.phoneNo)")
    }
}

struct ViewCourierProfile_Previews: PreviewProvider {
    static var previews: some View {
        ViewCourierProfile(viewRouter: ViewRouter())
    }
}
