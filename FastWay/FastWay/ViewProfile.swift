//
//  ViewProfile.swift
//  FastWay
//
//  Created by taif.m on 2/5/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ViewProfile: View {
    @State var name=""
    @State var email=""
    @State var phoneNum=""
    @State var password=""
    @State var newPassword=""
    @State var reNewPassword=""
    @State var user=""
    // @State var gender=""
    
    //get data from DB
    @State var member = Member()
    @State var courier = Courier()
    
    @StateObject var viewRouter: ViewRouter
    
    /* @Binding var showHomeCourier: Bool
     @Binding var showHomeMember: Bool
     @Binding var showCurrentCourier: Bool
     @Binding var showCurrentMember: Bool
     @Binding var showLogInView: Bool*/
    
    var body: some View {
        ZStack{
            
            //background
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 30)
            
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
                    Image(systemName: "person").font(.system(size: 56.0)).padding(.bottom,50).offset(x: -12 ,y: 45)
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
                            
                            Text("").font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            TextField(self.name, text: $name)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            
                            Text("").font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            TextField(self.email, text: $email)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            
                            Text("").font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            TextField(self.phoneNum, text: $phoneNum)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            
                            //Password
                            Group {
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
                                
                            }
                            
                        }.onAppear {
                            getInfo(id: UserDefaults.standard.getUderId(), type: UserDefaults.standard.getUderType())
                        }//end group
                        
                        //logout button
                        Button(action: {
                            
                            logout()
                            
                        }) {
                            Text("Logout").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.uppercase)
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                        .padding(.top,25).offset(x: 24)
                        
                    }.padding(.bottom, 60) //VStack
                    
                }
                //scrollview
                
                //main bar
                ZStack {
                    
                    Image(uiImage: #imageLiteral(resourceName: "Mainbar")).offset(y: 16).edgesIgnoringSafeArea(.all)
                    HStack{
                        Spacer()
                        //Home button
                        Button(action: {
                            returnHomePage()
                        }) {
                            Text("")
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "home")).offset(y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/))
                        Spacer()
                        Spacer()
                        
                        //current button
                        Button(action: {
                            viewRouter.currentPage = .CurrentOrder
                        }) {
                            Text("")
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "cart")).frame(width:100,height:80).offset(y: 10))
                        Spacer()
                        Spacer()
                        
                        //profile button
                        Button(action: {
                            
                        }) {
                            Text("")
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "user")).offset(y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/))
                        Spacer()
                        
                    }//end HStack
                }//ende ZStack mainBar
            }//vstack
            
        }//zstack
    } //body
    
    
    func logout(){
        let auth=Auth.auth()
        do {
            try auth.signOut()
            
            UserDefaults.standard.setIsLoggedIn(value: false)
            UserDefaults.standard.setUserId(Id: "")
            UserDefaults.standard.setUserType(Type: "")
            
            viewRouter.currentPage = .LogIn
        } catch let signOutError {
            print ("Error signing out: %@", signOutError)
        }
        print("succes Loggout")
    }
    
    func getInfo(id: String, type: String) -> Void{
        if type == "M"{
            if self.member.getMember(id: id) {
                self.name = member.name
                self.email = member.email
                self.phoneNum = member.phoneNo
                self.password = member.password
                self.user = "Member"
            }else {
                if type == "C"{
                    if self.courier.getCourier(id: id){
                        self.name = member.name
                        self.email = member.email
                        self.phoneNum = member.phoneNo
                        self.password = member.password
                        self.user = "Courier"
                    }
                }
            }
        }
    }
    
    func returnHomePage(){
        //check if user loggedin
        if UserDefaults.standard.isLoggedIn(){
            //know the type of the user
            if UserDefaults.standard.getUderType() == "M"{
                
                viewRouter.currentPage = .HomePageM
                
            }else if UserDefaults.standard.getUderType() == "C"{
                
                viewRouter.currentPage = .HomePageC
                
            }else {
                print("either type")
                print(UserDefaults.standard.getUderType())
            }//end if else type
            
        }//end if logged in
    }
    
    
    
}//struct

struct ViewProfile_Previews: PreviewProvider {
    static var previews: some View {
        ViewProfile(viewRouter: ViewRouter())
    }
}
