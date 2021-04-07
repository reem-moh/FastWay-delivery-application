//
//  classes.swift
//  FastWay
//
//  Created by taif.m on 2/4/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine
import MapKit
import UserNotifications


let db = Firestore.firestore()

class Member: ObservableObject {
    
    var id: String
    var name: String
    var email: String
    var phoneNo: String
    
    @Published var member = M(id: "", name: "", email: "", phoneNo: "")
    //initialize from DB
    init(id : String = UserDefaults.standard.getUderId()) {
        self.id = ""
        self.name = ""
        self.email = ""
        self.phoneNo = ""
        self.getMember(id: id)
    }
    
    init(id: String, name: String, email: String, phN: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phoneNo = phN
    }
    
    func addMember(member: Member) -> Bool {
        var flag = true
        if id != nil && id != "" {
        let doc = db.collection("Member").document(id)
        doc.setData(["ID":self.id, "Name":self.name, "PhoneNo": self.phoneNo, "Email": self.email]) { (error) in
            
            if error != nil {
                flag = false
            }
        }
    }
        return flag
    }
    
    //retrieve from database
    func getMember(id: String){
        
        if id != nil && id != "" {
        db.collection("Member").document(id).addSnapshotListener { (querySnapshot, error) in
            guard let doc = querySnapshot else{
                print("no member document")
                return
            }
            guard let data = doc.data() else {
                print("no member data")
                return
            }
            //assign values from db to variables
            self.member.id = id
            self.member.name = data["Name"] as? String ?? ""
            self.member.email = data["Email"] as? String ?? ""
            self.member.phoneNo = data["PhoneNo"] as? String ?? ""
            
            print("----------")
            print("inside class Member")
            print("got member data  \(self.member.name)")
            print("got member data  \(self.member.email)")
            print("got member data  \(self.member.phoneNo)")
            print("----------")
            
        } //listener
    }
    } //function
    
    
    func getMemberToken(memberId: String, completion: @escaping (_ success: Bool) -> Void) {
        if memberId != nil && memberId != "" {
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
            self.member.token = tM
            print("tokenM inside \( self.member.token)")
            let success = true
            DispatchQueue.main.async {
                print("tokenM DispatchQueue \( self.member.token)")
                print("inside getMemberToken in dispatch ")
                completion(success)
            }
        } //listener
        
    }
        
    }
    
    func editProfileMember(memberId: String,email: String, name: String, phone: String,changeEmail: Bool){
        if memberId != nil && memberId != "" {
        let doc = db.collection("Member").document(memberId)
        doc.setData(["Name":name, "PhoneNo": phone], merge: true) { (error) in
            if error != nil {
                print("error in change profile")
            }else {
                print("Edit profile")
            }
        }
            if changeEmail {

                Auth.auth().currentUser?.updateEmail(to: email){ (error) in
                    if error != nil{
                        print("error in change email inside auth \(error)")
                    }else{
                        print("change email successfully inside auth")
                        doc.setData(["Email": email], merge: true) { (error) in
                            if error != nil {
                                print("error in change email inside cloud")
                            }else {
                                print("change email inside cloud")
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
}

//for both courier and member
func changePass(ChangesPass: String){
    Auth.auth().currentUser?.updatePassword(to: ChangesPass) { (error) in
        if error != nil{
            print("error in change password")
        }else{
            print("change password successfully")
        }
    }
}

class Courier: ObservableObject {
    var id: String
    var name: String
    var email: String
    var phoneNo: String
    @Published var courier = C(id: "", name: "", email: "", phoneNo: "")
    //initialize from DB
    init(id: String = UserDefaults.standard.getUderId()) {
        self.id = ""
        self.name = ""
        self.email = ""
        self.phoneNo = ""
        self.getCourier(id: id)
    }
    
    
    init(id: String,name: String, email: String, phN: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phoneNo = phN
    }
    
    func addCourier(courier: Courier) -> Bool {
        let doc = db.collection("Courier").document(id)
        var flag = true
        doc.setData(["ID":self.id, "Name":self.name, "PhoneNo": self.phoneNo, "Email": self.email]) { (error) in
            
            if error != nil {
                flag = false
            }
        }
        
        return flag
    }
    
    //retrieve from database
    func getCourier(id: String){
        
        db.collection("Courier").document(id).addSnapshotListener { (querySnapshot, error) in
            guard let doc = querySnapshot else{
                print("no courier document")
                return
            }
            guard let data = doc.data() else {
                print("no courier data")
                return
            }
            //assign values from db to variables
            self.courier.id = id
            self.courier.name = data["Name"] as? String ?? ""
            self.courier.email = data["Email"] as? String ?? ""
            self.courier.phoneNo = data["PhoneNo"] as? String ?? ""
            
            print("----------")
            print("inside class Courier")
            print("got Courier data  \(self.courier.name)")
            print("got Courier data  \(self.courier.email)")
            print("got Courier data  \(self.courier.phoneNo)")
            print("----------")
            
        } //listener
    } //function
    
    
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
            self.courier.token = tC
            print("tokenC inside \(self.courier.token)")
            let success = true
            DispatchQueue.main.async {
                print("tokenC  DispatchQueue \(self.courier.token)")
                print("inside getCourierToken in dispatch ")
                completion(success)
            }
        } //listener
        print("tokenC outside \(self.courier.token)")
        
        
            }
    
    func editProfileCourier(courierId: String,email: String, name: String, phone: String){
        let doc = db.collection("Courier").document(courierId)
        doc.setData(["Name":name, "PhoneNo": phone, "Email": email], merge: true) { (error) in
            if error != nil {
                print("error in change profile")
            }else {
                print("Edit profile")
            }
        }
    }
    
}

//member info
struct M: Identifiable {
    var id: String
    var name: String
    var email: String
    var phoneNo: String
    var token = ""
}
//Courier info
struct C: Identifiable {
    var id: String
    var name: String
    var email: String
    var phoneNo: String
    var token = ""
}
//order info
struct OrderDetails: Identifiable {
    var id: String
    var pickUP: CLLocationCoordinate2D!
    var pickUpBulding: Int
    var pickUpFloor: Int
    var pickUpRoom: String
    var dropOff: CLLocationCoordinate2D!
    var dropOffBulding: Int
    var dropOffFloor: Int
    var dropOffRoom: String
    var orderDetails: String
    var memberId : String
    var courierId : String = ""
    var deliveryPrice = 0
    var totalPrice = 0.0
    var courierLocation: CLLocationCoordinate2D!
    //to identify whether it is added to cart...
    var isAdded: Bool
    var createdAt : Date = Date()
    var status : String
}
//offer info
struct Offer : Identifiable {
    var id: String
    var OrderId: String
    var memberId: String = ""
    var courierId: String = ""
    var courier : Courier
    var price: Int
    var courierLocation : CLLocationCoordinate2D
}

//chat msg
struct ChatMsg : Identifiable {
    var id: String //msg id of chat
    var orderId : String
    var senderID : String
    var timeSent : Date
    var msg : String
}

struct Tracking : Identifiable {
    var id: String //order id of chat (document id)
    var courierLocation : CLLocationCoordinate2D
}

class Order: ObservableObject{
    
    @Published var orders: [OrderDetails] = [] //for delivery requests have an offer
    @Published var ordersCanceled: [OrderDetails] = [] //for cancel order by default
    @Published var memberOrder: [OrderDetails] = [] //for current order
    @Published var WaitingOrders: [OrderDetails] = [] //for delivery requests waiting
    @Published var CourierOrderOfferedAssign: [OrderDetails] = [] // for current order
    @Published var CourierOrderCancelled: [OrderDetails] = [] // for current order
    @Published var MemberOrderCancelled: [OrderDetails] = [] // for current order
    @Published var CourierOrderOfferedWaiting: [OrderDetails] = []  //for current order
    @Published var offers: [Offer] = [] // retrieve offer for specific order
    @Published var collectAllOffersForCourier: [Offer] = [] //get data from offer collection
    @Published var orderID: [String] = [] //calculate all order who have state have an offer
   // @Published var riyadhCoordinatetracking = CLLocationCoordinate2D()

    @Published var traking: Tracking = Tracking(id: "", courierLocation: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
    
    @Published var chat: [ChatMsg] = [] //for messages in chat
    
    @Published var liveStatus = "assigned"
    @Published var nameSender = ""
    var pickUP: CLLocationCoordinate2D!
    var pickUpBulding: Int
    var pickUpFloor: Int
    var pickUpRoom: String
    var dropOff: CLLocationCoordinate2D!
    var dropOffBulding: Int
    var dropOffFloor: Int
    var dropOffRoom: String
    var orderDetails: String
    var memberId: String
    var memberName: String
    var setPick: Bool
    var setDrop: Bool
    var setDetails: Bool
    var status: [String] = ["waiting for offer", "cancled","have an offer","assigned","pick Up","on The Way" , "drop off", "completed"]
    
    init(){
        self.pickUP =  CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        self.pickUpBulding = 0
        self.pickUpFloor = -1
        self.pickUpRoom = ""
        self.dropOff =  CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        self.dropOffBulding = 0
        self.dropOffFloor = -1
        self.dropOffRoom = ""
        self.orderDetails =  ""
        self.memberId = ""
        self.memberName = ""
        self.setPick = false
        self.setDrop = false
        self.setDetails = false
    }
    
    //****************************
    //For Courier user
    //****************************
    //Retrieve all orders and check if it exceeds 15 minutes to cancel the order
    func getOrderForCancel() {
        print("\n*******GetOrder*********")
        db.collection("Order").whereField("Assigned", isEqualTo: "false").order(by: "CreatedAt", descending: false).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No order documents")
                return
            }
            self.ordersCanceled = documents.map({ (queryDocumentSnapshot) -> OrderDetails in
                let data = queryDocumentSnapshot.data()
                let OrderId = queryDocumentSnapshot.documentID
                let state = data["Status"] as? String ?? ""
                //pickUp location
                let PickUpLatitude = data["PickUpLatitude"] as? Double ?? 0.0
                let PickUpLongitude = data["PickUpLongitude"] as? Double ?? 0.0
                let pickup = CLLocationCoordinate2D(latitude: PickUpLatitude, longitude: PickUpLongitude)
                let pickupBuilding = data["pickUpBulding"] as? Int ?? 0
                let pickupFloor = data["pickUpFloor"] as? Int ?? 0
                let pickupRoom = data["pickUpRoom"] as? String ?? ""
                //DropOff Location
                let DropOffLatitude = data["DropOffLatitude"] as? Double ?? 0.0
                let DropOffLongitude = data["DropOffLongitude"] as? Double ?? 0.0
                let dropoff = CLLocationCoordinate2D(latitude: DropOffLatitude, longitude: DropOffLongitude)
                let dropoffBuilding = data["dropOffBulding"] as? Int ?? 0
                let dropoffFloor = data["dropOffFloor"] as? Int ?? 0
                let dropoffRoom = data["dropOffRoom"] as? String ?? ""
                let orderDetails = data["orderDetails"] as? String ?? ""
                let assigned = (data["Assigned"] as? String ?? "" == "true" ? true : false)
                let MemberID = data["MemberID"] as? String ?? ""
                
                let createdAt = data["CreatedAt"] as? Timestamp ?? Timestamp(date: Date())
                // print("order :\(OrderId) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                // print("get order and date finc is \(createdAt.dateValue().calenderTimeSinceNow())")
                
                return OrderDetails(id: OrderId, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
            })
            
            
        }
    }
    //Delivery request for courier [state = waiting for offer]
    func getOrderWaitingForOffer(){
        print("\n*******getOrderWaitingForOffer*********")
        db.collection("Order").whereField("Status", isEqualTo: status[0]).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No order documents")
                return
            }
            self.WaitingOrders = documents.map({ (queryDocumentSnapshot) -> OrderDetails in
                let data = queryDocumentSnapshot.data()
                let OrderId = queryDocumentSnapshot.documentID
                let state = data["Status"] as? String ?? ""
                //pickUp location
                let PickUpLatitude = data["PickUpLatitude"] as? Double ?? 0.0
                let PickUpLongitude = data["PickUpLongitude"] as? Double ?? 0.0
                let pickup = CLLocationCoordinate2D(latitude: PickUpLatitude, longitude: PickUpLongitude)
                let pickupBuilding = data["pickUpBulding"] as? Int ?? 0
                let pickupFloor = data["pickUpFloor"] as? Int ?? 0
                let pickupRoom = data["pickUpRoom"] as? String ?? ""
                //DropOff Location
                let DropOffLatitude = data["DropOffLatitude"] as? Double ?? 0.0
                let DropOffLongitude = data["DropOffLongitude"] as? Double ?? 0.0
                let dropoff = CLLocationCoordinate2D(latitude: DropOffLatitude, longitude: DropOffLongitude)
                let dropoffBuilding = data["dropOffBulding"] as? Int ?? 0
                let dropoffFloor = data["dropOffFloor"] as? Int ?? 0
                let dropoffRoom = data["dropOffRoom"] as? String ?? ""
                let orderDetails = data["orderDetails"] as? String ?? ""
                let assigned = (data["Assigned"] as? String ?? "" == "true" ? true : false)
                let MemberID = data["MemberID"] as? String ?? ""
                let createdAt = data["CreatedAt"] as? Timestamp ?? Timestamp(date: Date())
                print("order :\(OrderId) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                print("get order and date finc is \(createdAt.dateValue().calenderTimeSinceNow())")
                return OrderDetails(id: OrderId, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
            })
            
            
        }
    }
    //Delivery request for courier [state = have an offer] from offer collection
    func getAllOffersFromCourier(completion: @escaping (_ success: Bool) -> Void) {
        self.orderID.removeAll()
        let id = UserDefaults.standard.getUderId()
        print("inside getAllOffersFromCourier")
        //retrieve all offers from the courier
        db.collection("Offers").whereField("CourierID", isEqualTo: id)//have an offer
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No order documents")
                    return
                }
                self.orderID = documents.map({ (queryDocumentSnapshot) -> String in
                    let data = queryDocumentSnapshot.data()
                    let order_ID = data["OrderID"] as? String ?? ""
                    print(order_ID)
                    return order_ID
                })
                print("End loop inside getAllOffersFromCourier")
                let success = true
                DispatchQueue.main.async {
                    print("inside getAllOffersFromCourier in dispatch")
                    completion(success)
                }
            }
    }
    //Delivery request for courier [state = have an offer] from order collection
    func getOrder() {
        print("inside getOrder") //status[2] = have an offer
        db.collection("Order").whereField("Status", isEqualTo: status[2]).order(by: "CreatedAt", descending: false).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No order documents")
                return
            }
            self.orders = documents.map({ (queryDocumentSnapshot) -> OrderDetails in
                let data = queryDocumentSnapshot.data()
                let OrderId = queryDocumentSnapshot.documentID
                let state = data["Status"] as? String ?? ""
                //pickUp location
                let PickUpLatitude = data["PickUpLatitude"] as? Double ?? 0.0
                let PickUpLongitude = data["PickUpLongitude"] as? Double ?? 0.0
                let pickup = CLLocationCoordinate2D(latitude: PickUpLatitude, longitude: PickUpLongitude)
                let pickupBuilding = data["pickUpBulding"] as? Int ?? 0
                let pickupFloor = data["pickUpFloor"] as? Int ?? 0
                let pickupRoom = data["pickUpRoom"] as? String ?? ""
                //DropOff Location
                let DropOffLatitude = data["DropOffLatitude"] as? Double ?? 0.0
                let DropOffLongitude = data["DropOffLongitude"] as? Double ?? 0.0
                let dropoff = CLLocationCoordinate2D(latitude: DropOffLatitude, longitude: DropOffLongitude)
                let dropoffBuilding = data["dropOffBulding"] as? Int ?? 0
                let dropoffFloor = data["dropOffFloor"] as? Int ?? 0
                let dropoffRoom = data["dropOffRoom"] as? String ?? ""
                let orderDetails = data["orderDetails"] as? String ?? ""
                let assigned = (data["Assigned"] as? String ?? "" == "true" ? true : false)
                let MemberID = data["MemberID"] as? String ?? ""
                let createdAt = data["CreatedAt"] as? Timestamp ?? Timestamp(date: Date())
                
                print("order inside getOrder:\(OrderId) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                return OrderDetails(id: OrderId, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
                
                
            })
            
       
        }
    }
    //add offer for specific order in Delivery request
    func addOffer(OrderId: String,memberID: String,price: Int,locationLatiude :Double,locationLongitude :Double){
        print("\n*******addOffer*********")
        let CourierId = UserDefaults.standard.getUderId()
        //change the state of order to have an offer
        db.collection("Order").document(OrderId).setData([ "Status": "have an offer"], merge: true){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Status changed in add offer")
                //create document inside offer collection
                var doc: DocumentReference? = nil
                doc = db.collection("Offers").addDocument(data:
                                                            ["OrderID": OrderId,"MemberID": memberID,"CourierID" : CourierId ,"Price": price,"CourierLatitude": locationLatiude,"CourierLongitude":locationLongitude]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(doc!.documentID)")
                    }
                }
            }
        }
        
    }
    
    func getCourierOrderCancelledAndCompleted(Id: String) {
        print(" CCCC documents")
        self.CourierOrderCancelled.removeAll()
        db.collection("Order").whereField("CourierID", isEqualTo: Id).order(by: "CreatedAt", descending: false).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No order CCCC documents")
                return
            }
            self.CourierOrderCancelled = documents.map({ (queryDocumentSnapshot) -> OrderDetails in
                
                let data = queryDocumentSnapshot.data()
                let orderId = queryDocumentSnapshot.documentID
                //pickUp location
                let PickUpLatitude = data["PickUpLatitude"] as? Double ?? 0.0
                let PickUpLongitude = data["PickUpLongitude"] as? Double ?? 0.0
                let pickup = CLLocationCoordinate2D(latitude: PickUpLatitude, longitude: PickUpLongitude)
                let pickupBuilding = data["pickUpBulding"] as? Int ?? 0
                let pickupFloor = data["pickUpFloor"] as? Int ?? 0
                let pickupRoom = data["pickUpRoom"] as? String ?? ""
                //DropOff Location
                let DropOffLatitude = data["DropOffLatitude"] as? Double ?? 0.0
                let DropOffLongitude = data["DropOffLongitude"] as? Double ?? 0.0
                let dropoff = CLLocationCoordinate2D(latitude: DropOffLatitude, longitude: DropOffLongitude)
                let dropoffBuilding = data["dropOffBulding"] as? Int ?? 0
                let dropoffFloor = data["dropOffFloor"] as? Int ?? 0
                let dropoffRoom = data["dropOffRoom"] as? String ?? ""
                let orderDetails = data["orderDetails"] as? String ?? ""
                let assigned = (data["Assigned"] as? String ?? "" == "true" ? true : false)
                let MemberID = data["MemberID"] as? String ?? ""
                let state = data["Status"] as? String ?? ""
                let createdAt = data["CreatedAt"] as? Timestamp ?? Timestamp(date: Date())
                let price = data["DeliveryPrice"] as? Int ?? 0
              
             
                print("order :\(orderId) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                print("in get order COURIER OFFER and date finc is \(createdAt.dateValue().calenderTimeSinceNow())")
                
              
                return OrderDetails(id: orderId, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID, courierId:Id ,deliveryPrice:price, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
            })
            
            for i in querySnapshot!.documentChanges {
                print("inside for loop getCourierOrderCancelled")
                if i.type == .modified{
                    let data = i.document
                    let orderId = i.document.documentID
                    //pickUp location
                    let PickUpLatitude = data.get("PickUpLatitude") as? Double ?? 0.0
                    let PickUpLongitude = data.get("PickUpLongitude") as? Double ?? 0.0
                    let pickup = CLLocationCoordinate2D(latitude: PickUpLatitude, longitude: PickUpLongitude)
                    let pickupBuilding = data.get("pickUpBulding") as? Int ?? 0
                    let pickupFloor = data.get("pickUpFloor") as? Int ?? 0
                    let pickupRoom = data.get("pickUpRoom") as? String ?? ""
                    //DropOff Location
                    let DropOffLatitude = data.get("DropOffLatitude") as? Double ?? 0.0
                    let DropOffLongitude = data.get("DropOffLongitude")as? Double ?? 0.0
                    let dropoff = CLLocationCoordinate2D(latitude: DropOffLatitude, longitude: DropOffLongitude)
                    let dropoffBuilding = data.get("dropOffBulding") as? Int ?? 0
                    let dropoffFloor = data.get("dropOffFloor") as? Int ?? 0
                    let dropoffRoom = data.get("dropOffRoom") as? String ?? ""
                    let orderDetails = data.get("orderDetails") as? String ?? ""
                    let assigned = (data.get("Assigned") as? String ?? "" == "true" ? true : false)
                    let MemberID = data.get("MemberID") as? String ?? ""
                    var state = data.get("Status") as? String ?? ""
                    
                    if (state != self.status[1] || state != self.status[7] ) {
                        state = ""
                    }
                    
                    let createdAt = data.get("CreatedAt") as? Timestamp ?? Timestamp(date: Date())
                    let price = data.get("DeliveryPrice") as? Int ?? 0
                  
                 
                    print("order :\(orderId) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                    print("in get order COURIER OFFER and date finc is \(createdAt.dateValue().calenderTimeSinceNow())")

                    let OrderChanges = OrderDetails(id: orderId, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID, courierId:Id ,deliveryPrice:price, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
                   
                    let index = self.CourierOrderCancelled.firstIndex{$0.id == OrderChanges.id}
                    self.CourierOrderCancelled[index ?? 0] = OrderChanges
                    
                    
                }
            }
        }
    }
    
    func getMemberOrderCancelledAndCompleted(Id: String) {
        print(" CCCC documents")
        self.MemberOrderCancelled.removeAll()
        db.collection("Order").whereField("MemberID", isEqualTo: Id).order(by: "CreatedAt", descending: false).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No order CCCC documents")
                return
            }
            self.MemberOrderCancelled = documents.map({ (queryDocumentSnapshot) -> OrderDetails in
                
                let data = queryDocumentSnapshot.data()
                let orderId = queryDocumentSnapshot.documentID
                //pickUp location
                let PickUpLatitude = data["PickUpLatitude"] as? Double ?? 0.0
                let PickUpLongitude = data["PickUpLongitude"] as? Double ?? 0.0
                let pickup = CLLocationCoordinate2D(latitude: PickUpLatitude, longitude: PickUpLongitude)
                let pickupBuilding = data["pickUpBulding"] as? Int ?? 0
                let pickupFloor = data["pickUpFloor"] as? Int ?? 0
                let pickupRoom = data["pickUpRoom"] as? String ?? ""
                //DropOff Location
                let DropOffLatitude = data["DropOffLatitude"] as? Double ?? 0.0
                let DropOffLongitude = data["DropOffLongitude"] as? Double ?? 0.0
                let dropoff = CLLocationCoordinate2D(latitude: DropOffLatitude, longitude: DropOffLongitude)
                let dropoffBuilding = data["dropOffBulding"] as? Int ?? 0
                let dropoffFloor = data["dropOffFloor"] as? Int ?? 0
                let dropoffRoom = data["dropOffRoom"] as? String ?? ""
                let orderDetails = data["orderDetails"] as? String ?? ""
                let assigned = (data["Assigned"] as? String ?? "" == "true" ? true : false)
                let MemberID = data["MemberID"] as? String ?? ""
                let state = data["Status"] as? String ?? ""
                let createdAt = data["CreatedAt"] as? Timestamp ?? Timestamp(date: Date())
                let price = data["DeliveryPrice"] as? Int ?? 0
              
             
                print("order :\(orderId) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                print("in get order COURIER OFFER and date finc is \(createdAt.dateValue().calenderTimeSinceNow())")
                
              
                return OrderDetails(id: orderId, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID, courierId:Id ,deliveryPrice:price, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
            })
            
            for i in querySnapshot!.documentChanges {
                print("inside for loop getMemberOrderCancelled")
                if i.type == .modified{
                    let data = i.document
                    let orderId = i.document.documentID
                    //pickUp location
                    let PickUpLatitude = data.get("PickUpLatitude") as? Double ?? 0.0
                    let PickUpLongitude = data.get("PickUpLongitude") as? Double ?? 0.0
                    let pickup = CLLocationCoordinate2D(latitude: PickUpLatitude, longitude: PickUpLongitude)
                    let pickupBuilding = data.get("pickUpBulding") as? Int ?? 0
                    let pickupFloor = data.get("pickUpFloor") as? Int ?? 0
                    let pickupRoom = data.get("pickUpRoom") as? String ?? ""
                    //DropOff Location
                    let DropOffLatitude = data.get("DropOffLatitude") as? Double ?? 0.0
                    let DropOffLongitude = data.get("DropOffLongitude")as? Double ?? 0.0
                    let dropoff = CLLocationCoordinate2D(latitude: DropOffLatitude, longitude: DropOffLongitude)
                    let dropoffBuilding = data.get("dropOffBulding") as? Int ?? 0
                    let dropoffFloor = data.get("dropOffFloor") as? Int ?? 0
                    let dropoffRoom = data.get("dropOffRoom") as? String ?? ""
                    let orderDetails = data.get("orderDetails") as? String ?? ""
                    let assigned = (data.get("Assigned") as? String ?? "" == "true" ? true : false)
                    let MemberID = data.get("MemberID") as? String ?? ""
                    var state = data.get("Status") as? String ?? ""
                    
                    if (state != self.status[1] || state != self.status[7] ) {
                        state = ""
                    }
                    
                    let createdAt = data.get("CreatedAt") as? Timestamp ?? Timestamp(date: Date())
                    let price = data.get("DeliveryPrice") as? Int ?? 0
                  
                 
                    print("order :\(orderId) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                    print("in get order COURIER OFFER and date finc is \(createdAt.dateValue().calenderTimeSinceNow())")

                    let OrderChanges = OrderDetails(id: orderId, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID, courierId:Id ,deliveryPrice:price, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
                   
                    let index = self.MemberOrderCancelled.firstIndex{$0.id == OrderChanges.id}
                    self.MemberOrderCancelled[index ?? 0] = OrderChanges
                    
                    
                }
            }
        }
    }

    //current order for courier [state = assign]
    func getCourierOrderAssign(Id: String){
        print(" CCCC documents")
        self.CourierOrderOfferedAssign.removeAll()
        db.collection("Order").whereField("CourierID", isEqualTo: Id).order(by: "CreatedAt", descending: false).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No order CCCC documents")
                return
            }
            self.CourierOrderOfferedAssign = documents.map({ (queryDocumentSnapshot) -> OrderDetails in
                
                let data = queryDocumentSnapshot.data()
                let orderId = queryDocumentSnapshot.documentID
                //pickUp location
                let PickUpLatitude = data["PickUpLatitude"] as? Double ?? 0.0
                let PickUpLongitude = data["PickUpLongitude"] as? Double ?? 0.0
                let pickup = CLLocationCoordinate2D(latitude: PickUpLatitude, longitude: PickUpLongitude)
                let pickupBuilding = data["pickUpBulding"] as? Int ?? 0
                let pickupFloor = data["pickUpFloor"] as? Int ?? 0
                let pickupRoom = data["pickUpRoom"] as? String ?? ""
                //DropOff Location
                let DropOffLatitude = data["DropOffLatitude"] as? Double ?? 0.0
                let DropOffLongitude = data["DropOffLongitude"] as? Double ?? 0.0
                let dropoff = CLLocationCoordinate2D(latitude: DropOffLatitude, longitude: DropOffLongitude)
                let dropoffBuilding = data["dropOffBulding"] as? Int ?? 0
                let dropoffFloor = data["dropOffFloor"] as? Int ?? 0
                let dropoffRoom = data["dropOffRoom"] as? String ?? ""
                let orderDetails = data["orderDetails"] as? String ?? ""
                let assigned = (data["Assigned"] as? String ?? "" == "true" ? true : false)
                let MemberID = data["MemberID"] as? String ?? ""
                let state = data["Status"] as? String ?? ""
                let createdAt = data["CreatedAt"] as? Timestamp ?? Timestamp(date: Date())
                let price = data["DeliveryPrice"] as? Int ?? 0
              
             
                print("order :\(orderId) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                print("in get order COURIER OFFER and date finc is \(createdAt.dateValue().calenderTimeSinceNow())")
                
              
                return OrderDetails(id: orderId, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID, courierId:Id ,deliveryPrice:price, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
            })
            
            for i in querySnapshot!.documentChanges {
                print("inside for loop getCourierOrderAssign")
                if i.type == .modified{
                    let data = i.document
                    let orderId = i.document.documentID
                    //pickUp location
                    let PickUpLatitude = data.get("PickUpLatitude") as? Double ?? 0.0
                    let PickUpLongitude = data.get("PickUpLongitude") as? Double ?? 0.0
                    let pickup = CLLocationCoordinate2D(latitude: PickUpLatitude, longitude: PickUpLongitude)
                    let pickupBuilding = data.get("pickUpBulding") as? Int ?? 0
                    let pickupFloor = data.get("pickUpFloor") as? Int ?? 0
                    let pickupRoom = data.get("pickUpRoom") as? String ?? ""
                    //DropOff Location
                    let DropOffLatitude = data.get("DropOffLatitude") as? Double ?? 0.0
                    let DropOffLongitude = data.get("DropOffLongitude")as? Double ?? 0.0
                    let dropoff = CLLocationCoordinate2D(latitude: DropOffLatitude, longitude: DropOffLongitude)
                    let dropoffBuilding = data.get("dropOffBulding") as? Int ?? 0
                    let dropoffFloor = data.get("dropOffFloor") as? Int ?? 0
                    let dropoffRoom = data.get("dropOffRoom") as? String ?? ""
                    let orderDetails = data.get("orderDetails") as? String ?? ""
                    let assigned = (data.get("Assigned") as? String ?? "" == "true" ? true : false)
                    let MemberID = data.get("MemberID") as? String ?? ""
                    let state = data.get("Status") as? String ?? ""
                    let createdAt = data.get("CreatedAt") as? Timestamp ?? Timestamp(date: Date())
                    let price = data.get("DeliveryPrice") as? Int ?? 0
                  
                 
                    print("order :\(orderId) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                    print("in get order COURIER OFFER and date finc is \(createdAt.dateValue().calenderTimeSinceNow())")

                    let OrderChanges = OrderDetails(id: orderId, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID, courierId:Id ,deliveryPrice:price, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
                   
                    let index = self.CourierOrderOfferedAssign.firstIndex{$0.id == OrderChanges.id}
                    self.CourierOrderOfferedAssign[index ?? 0] = OrderChanges
                    
                    
                }
            }
        }
    }
    //retrieve all offers with specific courier id
    func getAllOffersFromCourierInCurrentOrder(completion: @escaping (_ success: Bool) -> Void) {
        self.collectAllOffersForCourier.removeAll()
        let id = UserDefaults.standard.getUderId()
        print("inside getAllOffersFromCourier")
        //retrieve all offers from the courier
        db.collection("Offers").whereField("CourierID", isEqualTo: id)//have an offer
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No order CCCC documents")
                    return
                }
                self.collectAllOffersForCourier = documents.map({ (queryDocumentSnapshot) -> Offer in
                    let data = queryDocumentSnapshot.data()
                    let offerId = queryDocumentSnapshot.documentID
                    let orderId = data["OrderID"] as? String ?? ""
                    let memberID = data["MemberID"] as? String ?? ""
                    let courierID = data["CourierID"] as? String ?? ""
                    let courierLatitude = data["CourierLatitude"] as? Double ?? 0.0
                    let courierLongitude = data["CourierLongitude"] as? Double ?? 0.0
                    let Price = data["Price"] as? Int ?? 0
                    let courierLocation = CLLocationCoordinate2D(latitude: courierLatitude, longitude: courierLongitude)
                    print("order :\(offerId) + \(memberID) ")
                    let offer = Offer( id: offerId, OrderId: orderId , memberId: memberID ,courierId: courierID, courier: Courier(id: courierID), price: Price, courierLocation: courierLocation)
                    return offer
                })
                print("End loop inside getAllOffersFromCourierInCurrentOrder")
                print("inside getAllOffersFromCourierInCurrentOrder before getOrderForCourierCurrentOrder")
                //add these orders
                self.getOrderForCourierCurrentOrder(){ success in
                    print("inside getOrderForCourierCurrentOrder success")
                    guard success else { return }
                    let success = true
                    DispatchQueue.main.async {
                        print("inside getOrderForCourierCurrentOrder in dispatch")
                        completion(success)
                    }
                }
            }
    }
    //get all order that has the same order ID with array collectAllOffersForCourier
    func getOrderForCourierCurrentOrder(completion: @escaping (_ success: Bool) -> Void) {
        db.collection("Order").whereField("Status", isEqualTo: status[2])
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No order CCCC documents")
                    return
                }
                self.CourierOrderOfferedWaiting = documents.map({ (queryDocumentSnapshot) -> OrderDetails in
                    let data = queryDocumentSnapshot.data()
                    let orderId = queryDocumentSnapshot.documentID
                    
                    print("before filter if statement collectAllOffersForCourier")
                    if self.collectAllOffersForCourier.filter({$0.OrderId == orderId}).count > 0{
                        print("inside if filter collectAllOffersForCourier")
                        let state = data["Status"] as? String ?? ""
                        //pickUp location
                        let PickUpLatitude = data["PickUpLatitude"] as? Double ?? 0.0
                        let PickUpLongitude = data["PickUpLongitude"] as? Double ?? 0.0
                        let pickup = CLLocationCoordinate2D(latitude: PickUpLatitude, longitude: PickUpLongitude)
                        let pickupBuilding = data["pickUpBulding"] as? Int ?? 0
                        let pickupFloor = data["pickUpFloor"] as? Int ?? 0
                        let pickupRoom = data["pickUpRoom"] as? String ?? ""
                        //DropOff Location
                        let DropOffLatitude = data["DropOffLatitude"] as? Double ?? 0.0
                        let DropOffLongitude = data["DropOffLongitude"] as? Double ?? 0.0
                        let dropoff = CLLocationCoordinate2D(latitude: DropOffLatitude, longitude: DropOffLongitude)
                        let dropoffBuilding = data["dropOffBulding"] as? Int ?? 0
                        let dropoffFloor = data["dropOffFloor"] as? Int ?? 0
                        let dropoffRoom = data["dropOffRoom"] as? String ?? ""
                        let orderDetails = data["orderDetails"] as? String ?? ""
                        let assigned = (data["Assigned"] as? String ?? "" == "true" ? true : false)
                        let MemberID = data["MemberID"] as? String ?? ""
                        let createdAt = data["CreatedAt"] as? Timestamp ?? Timestamp(date: Date())
                        
                        let offerDetails = self.collectAllOffersForCourier.filter({$0.OrderId == orderId})
                        
                        let price = offerDetails[0].price
                        let courierId = UserDefaults.standard.getUderId()
                        print("inside getOrderForCourierCurrentOrder offerDetails  \(orderDetails) \(price)")
                        let newOrder =  OrderDetails(id: orderId, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID,courierId: courierId ,deliveryPrice: price, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
                        return newOrder
                    }
                    
                    let newOrder =  OrderDetails(id: "", pickUP: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), pickUpBulding: 0, pickUpFloor: 0, pickUpRoom: "", dropOff: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), dropOffBulding: 0, dropOffFloor: 0, dropOffRoom: "", orderDetails: "", memberId: "" ,courierId: "" ,deliveryPrice: 0, isAdded: false, createdAt: Date(), status: "")
                    return newOrder
                })
                for i in querySnapshot!.documentChanges {
                    print("inside for loop getStatus")
                    if i.type == .modified{
                        let data = i.document
                        let orderId = i.document.documentID
                        
                        let state = data.get("Status") as? String ?? ""
                        //pickUp location
                        let PickUpLatitude = data.get("PickUpLatitude") as? Double ?? 0.0
                        let PickUpLongitude = data.get("PickUpLongitude") as? Double ?? 0.0
                        let pickup = CLLocationCoordinate2D(latitude: PickUpLatitude, longitude: PickUpLongitude)
                        let pickupBuilding = data.get("pickUpBulding") as? Int ?? 0
                        let pickupFloor = data.get("pickUpFloor") as? Int ?? 0
                        let pickupRoom = data.get("pickUpRoom")as? String ?? ""
                        //DropOff Location
                        let DropOffLatitude = data.get("DropOffLatitude") as? Double ?? 0.0
                        let DropOffLongitude = data.get("DropOffLongitude") as? Double ?? 0.0
                        let dropoff = CLLocationCoordinate2D(latitude: DropOffLatitude, longitude: DropOffLongitude)
                        let dropoffBuilding = data.get("dropOffBulding") as? Int ?? 0
                        let dropoffFloor = data.get("dropOffFloor") as? Int ?? 0
                        let dropoffRoom = data.get("dropOffRoom") as? String ?? ""
                        let orderDetails = data.get("orderDetails") as? String ?? ""
                        let assigned = (data.get("Assigned") as? String ?? "" == "true" ? true : false)
                        let MemberID = data.get("MemberID") as? String ?? ""
                        let createdAt = data.get("CreatedAt") as? Timestamp ?? Timestamp(date: Date())
                        
                        let offerDetails = self.collectAllOffersForCourier.filter({$0.OrderId == orderId})
                        
                        let price = offerDetails[0].price
                        let courierId = UserDefaults.standard.getUderId()
                      
                     
                        print("order :\(orderId) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                        print("in get order COURIER OFFER and date finc is \(createdAt.dateValue().calenderTimeSinceNow())")

                        let OrderChanges = OrderDetails(id: orderId, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID,courierId: courierId ,deliveryPrice: price, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
                        
                  
                        let index = self.CourierOrderOfferedWaiting.firstIndex{$0.id == OrderChanges.id}
                        self.CourierOrderOfferedWaiting[index ?? 0] = OrderChanges
                        
                        
                    }
                }
                let success = true
                DispatchQueue.main.async {
                    print("inside getOrderForCourierCurrentOrder in dispatch")
                    completion(success)
                }
            }
    }
    //get all offers made to a specific order
    func getOffers(OrderId: String, completion: @escaping (_ success: Bool) -> Void){
        print("\n*******GetOffersMember*********")
        db.collection("Offers").whereField("OrderID", isEqualTo: OrderId).order(by: "Price", descending: false).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No offer documents")
                
                return
            }
            if(documents.isEmpty){
                print("no offer documents")
            }
            /*self.offers = documents.map({ (queryDocumentSnapshot) -> Offer in
                print(queryDocumentSnapshot.data())
                let data = queryDocumentSnapshot.data()
                let offerId = queryDocumentSnapshot.documentID
                let orderId = data["OrderID"] as? String ?? ""
                let memberID = data["MemberID"] as? String ?? ""
                let courierID = data["CourierID"] as? String ?? ""
                let courierLatitude = data["CourierLatitude"] as? Double ?? 0.0
                let courierLongitude = data["CourierLongitude"] as? Double ?? 0.0
                let Price = data["Price"] as? Int ?? 0
                let courierLocation = CLLocationCoordinate2D(latitude: courierLatitude, longitude: courierLongitude)
                print("order :\(offerId) + \(memberID) ")
                return Offer( id: offerId, OrderId: orderId , memberId: memberID ,courierId: courierID, courier: Courier(id: courierID), price: Price, courierLocation: courierLocation)
            })*/
            self.offers.removeAll()
            for i in querySnapshot!.documentChanges {
               
                print("inside for loop getStatus")
                if i.type == .added{
                    let data = i.document
                    let offerId = i.document.documentID
                    let orderId = data.get("OrderID") as? String ?? ""
                    let memberID = data.get("MemberID") as? String ?? ""
                    let courierID = data.get("CourierID") as? String ?? ""
                    let courierLatitude = data.get("CourierLatitude") as? Double ?? 0.0
                    let courierLongitude = data.get("CourierLongitude") as? Double ?? 0.0
                    let Price = data.get("Price") as? Int ?? 0
                    let courierLocation = CLLocationCoordinate2D(latitude: courierLatitude, longitude: courierLongitude)
                    print("order :\(offerId) + \(memberID) ")
                  
                    let OfferChanges = Offer( id: offerId, OrderId: orderId , memberId: memberID ,courierId: courierID, courier: Courier(id: courierID), price: Price, courierLocation: courierLocation)
                    
                    self.offers.append(OfferChanges)
                }
            }
            let success = true
            DispatchQueue.main.async {
                print("inside getOffers in dispatch")
                completion(success)
            }
        }
    }
    //cancels an offer and changes the order status to waiting for offers if needed
    func cancelOffer(CourierID: String, OrderId: String, MemberID: String, Price: Int) {
        
        print("\n*******cancelOffer*********")
        
        getOffers(OrderId: OrderId){ success in
            print("inside getOrderForCourierCurrentOrder success")
            guard success else { return }
            if self.offers.count == 1{
                print("change the state of order to waiting for offer")
                db.collection("Order").document(OrderId).setData([ "Status": self.status[0] ], merge: true)
            }
            
        }
        
        
        
        print("delete offer from database")
        
        
        
        db.collection("Offers").whereField("OrderID", isEqualTo: OrderId).whereField("CourierID", isEqualTo: CourierID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    db.collection("Offers").document(document.documentID).delete(){ err in
                        if let err = err {
                        print("Error removing offer inside cancelOffer: \(err)")
                        } else {
                        print("offer successfully delete inside cancelOffer!")
                            
                        }
                    
                }
                
            }}
        
    }
    }
    //change state of order
    func changeState(OrderId: String, Status: String , completion: @escaping (_ success: Bool) -> Void){ //index of status array
        db.collection("Order").document(OrderId).setData([ "Status": Status ], merge: true)
        let success = true
        DispatchQueue.main.async {
            print("inside getStatus in dispatch changeState")
            completion(success)
        }
    }
    
    //get status for order //
    func getStatus(courierId: String, memberId: String, order: String, completion: @escaping (_ success: Bool) -> Void) {
        
        
        db.collection("Order").whereField("MemberID", isEqualTo: memberId).whereField("CourierID", isEqualTo: courierId).whereField("orderDetails", isEqualTo: order).addSnapshotListener { (querySnapshot, error) in
            if error != nil {
                print("error getting status")
                return
            }
            var h = 0
            print("\n\nstatus doc count \(querySnapshot!.documents.count)") //should be 1
            for doc in querySnapshot!.documents{
                let data = doc.data()
                self.liveStatus = data["Status"] as? String ?? ""
                print("\n\nLive status \(self.liveStatus) \(h)")
                h = h+1
            }
            var j = 0
            for i in querySnapshot!.documentChanges {
                print("inside for loop getStatus")
                if i.type == .modified{
                    self.liveStatus = i.document.get("Status") as? String ?? ""
                    print("\n\nLive status \(self.liveStatus) \(j)")
                    j = j+1
                }
            }
            
            let success = true
            DispatchQueue.main.async {
                print("inside getStatus in dispatch")
                completion(success)
            }
            
        }
        
    }
    
    //get status for order //
    func getStatusNotAssigned(memberId: String, order: String, completion: @escaping (_ success: Bool) -> Void) {
        
        
        db.collection("Order").whereField("MemberID", isEqualTo: memberId).whereField("orderDetails", isEqualTo: order).addSnapshotListener { (querySnapshot, error) in
            if error != nil {
                print("error getting status")
                return
            }
            var h = 0
            print("\n\nstatus doc count \(querySnapshot!.documents.count)") //should be 1
            for doc in querySnapshot!.documents{
                let data = doc.data()
                self.liveStatus = data["Status"] as? String ?? ""
                print("\n\nLive status \(self.liveStatus) \(h)")
                h = h+1
            }
            var j = 0
            for i in querySnapshot!.documentChanges {
                print("inside for loop getStatus")
                if i.type == .modified{
                    self.liveStatus = i.document.get("Status") as? String ?? ""
                    print("\n\nLive status \(self.liveStatus) \(j)")
                    j = j+1
                }
            }
            
            let success = true
            DispatchQueue.main.async {
                print("inside getStatus in dispatch")
                completion(success)
            }
            
        }
        
    }
    
    
    
    
    
    //send chat
    func sendChatRoom(orderId : String, sender_msg: String){
        let sender_id = UserDefaults.standard.getUderId()
    db.collection("Order").document(orderId).collection("Chat").addDocument(data: ["timeSent":FieldValue.serverTimestamp(),"senderId":sender_id,"orderId": orderId,"msg":sender_msg])
    { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    //retrieve chat
    func getChatRoom(orderId : String, completion: @escaping (_ success: Bool) -> Void){
        self.chat.removeAll()
        db.collection("Order").document(orderId).collection("Chat").order(by: "timeSent", descending: true).addSnapshotListener { (querySnapshot, error) in
            if error != nil {
                print("error getting msg")
                return
            }
            for i in querySnapshot!.documentChanges {
                if i.type == .added {
                    let id = i.document.documentID
                    let orderID = i.document.get("orderId") as? String ?? ""
                    let senderID = i.document.get("senderId")as? String ?? ""
                    let timeSent = i.document.get("timeSent") as? Timestamp ?? Timestamp(date: Date())
                    let msg = i.document.get("msg") as? String ?? ""
                    
                    if self.chat.filter({$0.id == id}).count == 0{
                        self.chat.append(ChatMsg(id: id, orderId: orderID, senderID: senderID, timeSent: timeSent.dateValue(), msg: msg))
                        print("\(msg) inside filter")
                    }else{
                        print("\(msg) outside filter")
                    }
                    
                }
            }
            let success = true
            DispatchQueue.main.async {
                print("inside getChatRoom in dispatch")
                completion(success)
            }
            
        }
    }
     
    //****************************
    //For Member user
    //****************************
    
    //Add new Order
    func setpickUPAndpickUpDetails(pickUP: CLLocationCoordinate2D ,pickUpBulding: Int, pickUpFloor: Int, pickUpRoom: String)-> Bool{
        self.pickUP = pickUP
        self.pickUpBulding = pickUpBulding
        self.pickUpFloor = pickUpFloor
        self.pickUpRoom = pickUpRoom
        var flag = false
        if (pickUP.latitude != 0.0 && pickUP.longitude != 0.0 && pickUpBulding != 0 &&  pickUpFloor != -1 &&  pickUpRoom != "")
        {
            flag = true
            self.setPick = true
        }
        else {
            
            flag = false
        }
        
        return flag
    }
    
    //Add new Order
    func setDropOffAndDropOffDetails(dropOff: CLLocationCoordinate2D, dropOffBulding: Int, dropOffFloor: Int, dropOffRoom: String   )-> Bool{
        self.dropOff = dropOff
        self.dropOffBulding = dropOffBulding
        self.dropOffFloor = dropOffFloor
        self.dropOffRoom = dropOffRoom
        var flag = false
        if (dropOff.latitude != 0.0 && dropOff.longitude != 0.0 && dropOffBulding != 0 &&  dropOffFloor != -1 &&  dropOffRoom != "")
        {
            flag = true
            self.setDrop = true
        }
        else {
            
            flag = false
        }
        return flag
    }
    
    //Add new Order
    func setOrderDetails(orderDetails: String)-> Bool{
        self.orderDetails=orderDetails
        var flag = false
        if orderDetails != ""
        {
            flag = true
            self.setDetails = true
        }else
        
        {
            flag = false
            
        }
        
        return flag
    }
    
    //Add new Order
    func addOrder() -> Bool {
        var flag = true
        let id = UserDefaults.standard.getUderId()
        let doc = db.collection("Order").document()
        if (self.setPick && self.setDrop && self.setDetails){
            doc.setData(["MemberID": id,"PickUpLatitude":self.pickUP.latitude,"PickUpLongitude":self.pickUP.longitude, "pickUpBulding":self.pickUpBulding, "pickUpFloor": self.pickUpFloor, "pickUpRoom": self.pickUpRoom, "DropOffLatitude":self.dropOff.latitude,"DropOffLongitude":self.dropOff.longitude, "dropOffBulding": self.dropOffBulding, "dropOffFloor": self.dropOffFloor, "dropOffRoom": self.dropOffRoom,"orderDetails": self.orderDetails, "Assigned": "false", "CreatedAt": FieldValue.serverTimestamp(), "Status": self.status[0]]) { (error) in
                
                if error != nil {
                    flag = false
                }
            }
        }
        return flag
    }
    
    //get all member orders where member id equals the id sent
    func getMemberOrder(Id: String){
        print("\n*******GetMemberOrder*********")
        db.collection("Order").whereField("MemberID", isEqualTo: Id).order(by: "CreatedAt", descending: false).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No order documents")
                return
            }
            self.memberOrder = documents.map({ (queryDocumentSnapshot) -> OrderDetails in
                print(queryDocumentSnapshot.data())
                let data = queryDocumentSnapshot.data()
                let uid = queryDocumentSnapshot.documentID
                //pickUp location
                let PickUpLatitude = data["PickUpLatitude"] as? Double ?? 0.0
                let PickUpLongitude = data["PickUpLongitude"] as? Double ?? 0.0
                let pickup = CLLocationCoordinate2D(latitude: PickUpLatitude, longitude: PickUpLongitude)
                let pickupBuilding = data["pickUpBulding"] as? Int ?? 0
                let pickupFloor = data["pickUpFloor"] as? Int ?? 0
                let pickupRoom = data["pickUpRoom"] as? String ?? ""
                //DropOff Location
                let DropOffLatitude = data["DropOffLatitude"] as? Double ?? 0.0
                let DropOffLongitude = data["DropOffLongitude"] as? Double ?? 0.0
                let dropoff = CLLocationCoordinate2D(latitude: DropOffLatitude, longitude: DropOffLongitude)
                let dropoffBuilding = data["dropOffBulding"] as? Int ?? 0
                let dropoffFloor = data["dropOffFloor"] as? Int ?? 0
                let dropoffRoom = data["dropOffRoom"] as? String ?? ""
                let orderDetails = data["orderDetails"] as? String ?? ""
                //when converting to Bool we need to do this
                let assigned = (data["Assigned"] as? String ?? "" == "true" ? true : false)
                let MemberID = data["MemberID"] as? String ?? ""
                let state = data["Status"] as? String ?? ""
                let createdAt = data["CreatedAt"] as? Timestamp ?? Timestamp(date: Date())
                var deliveryPrice = 0
                var courierId = ""
                
                if assigned{ // if the order is assigned and both value are created in db
                    deliveryPrice = data["DeliveryPrice"] as? Int ?? 0
                    courierId = data["CourierID"] as? String ?? ""
                    print("\n\n !!!!!!!!!!!!!!!!!!!!!! pric \(deliveryPrice) \n\n")
                }
                
                
                print("order :\(uid) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                print("in get order member current and date finc is \(createdAt.dateValue().calenderTimeSinceNow())")
                db.collection("Tracking").document(uid)
                let courierLocationLatitude = data["courierLatitude"] as? Double ?? 0.0
                let courierLocationLongitude = data["courierLongitude"] as? Double ?? 0.0
                let courierLocation = CLLocationCoordinate2D(latitude: courierLocationLatitude, longitude: courierLocationLongitude)
              
                return OrderDetails(id: uid, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID,courierId: courierId, deliveryPrice: deliveryPrice , courierLocation: courierLocation, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
            })
            
            
        }
    }

    //cancels an order based on order id and deletes all offers if any
    func cancelOrder(OrderId: String){
        print("\n*******CancelOrder*********")
        db.collection("Order").document(OrderId).setData([ "Status": status[1] ], merge: true)
        
        db.collection("Offers").whereField("OrderID", isEqualTo: OrderId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents inside cancle order: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("inside cancelOrder: offerId:\(document.documentID) =>Data \(document.data())")
                    db.collection("Offers").document(document.documentID).delete() { err in
                        if let err = err {
                            print("Error removing offer inside cancelOrder: \(err)")
                        } else {
                            print("offer successfully delete inside cancelOrder!")
                        }
                    }//delete offer
                }//loop
            }
            
            
        }//get documents
        
    }

    //function accept offer adds courier id and delivery price to order and deletes offer subcollection
    //add document to Tracking collection
    func acceptOffer(orderID: String, courierID: String, deliveryPrice: Double, courierLocation: CLLocationCoordinate2D){
        db.collection("Order").document(orderID).setData([ "Status": status[3], "Assigned": "true", "CourierID": courierID, "DeliveryPrice": deliveryPrice, "courierLatitude": courierLocation.latitude, "courierLongitude": courierLocation.longitude], merge: true)
        
        db.collection("Tracking").document(courierID).setData(["CourierID": courierID,"courierLatitude":courierLocation.latitude,"courierLongitude":courierLocation.longitude], merge: true)
        
        db.collection("Offers").whereField("OrderID", isEqualTo: orderID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents inside acceptOffer : \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("inside cancelOrder: offerId:\(document.documentID) =>Data \(document.data())")
                    db.collection("Offers").document(document.documentID).delete() { err in
                        if let err = err {
                            print("Error removing offer inside acceptOffer: \(err)")
                        } else {
                            print("offer successfully delete inside acceptOffer!")
                        }
                    }//delete offer
                }//loop
            }
        }//get documents
        
    }
    
    func getMemberName(memberId : String, completion: @escaping (_ success: Bool) -> Void){

            db.collection("Member").document(memberId)
                    .addSnapshotListener { documentSnapshot, error in
                        guard let document = documentSnapshot else {
                            print("Error fetching document: \(error!)")
                            return
                        }
                        let source = document.metadata.hasPendingWrites ? "Local" : "Server"
                        print("\(source) data: \(document.data() ?? [:])")
                        let data = document.data()
                        self.nameSender = data?["Name"] as? String ?? ""
                        
                    
            let success = true
                DispatchQueue.main.async {
                    print("inside getChatRoom in dispatch")
                    completion(success)
                }
                
            }
        }
        func getCourierName(courierId : String, completion: @escaping (_ success: Bool) -> Void){
            db.collection("Courier").document(courierId)
                    .addSnapshotListener { documentSnapshot, error in
                        guard let document = documentSnapshot else {
                            print("Error fetching document: \(error!)")
                            return
                        }
                        let source = document.metadata.hasPendingWrites ? "Local" : "Server"
                        print("\(source) data: \(document.data() ?? [:])")
                        let data = document.data()
                        self.nameSender = data?["Name"] as? String ?? ""
                        
                    
            let success = true
                DispatchQueue.main.async {
                    print("inside getChatRoom in dispatch")
                    completion(success)
                }
                
            }
        }


    
    

}

//get the updated courier location
//updated courier location
    func updateCourierLocation(CourierID : String, courierLocation: CLLocationCoordinate2D ) {
        print("inside updateCourierLocation in dispatch")
            print(courierLocation.latitude)
            print(courierLocation.longitude)
        db.collection("Tracking").whereField("CourierID", isEqualTo: CourierID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    db.collection("Tracking").document(document.documentID).setData(["CourierID": CourierID, "courierLatitude":courierLocation.latitude,"courierLongitude":courierLocation.longitude],merge: true)
                    { err in
                        if let err = err {
                        print("Error updating courier location updateCourierLocation: \(err)")
                        } else {
                        print("courier location successfully updated inside updateCourierLocation!")
                            
                        }
                    
                }
                
            }}
        
    }
        
        
        
   
    }



    func getCourierLocation(CourierID : String){

        db.collection("Tracking").whereField("CourierID", isEqualTo: CourierID).addSnapshotListener { (querySnapshot, error) in
            if error != nil {
                print("error getting courier location")
                return
            }
            for i in querySnapshot!.documentChanges {
                if i.type == .added || i.type == .modified {
                    let courierlat = i.document.get("courierLatitude") as? Double ?? 0.0
                    let courierlong = i.document.get("courierLongitude")as? Double ?? 0.0
                    //print("traking :\(orderID) + \(courierlat) + \(courierlong) ")
                    riyadhCoordinatetracking = CLLocationCoordinate2D(latitude: courierlat, longitude: courierlong)

                
                }
            }
        }
    }


//add notification to DB
//call this function when you want to send a notification to member
func addNotificationMember (memberId: String, title: String, content: String, completion: @escaping (_ success: Bool) -> Void){
    db.collection("Member").document(memberId).collection("Notification").addDocument(data: ["Title": title, "Content": content])
    { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("\n\nNOTIFICATIOM successfully written!\n\n")
            }
        let success = true
        DispatchQueue.main.async {
            print("inside NOTIFICATION M in dispatch")
            completion(success)
        }
        }
    
}

//call this function when you want to send a notification to courier
func addNotificationCourier (courierId: String, title: String, content: String, completion: @escaping (_ success: Bool) -> Void){

    db.collection("Courier").document(courierId).collection("Notification").addDocument(data: ["Title": title, "Content": content])
    { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("\n\nNOTIFICATION C successfully written!\n\n")
            }
        let success = true
        DispatchQueue.main.async {
            print("inside NOTIFICATION C in dispatch")
            completion(success)
        }
        }

}


//get notification from DB
//call this function when you want to show a notification to member
func getNotificationMember(memberId: String, completion: @escaping (_ success: Bool) -> Void) {
    db.collection("Member").document(memberId).collection("Notification").addSnapshotListener { (querySnapshot, error) in
        if error != nil {
            print("error getting msg")
            return
        }
        for i in querySnapshot!.documentChanges {
            if i.type == .added {
                let title = i.document.get("Title") as? String ?? ""
                let nContent = i.document.get("Content")as? String ?? ""
                print("\(nContent) notification M")
                
                let center = UNUserNotificationCenter.current()

                    let addRequest = {
                        let content = UNMutableNotificationContent()
                        content.title = title
                        content.subtitle = nContent
                        content.sound = UNNotificationSound.default

                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        print("\n\nin addRequest M\n\n")
                        center.add(request)
                    }
                center.getNotificationSettings { settings in
                    if settings.authorizationStatus == .authorized {
                        addRequest()
                        print("\n\nNotification success C\n\n")
                    } else {
                        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                addRequest()
                                print("\n\nNotification success C\n\n")
                            } else {
                                print("ERROR NOT Authorize notificatio M")
                            }
                        }
                    }
                }
                
            }
            let success = true
            DispatchQueue.main.async {
                print("inside NOTIFICATION in dispatch")
                db.collection("Member").document(memberId).collection("Notification").document(i.document.documentID).delete { err in
                    if err != nil {
                        print("ERROR deleting Notification MEMBER!!!!!!!!!!\n\n")
                    }
                }
                completion(success)
            }
        }
        
        
    }
}

//call this function when you want to show a notification to courier
func getNotificationCourier(courierId: String, completion: @escaping (_ success: Bool) -> Void) {
    db.collection("Courier").document(courierId).collection("Notification").addSnapshotListener { (querySnapshot, error) in
        if error != nil {
            print("error getting msg")
            return
        }

        for i in querySnapshot!.documentChanges {
            if i.type == .added {
                
                let title = i.document.get("Title") as? String ?? ""
                let nContent = i.document.get("Content")as? String ?? ""
                print("\(nContent) notification C")
                let center = UNUserNotificationCenter.current()

                    let addRequest = {
                        let content = UNMutableNotificationContent()
                        content.title = title
                        content.body = nContent
                        content.sound = UNNotificationSound.default

                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        print("\n\nin addRequest C\n\n")
                        center.add(request)
                    }
                center.getNotificationSettings { settings in
                    if settings.authorizationStatus == .authorized {
                        addRequest()
                        print("\n\nNotification success C\n\n")
                    } else {
                        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                addRequest()
                                print("\n\nNotification success C\n\n")
                            } else {
                                print("ERROR NOT Authorize notificatio C")
                            }
                        }
                    }
                }
              
                
            }
            
            let success = true
            DispatchQueue.main.async {
                print("inside NOTIFICATION in dispatch")
                db.collection("Courier").document(courierId).collection("Notification").document(i.document.documentID).delete { err in
                    if err != nil {
                        print("ERROR deleting Notification COURIER!!!!!!!!!!\n\n")
                    }
                }
                completion(success)
            }
        }
        
        
        
    }
}



//for in-app notification
class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .sound])
    }
}





















//Date extension to calculate time intervals
extension Date {
    
    func calenderTimeSinceNow() -> String
    {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        let years = components.year!
        let months = components.month!
        let days = components.day!
        let hours = components.hour!
        let minutes = components.minute!
        let seconds = components.second!
        
        if years > 0 {
            return years == 1 ? "1 year ago" : "\(years) years ago"
        } else if months > 0 {
            return months == 1 ? "1 month ago" : "\(months) months ago"
        } else if days >= 7 {
            let weeks = days / 7
            return weeks == 1 ? "1 week ago" : "\(weeks) weeks ago"
        } else if days > 0 {
            return days == 1 ? "1 day ago" : "\(days) days ago"
        } else if hours > 0 {
            return hours == 1 ? "1 hour ago" : "\(hours) hours ago"
        } else if minutes > 0 {
            return minutes == 1 ? "1 minute ago" : "\(minutes) minutes ago"
        } else {
            return seconds == 1 ? "1 second ago" : "\(seconds) seconds ago"
        }
    }
    
}


//For textfield chcaracter limit
class TextfieldManager: ObservableObject{
    @Published var text = ""{
        didSet{
            if text.count > charLimit && oldValue.count <= charLimit{
                text = oldValue
            }
        }
    }
    let charLimit: Int
    init(limit: Int = 5) {
        charLimit = limit
    }
}


//to calculate the dynamic hieght and width divide the UIScreen measurements on the result of the division of the hieght, width of 11pro on the postion sent -> num

//to get an image's width and height values if its not known use this
//width(num: UIImage(named: "")!.size.width )
//hieght(num: UIImage(named: "FastWayName")!.size.height)


func hieght(num: CGFloat) -> CGFloat {
    return UIScreen.main.bounds.height/(812/num)
}
func width(num: CGFloat) -> CGFloat {
    return UIScreen.main.bounds.width/(375/num)
}

//calculate dynamic font size according to 11 pro size
func fontSize(num: CGFloat) -> CGFloat{
    return UIScreen.main.bounds.height*(num/812)
}
