//
//  LoginView.swift
//  FastWay


import SwiftUI
import Firebase
import FirebaseFirestore

struct LoginView: View {
    @State var email=""
    @State var pass=""
    @State var desc=""
    @State var descReset=""
    
    // Errors
    @State var showErrorMessageEmail = false
    @State var showErrorMessagePass = false
    @State var ErrorShow = false
    @State var resetShow = false

    //Navg bar
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        
        ZStack{
            
            GeometryReader{_ in
                Image(uiImage:  #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
                
                ZStack{
                    
                    Image(uiImage:  #imageLiteral(resourceName: "Rectangle 48")).offset(y: 100)
                    
                    VStack(alignment: .center) {
                        
                        //logo
                        Image(uiImage:  #imageLiteral(resourceName: "FastWaylogo")).padding(.bottom,35)
                        
                        //Error in auth
                        if ErrorShow{
                            Text(self.desc).font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)))
                                .offset(x: -5, y: 30)
                        }
                        
                        //Reset
                        if resetShow{
                            Text(self.descReset).font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)))
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
                            TextField("Email", text: $email).autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
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
                            SecureField("Password", text: $pass).autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .font(.custom("Roboto Regular", size: 18))
                                .foregroundColor( Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 2)).padding(.top, 25).padding(.horizontal, 16)
                            
                            //ForgetPassword
                            HStack{
                            
                                Button(action: {
                                    
                                    self.verifyEmptyEmail()
                                    self.reset()
        
                                }) {
                                    
                                    Text("Forget password").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50)
                                    
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
                                            self.desc=err!.localizedDescription
                                            ErrorShow=true
                                        }else{
                                            
                                            print("login success")
                                            ErrorShow=false
                                            
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
                                                        viewRouter.currentPage = .HomePageM
                                                    } else {
                                                        print("Courier")
                                                        viewRouter.currentPage = .HomePageC
                                                    }
                                                }
                                            }
 
                                        }
                                        print("success")

                                    }
                                }else{
                                    ErrorShow=false
                                }
                            }) {
                                Text("Log in").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color( #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))).frame(width: UIScreen.main.bounds.width - 50).textCase(.uppercase)
                            }
                            .background(Image(uiImage:  #imageLiteral(resourceName: "LogInFeild")))
                            .padding(.top,25)
                        
                        //SignUp Group
                        Group {
                           Text("OR").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50).padding(.top,20)
                            
                            Text("Don’t have an account yet? ").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color( #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50)
                            
                            //Sign up Button
                            Button(action: {
                                viewRouter.currentPage = .SignUp
                                }) {
                                    Text("Sign up").font(.custom("Roboto Regular", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50).padding(.top,-30).textCase(.uppercase)
                            }
                        }//end Group
                    
                    }.offset(y: 50)
                }
            }

        }
            
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
    
    func reset(){
        if !showErrorMessageEmail {
            Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
                
                if err != nil {
                    self.desc=err!.localizedDescription
                    ErrorShow=true
                }else{
                    print("success")
                    self.descReset="Password reset link has been sent successfully"
                    resetShow=true
                    self.desc=""
                    ErrorShow=false
                }
            }
        }else{
            self.desc=""
        }
        
    }
    
    

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView(viewRouter: ViewRouter())
        }
    }
}

