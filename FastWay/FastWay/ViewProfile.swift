//
//  ViewProfile.swift
//  FastWay
//
//  Created by taif.m on 2/5/21.
//

import SwiftUI

struct ViewProfile: View {
    @State var name=""
    @State var email=""
    @State var phoneNum=""
   /* @State var password=""
    @State var rePassword=""*/
    @State var user=""
    @State var gender=""
    
    @Binding var showHomeCourier: Bool
    @Binding var showHomeMember: Bool
    
    var body: some View {
        
        ZStack{
          
        //background
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 49")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).offset(y:-100)
            Image(uiImage: #imageLiteral(resourceName: "Rectangle 48")).offset(y: 30)
         
            VStack{
                Image(systemName: "person").font(.system(size: 56.0)).padding(.bottom,50).offset(y: 45)
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
                            
                        }
                        
                        //save button
                        Button(action: {
                            //action here
                        }) {
                            Text("Save").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.uppercase)
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                        .padding(.top,25).offset(x: 24)
                        //logout button
                        Button(action: {
                            
                            //action here
                        }) {
                            Text("Logout").font(.custom("Roboto Bold", size: 22)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center).padding(1.0).frame(width: UIScreen.main.bounds.width - 50).textCase(.uppercase)
                        }
                        .background(Image(uiImage: #imageLiteral(resourceName: "LogInFeild")))
                        .padding(.top,25).offset(x: 24)
            
                    }//.padding(.bottom, 60)
                    
                }
              //  .padding(.bottom, 3.0)
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Mainbar")).offset(y: 16).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    HStack{
                        Spacer()
                        Image(uiImage: #imageLiteral(resourceName: "home")).offset(y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Spacer()
                        Image(uiImage: #imageLiteral(resourceName: "cart")).offset(y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Spacer()
                        Image(uiImage: #imageLiteral(resourceName: "user")).offset(y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                }
            }
            
        } //vstack 1
    } //zstack
} //view

struct ViewProfile_Previews: PreviewProvider {
    static var previews: some View {
        ViewProfile()
    }
}
