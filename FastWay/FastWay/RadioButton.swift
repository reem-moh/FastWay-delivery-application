//
//  RadioButton.swift
//  FastWay
//
//  Created by taif.m on 2/2/21.
//

import SwiftUI

//MARK:- Single Radio Button Field
struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 20,
        color: Color = Color.black,
        textSize: CGFloat = 14,
        isMarked: Bool = false,
        callback: @escaping (String)->()
    ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Spacer()
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width(num:self.size), height: hieght(num:self.size))
                Text(label)
                    .font(Font.system(size: fontSize(num:textSize)))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}


//for user type
enum UserType: String {
    case courier = "Courier"
    case member = "Member"
}

struct RadioButtonGroupT: View {
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View {
        HStack {
            radioCourierMajority
            radioMemberMajority
        }
    }
    
    var radioCourierMajority: some View {
        RadioButtonField(
            id: UserType.courier.rawValue,
            label: UserType.courier.rawValue,
            color: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)),
            textSize: fontSize(num:18),
            isMarked: selectedId == UserType.courier.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioMemberMajority: some View {
        RadioButtonField(
            id: UserType.member.rawValue,
            label: UserType.member.rawValue,
            color: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)),
            textSize: fontSize(num:18),
            isMarked: selectedId == UserType.member.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}







struct DotView: View {
    @State var delay: Double = 0 // 1.
    @State var scale: CGFloat = 0.5
    @State var frame: CGFloat = 20
    @State var rad: CGFloat = 10
    var body: some View {
        Image("purple")
            .resizable()
            .frame(width: width(num: frame), height: hieght(num: frame))
            .cornerRadius(rad)
            .padding(.horizontal, width(num: -4))
            .scaleEffect(scale)
            .animation(Animation.easeInOut(duration: 0.6).repeatForever().delay(delay)) // 2.
            .onAppear {
                withAnimation {
                    self.scale = 0.8
                }
            }
    }
}



/*
 DotView()
 DotView(delay: 0.2)
 DotView(delay: 0.4)
*/
