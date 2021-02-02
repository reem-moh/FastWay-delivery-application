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
    @State var nErr=false
    @State var eErr=false
    @State var phErr=false
    @State var pErr=false
    @State var rpErr=false
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
                        // What to perform
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
    
}

struct SignView_Previews: PreviewProvider {
    static var previews: some View {
        SignUPView()
    }
}

func checkName(name : String) -> Bool {
    if name.count<3{
        return false
    }
    return true
}
func checkPass(pass: String) -> Bool {
    if pass.count<8{
        return false
    }
    return true
}
