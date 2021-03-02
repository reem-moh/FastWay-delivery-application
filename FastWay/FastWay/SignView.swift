//
//  SignView.swift
//  FastWay
//
//  Created by taif.m on 2/8/21.
//
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
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    func isValidPhoneNumber() -> Bool {
        //^\\+(?:[0-9]?){6,14}[0-9]
        let regEx = "[05]{2}[0-9]{4}[0-9]{4}$"
        
        let phoneCheck = NSPredicate(format: "SELF MATCHES[c] %@", regEx)
        return phoneCheck.evaluate(with: self)
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
    //@State var gender=""
    //error variables
    @State var error = false
    @State var nErr=""
    @State var eErr=""
    @State var pErr=""
    @State var rpErr=""
    @State var phErr=""
    @State var uErr=""
    // @State var gErr=""
    
    //Navg bar
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack{
            
            //background image
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
            //white rectangle
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 50)
            
            VStack{
                //go back button
                //arrow_back image
                Button(action: {
                    viewRouter.notificationT = .None
                    viewRouter.currentPage = .LogIn
                    
                }) {
                    Image("arrow_back")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipped()
                }.position(x:30 ,y:20).padding(1.0)
            }
            VStack{
                
                //logo, text feilds and buttons
                Image(uiImage: #imageLiteral(resourceName: "FastWay")).padding(.bottom,40).offset(y: 60)
                
                ScrollView{
                    VStack(alignment: .leading){
                        
                        Group {
                            
                            //error for name
                            Text(nErr).font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)))
                                .padding(.trailing)
                                .offset(x: 12,y: 10)
                            //name field
                            TextField("Name", text: $name, onCommit: {
                                self.error = false
                                self.nErr=""
                                if self.name.count < 3 {
                                    self.nErr="*Name must be more than 2 characters"
                                    self.error = true
                                }
                                
                            })
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            
                            //error for email
                            Text(eErr).font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            //email field
                            TextField("Email", text: $email, onCommit: {
                                self.error = false
                                self.eErr=""
                                if (self.email == "") || !(self.email.isEmail()){
                                    self.eErr="*Valid email is required"
                                    self.error = true
                                }
                            })
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            
                            //error for phone number
                            Text(self.phErr).font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            // phone number field
                            TextField("Phone Number", text: $phoneNum, onCommit: {
                                self.error = false
                                self.phErr=""
                                if !(self.phoneNum.isValidPhoneNumber()){
                                    self.phErr="*Phone number must be 05********"
                                    self.error = true
                                }
                            })
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                            
                            //error for password
                            Text(self.pErr).font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                            
                            //pass feild
                            SecureField("Password", text: $password, onCommit: {
                                self.error = false
                                self.pErr=""
                                if self.password.count < 8 || !checkPass(pass: self.password){
                                    self.pErr="*Password must be 8 or more characters, conatins a capital letter, a small letter and a digit"
                                    self.error = true
                                }
                            })
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                        }//end group
                        
                        //error for repeat pass
                        Text(self.rpErr).font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 10)
                        
                        //repeat pass field
                        SecureField("Repeat Password", text: $rePassword, onCommit: {
                            self.error = false
                            self.rpErr=""
                            if self.rePassword != self.password{
                                self.rpErr="*Password mismatch"
                                self.error = true
                            }
                        })
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 10).padding(.horizontal, 16)
                        
                        VStack(alignment: .leading){
                            
                            //error for type(courier, member)
                            Text(self.uErr).font(.custom("Roboto Regular", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))).offset(x: 12,y: 5)
                            
                            //type(courier, member) field
                            Text("Type").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                                .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0)
                            HStack{
                                RadioButtonGroupT { selected in
                                    self.user = selected
                                }
                            }
                        }//end VStack
                        
                        //sign up button
                        Button(action: {
                            self.signUp()
                            
                        }) {
                            Text("Sing Up").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.none)
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
        
        self.nErr=""
        self.uErr=""
        
        if self.name == "" || self.email == "" || self.phoneNum == "" || self.password == "" || self.rePassword == "" || self.user == ""{
            self.nErr="*All fields are required"
            self.error = true
        }
        
        if self.user == "" && (self.name == "" || self.email == "" || self.phoneNum == "" || self.password == "" || self.rePassword == ""){
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
                            let courier = Courier(id: id,name: self.name, email: self.email, phN: self.phoneNum)
                            if courier.addCourier(courier: courier) {
                                print("Courier")
                                UserDefaults.standard.setIsLoggedIn(value: true)
                                UserDefaults.standard.setUserId(Id: id)
                                UserDefaults.standard.setUserType(Type: "C")
                                viewRouter.notificationT = .SignUp
                                viewRouter.currentPage = .HomePageC
                            }else{
                                nErr = "An error occurred please try again"
                            }
                        }else{
                            if user == "Member"{
                                let member = Member(id: id, name: self.name, email: self.email, phN: self.phoneNum)
                                if member.addMember(member: member) {
                                    print("Member")
                                    UserDefaults.standard.setIsLoggedIn(value: true)
                                    UserDefaults.standard.setUserId(Id: id)
                                    UserDefaults.standard.setUserType(Type: "M")
                                    viewRouter.notificationT = .SignUp
                                    viewRouter.currentPage = .HomePageM
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
    
    func checkPass(pass: String) -> Bool {
        var digit = false
        var cLetter = false
        var sLetter = false
        for char in pass {
            if char.isLetter && char.isUppercase {
                cLetter = true
            }else{
                if char.isLetter && char.isLowercase {
                    sLetter = true
                }else{
                    if char.isNumber {
                        digit = true
                    }
                }
            }
        }
        return digit && cLetter && sLetter
    }
    
}



struct SignUPView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUPView(viewRouter: ViewRouter())
        }
    }
}
