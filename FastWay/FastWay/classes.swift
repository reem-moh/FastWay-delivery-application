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
        let doc = db.collection("Member").document(id)
        var flag = true
        doc.setData(["ID":self.id, "Name":self.name, "PhoneNo": self.phoneNo, "Email": self.email]) { (error) in
            
            if error != nil {
                flag = false
            }
        }
        
        return flag
    }
    
    //retrieve from database
    func getMember(id: String){
        
        
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
        
    } //function
    
}

class Courier: ObservableObject {
    var id: String
    var name: String
    var email: String
    var phoneNo: String
    @Published var courier = C(id: "", name: "", email: "", phoneNo: "")
    //initialize from DB
    init() {
        self.id = ""
        self.name = ""
        self.email = ""
        self.phoneNo = ""
        self.getCourier(id: UserDefaults.standard.getUderId())
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
    
}

//member info
struct M: Identifiable {
    var id: String
    var name: String
    var email: String
    var phoneNo: String
}
//Courier info
struct C: Identifiable {
    var id: String
    var name: String
    var email: String
    var phoneNo: String
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
    var deliveryPrice = 0.0
    var totalPrice = 0.0
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
    var price: Int
    var courierLocation : CLLocationCoordinate2D
}

class OfferOrder: ObservableObject{
    
    var id: String
    var OrderId: String
    var memberId: String = ""
    var courierId: String = ""
    var price: Int
    var courierLocation : CLLocationCoordinate2D
    var stateOffer: [String] = ["waiting for accept", "cancle Offer", "accept Offer"]
    
    init(){
        self.id = ""
        self.OrderId = ""
        self.memberId = ""
        self.courierId = ""
        self.price = 0
        self.courierLocation =  CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    }
    
    func addOffer(OrderID: String, memberID: String, Price: Int , CourierLocation: CLLocationCoordinate2D ) -> Bool {
        self.OrderId = OrderID
        self.memberId = memberID
        self.price = Price
        self.courierLocation = CourierLocation
        var flag = true
        let id = UserDefaults.standard.getUderId()
        
        let doc = db.collection("Offers").document()
      //  if (self.setPick && self.setDrop && self.setDetails){
        doc.setData(["OrderID": self.OrderId,"memberId": self.memberId ,"courierID": id, "Price":self.price ,"CourierLatitude":self.courierLocation.latitude,"CourierLongitude":self.courierLocation.longitude, "Assigned": "false", "CreatedAt": FieldValue.serverTimestamp(), "StateOffer": self.stateOffer[0]]) { (error) in
                
                if error != nil {
                    flag = false
                }
            }
        
        return flag
    }
    
}

class Order: ObservableObject{
    
    @Published var orders: [OrderDetails] = []
    @Published var memberOrder: [OrderDetails] = []
    @Published var CourierOrderOffered: [OrderDetails] = []
    @Published var offers: [Offer] = []
    
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
    var status: [String] = ["waiting for offer", "cancled","have an offer","assigned", "completed"]
    
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
    
    func setpickUPAndpickUpDetails(pickUP: CLLocationCoordinate2D ,pickUpBulding: Int, pickUpFloor: Int, pickUpRoom: String   )-> Bool{
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
    
    //get data from DB
    func getOrder() {
        // var temp: [OrderDetails] = []
        db.collection("Order").whereField("Assigned", isEqualTo: "false").order(by: "CreatedAt", descending: true).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No order documents")
                return
            }
            self.orders = documents.map({ (queryDocumentSnapshot) -> OrderDetails in
                print(queryDocumentSnapshot.data())
                let data = queryDocumentSnapshot.data()
                let OrderId = queryDocumentSnapshot.documentID
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
                let assigned = data["Assigned"] as? Bool ?? false
                let MemberID = data["MemberID"] as? String ?? ""
                let state = data["Status"] as? String ?? ""
                
                let createdAt = data["CreatedAt"] as? Timestamp ?? Timestamp(date: Date())
                print("order :\(OrderId) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\nin get order and date finc is \(createdAt.dateValue().calenderTimeSinceNow())")
                
                return OrderDetails(id: OrderId, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
            })
            
            
        }
    }
    
    func getMemberOrder(Id: String){
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
                let assigned = data["Assigned"] as? Bool ?? false
                let MemberID = data["MemberID"] as? String ?? ""
                let state = data["Status"] as? String ?? ""
                let createdAt = data["CreatedAt"] as? Timestamp ?? Timestamp(date: Date())
                print("order :\(uid) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\nin get order and date finc is \(createdAt.dateValue().calenderTimeSinceNow())")
                
                return OrderDetails(id: uid, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
            })
        }
    }
    
    func getCourierOrderOffred(Id: String){
       // db.collection("Offers").get
        
        db.collection("Order").document().collection("Offers").whereField("CourierID", isEqualTo: Id).order(by: "CreatedAt", descending: false).addSnapshotListener { (querySnapshot, error) in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let uid = document.documentID
                    print("\(document.documentID) => \(data)")
                    db.collection("Order").document(uid).collection("Offers").whereField("CourierID", isEqualTo: Id).addSnapshotListener { (querySnapshot, err) in
                        guard let documents = querySnapshot?.documents else {
                            print("No order offers courier documents")
                            return
                        }
                        self.CourierOrderOffered = documents.map({ (queryDocumentSnapshot) -> OrderDetails in
                            //let Offerdata = queryDocumentSnapshot.data()
                           // let OfferId = queryDocumentSnapshot.documentID
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
                            let assigned = data["Assigned"] as? Bool ?? false
                            let MemberID = data["MemberID"] as? String ?? ""
                            let state = data["Status"] as? String ?? ""
                            let createdAt = data["CreatedAt"] as? Timestamp ?? Timestamp(date: Date())
                            print("order :\(uid) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\nin get order courier offer and date finc is \(createdAt.dateValue().calenderTimeSinceNow())")
                            print(self.CourierOrderOffered.count)
                            return OrderDetails(id: uid, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID, isAdded: assigned, createdAt: createdAt.dateValue(), status: state)
                        })
                    }//end DB for offer
                    
                }//for loop
            }//else
        }//get Orders
    }

    func addOffer(OrderId: String,memberID: String,price: Int,locationLatiude :Double,locationLongitude :Double)-> Bool{
        let id = UserDefaults.standard.getUderId()
      //  let courier = Courier()
      //  courier.getCourier(id: id)
        var flag = true
         db.collection("Order").document(OrderId).setData([ "Status": status[2]], merge: true)
         let doc = db.collection("Order").document(OrderId).collection("Offers").document(id)
            doc.setData(["OrderID": OrderId,"MemberID": memberID,"CourierID" : id ,"Price": price,"CourierLatitude": locationLatiude,"CourierLongitude":locationLongitude], merge: true){ (error) in
                
                if error != nil {
                    flag = false
                }
            }
        
      /*  if !setCourier(courier: courier, OrderID: OrderId){
            flag = false
        }*/

        return flag
    }
    
  /*  func setCourier(courier: Courier, OrderID: String ) -> Bool {
        let doc = db.collection("Courier").document(courier.id)
        var flag = true
        doc.setData(["ID":courier.id, "Name":courier.name, "PhoneNo": courier.phoneNo, "Email": courier.email, "OrderID": OrderID]) { (error) in
            
            if error != nil {
                flag = false
            }
        }
        
        return flag
    }*/

    
    //get offers from DB
    func getOffers(OrderId: String){
        db.collection("Order").document(OrderId).collection("Offers").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No offer documents")
                
                return
            }
            if(documents.isEmpty){
                print("no offer documents")
            }
            self.offers = documents.map({ (queryDocumentSnapshot) -> Offer in
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
                return Offer( id: offerId, OrderId: orderId , memberId: memberID ,courierId: courierID, price: Price, courierLocation: courierLocation)
            })
        }
    }
    //change the statuse of the order
    func cancelOrder(OrderId: String){
        db.collection("Order").document(OrderId).setData([ "Status": status[1] ], merge: true)
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
