//
//  SignView.swift
//  FastWay

import SwiftUI

//radio button groub (SwiftUI doesn't have it)
//Gender


//Front end of the sign up page
struct SignUPView: View {
    
    
    @State var name=""
    @State var email=""
    @State var phoneNum=""
    @State var password=""
    @State var rePassword=""
    @State var user=""
    @State var gender=""
    //error variables
    @State var nErr=""
    @State var eErr=""
    @State var pErr=""
    @State var rpErr=""
    @State var phErr=""
    @State var uErr=""
    @State var gErr=""
    
    @Binding var show: Bool
    
    var body: some View {
        ZStack{
            VStack{
                //background image
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
            }
            VStack{
                //go back button
               
                //white rectangle
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 49)
            }
            VStack{
                //logo, text feilds and buttons
                Image(uiImage: #imageLiteral(resourceName: "FastWay")).padding(.bottom,25)
                VStack(alignment: .leading){
                    Text(self.nErr).font(.custom("Roboto Regular", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: -60, y: 30)
                    TextField("Name", text: $name)
                        .font(.custom("Roboto Regular", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                    
                    TextField("Email", text: $email)
                        .font(.custom("Roboto Regular", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                    
                    TextField("Phone Number", text: $phoneNum)
                        .font(.custom("Roboto Regular", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                        
                    SecureField("Password", text: $password)
                        .font(.custom("Roboto Regular", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                        
                    SecureField("Repeat Password", text: $rePassword)
                        .font(.custom("Roboto Regular", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                   //gender
                    VStack(alignment: .leading){
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
                        Text("Type").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                            .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0)
                        HStack{
                            RadioButtonGroupT { selected in
                                self.user = selected
                                        }
                        }
                    }
                    
                    //sign up button
                    Button(action: {
                        self.signUp()
                    }) {
                        Text("SIGN UP").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.uppercase)
                    }
                    .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                    .padding(.top,25).offset(x: 24)
                }
                .padding(.bottom, 3.0)
                
            }
            
        }
        
    }
    func signUp() {
        
        if self.name.count > 3{
            if self.email != ""{
                if phoneNum.count == 10{
                    if self.password.count >= 8 {
                        if self.rePassword == self.password{
                            
                        }else{
                            self.rpErr="*Password mismatch"
                        }
                    }else{
                        self.pErr="*Password must be 8 or more characters"
                    }
                }else{
                    self.phErr="*Phone number must be 05********"
                }
            }else{
                self.eErr="*Valid email is required"
            }
        }else{
            self.nErr="*Name must be more than 3 characters"
        }
        
        
        
        
    }
}



