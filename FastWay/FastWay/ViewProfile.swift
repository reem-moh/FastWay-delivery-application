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
    @State var name="m"
    @State var email="m"
    @State var phoneNum="m"
    @State var password="m"
    @State var newPassword="m"
    @State var reNewPassword="m"
    @State var user="m"
    @State var gender="m"
    
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
                        let loginUser = Auth.auth().currentUser
                    
                        if let loginUser = loginUser {
                            
                            let id = loginUser.uid
                            print(id)
                            //take the document from the database
                            let docRef = db.collection("Member").document(id)
                            
                            //check if the id inside member doc
                            docRef.getDocument { (document, error) in
                                if let document = document, document.exists {
                                    print("Member")
                                    //self.showHomeMember.toggle()
                                } else {
                                    print("Courier")
                                    //self.showHomeCourier.toggle()
                                }
                            }
                        }
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
                            
                            TextField("Name", text: $name)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            
                            Text("").font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            TextField("Email", text: $email)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            
                            Text("").font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            TextField("Phone Number", text: $phoneNum)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            
                            //Password
                            Group {
                                Text("").font(.custom("Roboto Regular", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            
                                SecureField("Password", text: $password)
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
                                SecureField("Repeate new Password", text: $reNewPassword)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .font(.custom("Roboto Regular", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                                
                            }
                            
                            //Gender
                            VStack(alignment: .leading){
                                
                                Text("").font(.custom("Roboto Regular", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 5)
                                
                                Text("Gender").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                                    .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0)
                                HStack{
                                    RadioButtonGroups { selected in
                                        self.gender = selected
                                    }
                                    .padding(.trailing, 5.0)
                                    
                                }
                            }
                            
                            //user type
                            VStack(alignment: .leading){
                                
                                Text("").font(.custom("Roboto Regular", size: 18))
                                    .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 5)
                                
                                Text("Type").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                                    .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0)
                                HStack{
                                    RadioButtonGroupT { selected in
                                        self.user = selected
                                    }
                                }
                            }
                            
                        }//end group
                        
                        //logout button
                        Button(action: {
                            let auth=Auth.auth()
                            do {
                              try auth.signOut()
                            } catch let signOutError {
                              print ("Error signing out: %@", signOutError)
                            }
                            
                        }) {
                            Text("Logout").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.uppercase)
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                        .padding(.top,25).offset(x: 24)
            
                    }.padding(.bottom, 60) //VStack
                    
                }
              //  .padding(.bottom, 3.0) //scrollview
                
                //main bar
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Mainbar")).offset(y: 16).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    HStack{
                        Spacer()
                        //Home button
                        Button(action: {
                            let loginUser = Auth.auth().currentUser
                        
                            if let loginUser = loginUser {
                                
                                let id = loginUser.uid
                                print(id)
                                //take the document from the database
                                let docRef = db.collection("Member").document(id)
                                
                                //check if the id inside member doc
                                docRef.getDocument { (document, error) in
                                    if let document = document, document.exists {
                                        print("Member")
                                      //  self.showHomeMember.toggle()
                                    } else {
                                        print("Courier")
                                       // self.showHomeCourier.toggle()
                                    }
                                }
                            }
                            
                        }) {
                            Text("")
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "home")).offset(y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/))
                        Spacer()
                        Spacer()
                        //current button
                        Button(action: {
                            let loginUser = Auth.auth().currentUser
                        
                            if let loginUser = loginUser {
                                
                                let id = loginUser.uid
                                print(id)
                                //take the document from the database
                                let docRef = db.collection("Member").document(id)
                                
                                //check if the id inside member doc
                                docRef.getDocument { (document, error) in
                                    if let document = document, document.exists {
                                        print("Member")
                                        //self.showHomeMember.toggle()
                                    } else {
                                        print("Courier")
                                       //self.showHomeCourier.toggle()
                                    }
                                }
                            }
                            
                        }) {
                            Text("")
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "cart")).offset(y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/))
                        Spacer()
                        Spacer()
                        
                        //profile button
                        Button(action: {
                            let loginUser = Auth.auth().currentUser
                        
                            if let loginUser = loginUser {
                                
                                let id = loginUser.uid
                                print(id)
                                //take the document from the database
                                let docRef = db.collection("Member").document(id)
                                
                                //check if the id inside member doc
                                docRef.getDocument { (document, error) in
                                    if let document = document, document.exists {
                                        print("Member")
                                        //self.showHomeMember.toggle()
                                    } else {
                                        print("Courier")
                                       // self.showHomeCourier.toggle()
                                    }
                                }
                            }
                            
                        }) {
                            Text("")
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "user")).offset(y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/))
                        Spacer()
                    }
                }
            }//vstack
            
        } //zstack
    } //body
} //struct


