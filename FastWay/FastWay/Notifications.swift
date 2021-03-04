//
//  Notifications.swift
//  FastWay
//
//  Created by taif.m on 2/26/21.
//

import SwiftUI


var notificationT : NotificationType = .None
extension AnyTransition {
    static var fadeAndSlide: AnyTransition {
        AnyTransition.opacity.combined(with: .move(edge: .top))
    }
    
}

struct Notifications: View {
    @State var type : NotificationType
    @State var message = ""
    @State var imageName : String
    
    var body: some View {
        
        HStack{
            
            Image(self.imageName)
                .resizable()
                .frame(width: width(num:28), height: hieght(num:28))
            
            
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
        .onAppear {
            switch self.type {
            case .SignUp:
                self.message = "Welcome, you\'ve been signed up successfuly"
            case .None:
                self.message = ""
            case .LogIn:
                self.message = "Welcome, you\'ve been Logged in successfuly"
            case .SendOrder:
                self.message = "Your order have been sent successfuly"
            case .SendOffer:
                self.message = "Your offer have been sent successfuly"
            case .CancelOrder:
                self.message = "Your order have been canceled successfuly"
                
            case .CancelOffer:
                self.message = "Your Offer have been canceled successfuly"
            }
        }
    }
    
}
func animateAndDelayWithSeconds(_ seconds: TimeInterval, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        withAnimation {
            action()
        }
    }
}



// to identify each notificatio or confirmation message when transitioning from one
// view to the other
enum NotificationType {
    case None
    case LogIn
    case SignUp
    case SendOrder
    case SendOffer
    case CancelOrder
    case CancelOffer
}
