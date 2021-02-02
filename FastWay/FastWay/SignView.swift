//
//  SignView.swift
//  FastWay

import SwiftUI
 
//radio button groub (SwiftUI doesn't have it)
//Gender
enum Gender: String {
    case male = "Male"
    case female = "Female"
}

struct RadioButtonGroups: View {
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View {
        HStack {
            radioMaleMajority
            radioFemaleMajority
        }
    }
    
    var radioMaleMajority: some View {
        RadioButtonField(
            id: Gender.male.rawValue,
            label: Gender.male.rawValue,
            color: Color(#colorLiteral(red: 0.53, green: 0.53, blue: 0.53, alpha: 1)),
            textSize: 18,
            isMarked: selectedId == Gender.male.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioFemaleMajority: some View {
        RadioButtonField(
            id: Gender.female.rawValue,
            label: Gender.female.rawValue,
            color: Color(#colorLiteral(red: 0.53, green: 0.53, blue: 0.53, alpha: 1)),
            textSize: 18,
            isMarked: selectedId == Gender.female.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}

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
                    if nErr{
                        Text("*A valid name contains more than 3 characters")
                    }
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
                        Text("Gender").font(.custom("Roboto Medium", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.38, green: 0.37, blue: 0.37, alpha: 1)))
                            .tracking(-0.01).multilineTextAlignment(.center) .padding(.leading, 12.0)
                        HStack{
                            RadioButtonGroups { selected in
                                self.gender = selected
                                        }

                        }
                    }
                    
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
