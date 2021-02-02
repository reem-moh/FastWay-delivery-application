//
//  LoginView.swift
//  FastWay


import SwiftUI

struct LoginView: View {
    @State var email=""
    @State var pass=""
    
    @Binding var show: Bool
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            GeometryReader{_ in
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
                ZStack{
                    Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 100)
                    VStack(alignment: .center) {
                        //logo
                        Image(uiImage: #imageLiteral(resourceName: "FastWay")).padding(.bottom,35)
                        
                        //Email feild
                        TextField("Email", text: $email)
                            .font(.custom("Roboto Regular", size: 18))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 25).padding(.horizontal, 16)
                        //password feild
                        SecureField("Password", text: $pass)
                            .font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 25).padding(.horizontal, 16)
                        
                        //ForgetPassword
                        HStack{
                            
                            
                            Button(action: {
                                // What to perform
                            }) {
                                
                                Text("Forget password").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.12, green: 0.46, blue: 0.8, alpha: 1))).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50)
                                
                            }
                        }.padding(.top,-20)
                        
                        
                        //Log in Button
                            Button(action: {
                                // What to perform
                            }) {
                                Text("Log in").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).frame(width: UIScreen.main.bounds.width - 50).textCase(.uppercase)
                            }
                            .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                            .padding(.top,25)
                        
                        
                        Text("OR").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50).padding(.top,20)
                        
                        Text("Don’t have an account yet? ").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50)
                        //Sign up Button
                            Button(action: {
                                self.show.toggle()
                            }) {
                                Text("Sign up").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.12, green: 0.46, blue: 0.8, alpha: 1))).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50).padding(.top,-30).textCase(.uppercase)
                            }
                    }.offset(y: 50)
                }
            }
       }.navigationBarBackButtonHidden(true)
            
    }
}
