//
//  SignView.swift
//  FastWay

import SwiftUI
import Firebase

//to validate the email format
let __firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
let __serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
let __emailRegex = __firstpart + "@" + __serverpart + "[A-Za-z]{2,8}"
let __emailPredicate = NSPredicate(format: "SELF MATCHES %@", __emailRegex)
extension String {
    func isEmail() -> Bool {
        return __emailPredicate.evaluate(with: self)
    }
}
extension UITextField {
    func isEmail() -> Bool {
        return self.text!.isEmail()
    }
}


struct SignUPView: View {
    
    @State var name=""
    @State var email=""
    @State var phoneNum=""
    @State var password=""
    @State var rePassword=""
    @State var user=""
    @State var gender=""
    //error variables
    @State var error = false
    @State var nErr=""
    @State var eErr=""
    @State var pErr=""
    @State var rpErr=""
    @State var phErr=""
    @State var uErr=""
    @State var gErr=""
    
    @Binding var show: Bool
    @Binding var showHomeCourier: Bool
    @Binding var showHomeMember: Bool
    
    var body: some View {
        ZStack{
            VStack{
                //background image
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
            }
            VStack{
                //go back button
                
                //white rectangle
                Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 10)
            }
            VStack{
                //logo, text feilds and buttons
                Image(uiImage: #imageLiteral(resourceName: "FastWay")).padding(.bottom,0).offset(y: 15)
                
                ScrollView{
                    VStack(alignment: .leading){
                        Group {
                            Text(nErr).font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            TextField("Name", text: $name)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            
                            Text(eErr).font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            TextField("Email", text: $email)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            
                            Text(self.phErr).font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            TextField("Phone Number", text: $phoneNum)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            
                            Text(self.pErr).font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            SecureField("Password", text: $password)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                        }
                        
                        Text(self.rpErr).font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                        
                        SecureField("Repeat Password", text: $rePassword)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.73, green: 0.72, blue: 0.72, alpha: 1)))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                        //gender
                        VStack(alignment: .leading){
                            
                            Text(self.gErr).font(.custom("Roboto Regular", size: 18))
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
                            
                            Text(self.uErr).font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 5)
                            
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
                    }.padding(.bottom, 60)
                }
                .padding(.bottom, 3.0)
                
            }
            
        }
        
    }
    func signUp() {
        self.error = false
        if self.name.count < 3 {
            self.nErr="*Name must be more than 3 characters"
            self.error = true
        }
        
        if (self.email == "") || !(self.email.isEmail()){
            self.eErr="*Valid email is required"
            self.error = true
        }
        if (phoneNum.count != 10) {
            self.phErr="*Phone number must be 05********"
            self.error = true
        }
        if self.password.count < 8{
            self.pErr="*Password must be 8 or more characters"
            self.error = true
        }
        if self.rePassword != self.password{
            self.rpErr="*Password mismatch"
            self.error = true
        }
        if self.gender == ""{
            self.gErr="*Gender must be specified"
            self.error = true
        }
        if self.user == ""{
            self.uErr="*This field is mandatory"
            self.error = true
        }
        if !self.error {
            //convert to lowercase before saving to DB
            self.email = self.email.lowercased()
            Auth.auth().createUser(withEmail: self.email, password: self.password) { (res, err) in
                
                if err != nil {
                    self.nErr = err!.localizedDescription
                    
                }else{
                    let signedUser = Auth.auth().currentUser
                    
                    if let signedUser = signedUser {
                        let id = signedUser.uid
                        
                        if user == "Courier"{
                            let courier = Courier(id: id,name: self.name, email: self.email, pass: self.password, phN: self.phoneNum, gen: self.gender)
                            if courier.addCourier(courier: courier) {
                                self.showHomeCourier.toggle()
                            }else{
                                nErr = "An error occurred please try again"
                            }
                        }else{
                            if user == "Member"{
                                let member = Member(id: id, name: self.name, email: self.email, pass: self.password, phN: self.phoneNum, gen: self.gender)
                                if member.addMember(member: member) {
                                    print("added")
                                }else{
                                    nErr = "An error occurred please try again"
                                }
                            }
                        }
                    }
                    
                }
                
            }
        }
        
    }
    
}



