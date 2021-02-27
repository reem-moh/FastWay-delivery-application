//
//  Notifications.swift
//  FastWay
//
//  Created by taif.m on 2/26/21.
//

import SwiftUI

extension AnyTransition {
    static var fadeAndSlide: AnyTransition {
        AnyTransition.opacity.combined(with: .move(edge: .top))
    }
    
}

struct Notifications: View {
    @State var message : String
    @State var imageName : String
    //set to true if not a system image (SF Sympols)
    @State var flagImage : Bool
    var body: some View {
        
        HStack{
            if flagImage{
                Image(self.imageName)
                    .resizable()
                    .frame(width: 28, height: 28)
            }else{
                Image(systemName: self.imageName)
                    .foregroundColor(.green)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            
            
            VStack(alignment: .leading){
                Text(self.message)
            }
        }
        .padding()
        .foregroundColor(Color.black)
        .frame(width: UIScreen.main.bounds.width-10, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        
        
        
    }
    

}
func animateAndDelayWithSeconds(_ seconds: TimeInterval, action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            withAnimation {
                action()
            }
        }
    }
