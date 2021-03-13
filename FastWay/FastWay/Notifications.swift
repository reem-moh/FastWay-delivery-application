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
var cancelNoti : Bool = false

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
                self.message = "Your order has been sent successfully."
            case .SendOffer:
                self.message = "Your offer has been sent successfully."
            case .CancelOrder:
                self.message = "Your order has been canceled successfully."
            case .CancelOffer:
                self.message = "Your Offer has been canceled successfully."
            case .CancelByDefault:
                self.message = "Your order has been without offers for 15 minutes, So it canceled automatically."
            case .AcceptOffer:
                self.message = "Your order has been assigned to a courier."
            case .DeclineOffer:
                self.message = "The offer has been declined successfully"
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
    case CancelByDefault
    case AcceptOffer
    case DeclineOffer
}

