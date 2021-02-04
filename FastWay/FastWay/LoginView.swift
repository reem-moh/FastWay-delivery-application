//
//  LoginView.swift
//  FastWay


import SwiftUI
import Firebase

struct LoginView: View {
    @State var email=""
    @State var pass=""
    @State var Desc=""
    
    
    // Errors
    @State var showErrorMessageEmail = false
    @State var showErrorMessagePass = false
    @State var showLogin = false
    
    @Binding var showSign: Bool
    @Binding var showHomeCourier: Bool
    @Binding var showHomeMember: Bool
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            GeometryReader{_ in
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
                ZStack{
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 100)
                    VStack(alignment: .center) {
                        
                        //logo
                        Image(uiImage: #imageLiteral(resourceName: "FastWay")).padding(.bottom,35)
                        
                        //Error in auth
                        if showLogin{
                            Text(self.Desc).font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)))
                                .offset(x: -5, y: 30)
                        }
                        
                        //Email Group
                        Group {
                            //Show Error message if the email feild empty
                            if showErrorMessageEmail {
                                Text("Error, please enter value").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)))
                                    .offset(x: -60, y: 30)
                            }
                            
                            //Email feild
                            TextField("Email", text: $email)
                                .font(.custom("Roboto Regular", size: 18))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 25).padding(.horizontal, 16)
                        }
                        
                        //Password Group
                        Group {
                            //Show Error message if the pass feild empty
                            if showErrorMessagePass {
                                Text("Error, please enter value").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)))
                                    .offset(x: -60, y: 30)
                            }
                            
                            //password feild
                            SecureField("Password", text: $pass)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 25).padding(.horizontal, 16)
                            
                            //ForgetPassword
                            HStack{
                                
                                Button(action: {
                                    self.verifyEmptyEmail()
                                }) {
                                    
                                    Text("Forget password").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.12, green: 0.46, blue: 0.8, alpha: 1))).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50)
                                    
                                }
                            }.padding(.top,-20)
                        }
                        
                        //Log in Button
                        Button(action: {
                            self.verifyEmptyEmail()
                            self.verifyEmptyPass()
                            //check if the email and passowrd in the firebase
                            if(!showErrorMessageEmail && !showErrorMessagePass){
                                self.email = self.email.lowercased()
                                Auth.auth().signIn(withEmail: self.email, password: self.pass){(res,err) in
                                    if err != nil{
                                        self.Desc=err!.localizedDescription
                                        showLogin=true
                                    }else{
                                        print("login success")
                                        showLogin=false
                                        self.showHomeCourier.toggle()
                                        
                                    }
                                    print("success")
                                    
                                }
                            }else{
                                showLogin=false
                            }
                        }) {
                            
                            Text("Log in").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).frame(width: UIScreen.main.bounds.width - 50).textCase(.uppercase)
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                        .padding(.top,25)
                        
                        //SignUp Group
                        Group {
                            // Text("OR").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50).padding(.top,20)
                            
                            Text("Don’t have an account yet? ").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50)
                            
                            //Sign up Button
                            Button(action: {
                                self.showSign.toggle()
                            }) {
                                Text("Sign up").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.12, green: 0.46, blue: 0.8, alpha: 1))).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50).padding(.top,-30).textCase(.uppercase)
                            }
                        }//end Group
                    }.offset(y: 50)
                }
            }
        }.navigationBarBackButtonHidden(true)
        
    }
    func verifyEmptyEmail(){
        if self.email.isEmpty {
            self.showErrorMessageEmail = true
        } else {
            self.showErrorMessageEmail = false
        }
    }
    func verifyEmptyPass(){
        if self.pass.isEmpty {
            self.showErrorMessagePass = true
        } else {
            self.showErrorMessagePass = false
        }
    }
    
    
}
