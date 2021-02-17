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
//member/courier struct
struct M: Identifiable {
    var id: String
    var name: String
    var email: String
    var phoneNo: String
}
struct C: Identifiable {
    var id: String
    var name: String
    var email: String
    var phoneNo: String
}

//order struct
struct OrderDetails: Identifiable {
    var id: String
    var pickUP: CLLocationCoordinate2D
    var pickUpBulding: Int
    var pickUpFloor: Int
    var pickUpRoom: String
    var dropOff: CLLocationCoordinate2D
    var dropOffBulding: Int
    var dropOffFloor: Int
    var dropOffRoom: String
    var orderDetails: String
    var memberId : String
    // to identify whether it is added to cart...
    var isAdded: Bool
}

class Order: ObservableObject{
    
    @Published var orders: [OrderDetails] = []//[OrderDetails(id: "1", pickUP: "1", pickUpBulding: 1, pickUpFloor: 1, pickUpRoom: "1", dropOff: "1", dropOffBulding: 1, dropOffFloor: 1, dropOffRoom: "1", orderDetails: "1", isAdded: false),]
    
    var pickUP: CLLocationCoordinate2D
    var pickUpBulding: Int
    var pickUpFloor: Int
    var pickUpRoom: String
    var dropOff: CLLocationCoordinate2D
    var dropOffBulding: Int
    var dropOffFloor: Int
    var dropOffRoom: String
    var orderDetails: String
    var memberId: String
    var memberName: String
    
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
        }else
        
        {
            flag = false

        }
        
        return flag
    }
    
    func addOrder() -> Bool {
        var flag = true
        //need to change the id
        let id = UserDefaults.standard.getUderId()
        let doc = db.collection("Order").document()
        
        doc.setData(["MemberID": id,"PickUp":self.pickUP, "pickUpBulding":self.pickUpBulding, "pickUpFloor": self.pickUpFloor, "pickUpRoom": self.pickUpRoom, "DropOff":self.dropOff, "dropOffBulding": self.dropOffBulding, "dropOffFloor": self.dropOffFloor, "dropOffRoom": self.dropOffRoom,"orderDetails": self.orderDetails, "Assigned": "false" ]) { (error) in
            
            if error != nil {
                flag = false
            }
        }
        
        return flag
    }
    
    //get data from DB
    func getOrder() {
       // var temp: [OrderDetails] = []
        db.collection("Order").whereField("Assigned", isEqualTo: "false").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No order documents")
                return
            }
                self.orders = documents.map({ (queryDocumentSnapshot) -> OrderDetails in
                print(queryDocumentSnapshot.data())
                let data = queryDocumentSnapshot.data()
                let uid = queryDocumentSnapshot.documentID
                let pickup = data["PickUp"] as? CLLocationCoordinate2D ??  CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
                let pickupBuilding = data["pickUpBulding"] as? Int ?? 0
                let pickupFloor = data["pickUpFloor"] as? Int ?? 0
                let pickupRoom = data["pickUpRoom"] as? String ?? ""
                let dropoff = data["DropOff"] as? CLLocationCoordinate2D ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
                let dropoffBuilding = data["dropOffBulding"] as? Int ?? 0
                let dropoffFloor = data["dropOffFloor"] as? Int ?? 0
                let dropoffRoom = data["dropOffRoom"] as? String ?? ""
                let orderDetails = data["orderDetails"] as? String ?? ""
                let assigned = data["Assigned"] as? Bool ?? false
                let MemberID = data["MemberID"] as? String ?? ""
                print("order :\(uid) + \(pickup) + \(dropoff) + assigned: \(assigned)")
                
                    return OrderDetails(id: uid, pickUP: pickup, pickUpBulding: pickupBuilding, pickUpFloor: pickupFloor, pickUpRoom: pickupRoom, dropOff: dropoff, dropOffBulding: dropoffBuilding, dropOffFloor: dropoffFloor, dropOffRoom: dropoffRoom, orderDetails: orderDetails, memberId: MemberID, isAdded: assigned)
            })
            
            
        }
    }
    
    func getMemberName(Id: String) ->String{
        let docRef = db.collection("Member").document(Id)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print("inside getMemberName print doc from firebase :\n \(document.documentID) => \(String(describing: document.data()))")
                print("Inside if statment")
                let data = document.data()
                self.memberName = data?["Name"] as? String ?? ""
                print("\(self.memberName)")
            }
            print("Inside Document")
        }
        print("Inside get member name: \(self.memberName)")
        return self.memberName
    }
    
}


