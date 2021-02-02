//
//  LoginView.swift
//  FastWay


import SwiftUI

struct LoginView: View {
    @State var email=""
    @State var pass=""
    var body: some View {
        ZStack{
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
            ZStack{
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 140)
                VStack {
                    Image(uiImage: #imageLiteral(resourceName: "FastWay")).padding(.bottom,35)
                    
                    TextField("Email", text: $email)
                        .font(.system(size: 18))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 25).padding(.horizontal, 16)
                   
                    TextField("Password", text: $pass)
                        .font(.custom("Roboto Regular", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 25).padding(.horizontal, 16)
                    
                    //Log in
                    Button(action: {
                        // What to perform
                    }) {
                        // How the button looks like
                    }
                    Text("Login").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).tracking(-0.01).multilineTextAlignment(.center)
                    //Available in iOS 14 only
                    .textCase(.uppercase)
                    
                    //Image(uiImage: #imageLiteral(resourceName: "LogInFeild"))
                    Text("Forget password? Click to reset")
                    Text("OR")
                    Text("Don’t have an account yet? Sign up")
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
