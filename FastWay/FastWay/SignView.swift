//
//  SignView.swift
//  FastWay
//
//  Created by taif.m on 2/1/21.
//

import SwiftUI
//Front end of the sign up page
struct SignUPView: View {
    @State var name=""
    @State var email=""
    @State var phoneNum=""
    @State var password=""
    @State var rePassword=""
    @State var female=false
    @State var male=false
    @State var courier=false
    @State var member=false
    var body: some View {
        ZStack{
            VStack{
                //background image
                Image("Rectangle 49").ignoresSafeArea()
                Spacer()
            }
            VStack{
                //white rectangle
                Spacer(minLength: 100)
                Image("Rectangle 48").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            }
            VStack{
                //logo, text feilds and buttons
                Image("FastWay")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 91, height: 82)
                    .clipped()
                VStack(alignment: .leading){
                    TextField("Name", text: $name)
                        .font(.system(size: 18))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).padding(.horizontal, 11.0)
                    
                    TextField("Email", text: $name)
                        .font(.system(size: 18))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).keyboardType(.emailAddress).padding(.horizontal, 11.0)
                    
                    TextField("Phone Number", text: $name)
                        .font(.system(size: 18))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1)).padding(.horizontal, 11.0)
                    
                    SecureField("Password", text: $name)
                        .font(.system(size: 18))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1))
                            .padding(.horizontal, 11.0)
                        
                    SecureField("Repeat Password", text: $name)
                        .font(.system(size: 18))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color(.gray), lineWidth: 1))
                            .padding(.horizontal, 11.0)
                    VStack(alignment: .leading){
                        Text("Gender").font(.system(size: 18, weight: .medium))
                            .foregroundColor(.primary)
                        HStack{
                            
                        }
                    }
                    .padding(.leading)
            }
        }
    }
}
}

struct SignView_Previews: PreviewProvider {
    static var previews: some View {
        SignUPView()
    }
}
