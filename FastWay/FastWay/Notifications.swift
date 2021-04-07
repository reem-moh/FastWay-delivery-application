//
//  Notifications.swift
//  FastWay
//
//  Created by taif.m on 2/26/21.
//

import SwiftUI
import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging
import FirebaseInstanceID



//REMOTE NOTIFCATION FIREBASE

// Please change it your physical phone device FCM Token
// To get it, touch the handleLogTokenTouch button and see log
let ReceiverFCMToken = "Physical_Phone_Receiver_FCMToken_String"

// Please change it your Firebase Legacy server key
// Firebase -> Project settings -> Cloud messaging -> Legacy server key
let legacyServerKey = "AAAA6oq0MN0:APA91bGeP_sOn5foiNlseAZ1YDUef2OOA9g1kST7MHR3gxjM2wyhHhpvxOmm03vuMRebZN56C6KuYJP-7RhaPlQ0yGh1ZICJ2rQ03-NYAiUwR1BXA8X3H6_LOybm2_VPNqYGdQdmaHPb"

/*struct ContentView: View {
    @State private var fcmTokenMessage = "fcmTokenMessage"
    @State private var instanceIDTokenMessage = "instanceIDTokenMessage"
    
    @State private var notificationTitle: String = ""
    @State private var notificationContent: String = ""
    var body: some View {
        VStack {
            Text(fcmTokenMessage).padding(20)
            Text(instanceIDTokenMessage).padding(20)
            Button(action: {handleLogTokenTouch()}) {
                Text("Get user FCM Token String").font(.title)
            }.padding(20)
            
            TextField("Add Notification Title", text: $notificationTitle).textFieldStyle(RoundedBorderTextFieldStyle()).padding(20)
            TextField("Add Notification Content", text: $notificationContent).textFieldStyle(RoundedBorderTextFieldStyle()).padding(20)
            Button(action: {sendMessageTouser(to: ReceiverFCMToken, title: self.notificationTitle, body: self.notificationContent)
                self.notificationTitle = ""
                self.notificationContent = ""
            }) {
                Text("Send message to User").font(.title)
            }.padding(20)
        }
    }
    
    }*/

func sendMessageTouser(to token: String, title: String, body: String) {
    print("sendMessageTouser() \nToken: \(token)\n\n")
    let urlString = "https://fcm.googleapis.com/fcm/send"
    let url = NSURL(string: urlString)!
    let paramString: [String : Any] = ["to" : token,
                                       "notification" : ["title" : title, "body" : body],
                                       "data" : ["user" : "test_id"]
    ]
    let request = NSMutableURLRequest(url: url as URL)
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("key=\(legacyServerKey)", forHTTPHeaderField: "Authorization")
    let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
        do {
            if let jsonData = data {
                if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                    NSLog("Received data:\n\(jsonDataDict))")
                }
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    task.resume()
}

/*func handleLogTokenTouch(){
    // [START log_fcm_reg_token]
    let token = Messaging.messaging().fcmToken
    print("FCM token: \(token ?? "")")
    // [END log_fcm_reg_token]
    //fcmTokenMessage  = "Logged FCM token: \(token ?? "")"

    // [START log_iid_reg_token]
    
    
    
    InstanceID.instanceID().instanceID { (result, error) in
      if let error = error {
        print("Error fetching remote instance ID: \(error)")
      } else if let result = result {
        print("Remote instance ID token: \(result.token)")
        //instanceIDTokenMessage  = "Remote InstanceID token: \(result.token)"
      }
    }
    // [END log_iid_reg_token]
}*/

func registerTokenMember(memberId: String, completion: @escaping (_ success: Bool) -> Void){ //index of status array
    let token = Messaging.messaging().fcmToken
    print("FCM token: \(token ?? "")")
    
    db.collection("Member").document(memberId).setData([ "Token": token ?? "" ], merge: true)
    let success = true
    DispatchQueue.main.async {
        print("inside registerTokenMember in dispatch ")
        completion(success)
    }
}

func registerTokenCourier(courierId: String, completion: @escaping (_ success: Bool) -> Void){ //index of status array
    let token = Messaging.messaging().fcmToken
    print("FCM token: \(token ?? "")")
    
    db.collection("Courier").document(courierId).setData([ "Token": token ?? "" ], merge: true)
    let success = true
    DispatchQueue.main.async {
        print("inside registerTokenCourier in dispatch ")
        completion(success)
    }
}




/*struct n : Identifiable {
    var id = ""
    var token = ""
}




class Not : ObservableObject{
    @Published var tokenM = n()
    @Published var tokenC = n()
    
    
    init() {
        //
    }
    func getMemberToken(memberId: String, completion: @escaping (_ success: Bool) -> Void) {
        
        //var tokenM = ""
        db.collection("Member").document(memberId).addSnapshotListener { (querySnapshot, error) in
            guard let doc = querySnapshot else{
                print("no member document")
                return
            }
            guard let data = doc.data() else {
                print("no member data")
                return
            }
            //assign values from db to variables
            let tM = data["Token"] as? String ?? ""
            self.tokenM = n(token: tM)
            print("tokenM inside \(self.tokenM.token)")
            
        } //listener
        let success = true
        DispatchQueue.main.async {
            print("tokenM \(self.tokenM.token)")
            print("inside getMemberToken in dispatch ")
            completion(success)
        }
        
        
    }
    
    
    
    
    
    func getCourierToken(courierId: String, completion: @escaping (_ success: Bool) -> Void) {
        
        //var tokenC = ""
        db.collection("Courier").document(courierId).addSnapshotListener { (querySnapshot, error) in
            guard let doc = querySnapshot else{
                print("no courier document")
                return
            }
            guard let data = doc.data() else {
                print("no courier data")
                return
            }
            //assign values from db to variables
            let tC = data["Token"] as? String ?? ""
            self.tokenC = n(token: tC)
            
            
        } //listener
        let success = true
        DispatchQueue.main.async {
            print("tokenC \(self.tokenC.token)")
            print("inside registerTokenMember in dispatch ")
            completion(success)
        }
        
            }

}*/





























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
                self.message = "Sorry your order has been cancelled, it has been without offers for 15 minutes."
            case .AcceptOffer:
                self.message = "Your order has been assigned to a courier."
            case .DeclineOffer:
                self.message = "The offer has been declined successfully"
            case .updateProfile:
                self.message = "Your profile has been updated successfully"
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
    case updateProfile
}





