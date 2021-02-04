//
//  classes.swift
//  FastWay
//
//  Created by Shahad AlOtaibi on 22/06/1442 AH.
//
import Foundation
import Firebase
import FirebaseFirestore

let db = Firestore.firestore()

class Member {
    var id: String
    var name: String
    var email: String
    var password: String
    var phoneNo: String
    var gender: String
    
    init(id: String, name: String, email: String, pass: String, phN: String, gen: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = pass
        self.phoneNo = phN
        self.gender = gen
    }
    
    func addMember(member: Member) -> Bool {
        let doc = db.collection("Member").document(id)
        var flag = true
        doc.setData(["ID":self.id, "Name":self.name, "Gender":self.gender, "PhoneNo": self.phoneNo, "Email": self.email, "Password": self.password]) { (error) in
            
            if error != nil {
                flag = false
            }
        }
        
        return flag
    }
    
    
}


class Courier {
    var id: String
    var name: String
    var email: String
    var password: String
    var phoneNo: String
    var gender: String
    
    init(id: String,name: String, email: String, pass: String, phN: String, gen: String) {
        self.id = id
        self.name = name 
        self.email = email
        self.password = pass
        self.phoneNo = phN
        self.gender = gen
    }
    
    func addCourier(courier: Courier) -> Bool {
        let doc = db.collection("Courier").document(id)
        var flag = true
        doc.setData(["ID":self.id, "Name":self.name, "Gender":self.gender, "PhoneNo": self.phoneNo, "Email": self.email, "Password": self.password]) { (error) in
            
            if error != nil {
                flag = false
            }
        }
        
        return flag
    }
    
    
}


class Order{
    var pickUP: String
    var pickUpDetails: String
    var dropOff: String
    var dropOffDetails: String
    var orderDetails: String
    
    init(){
        self.pickUP =  ""
        self.pickUpDetails =  ""
        self.dropOff =  ""
        self.dropOffDetails =  ""
        self.orderDetails =  ""
    }
    
    func setpickUPAndpickUpDetails(pickUP: String,pickUpDetails:String)-> Bool{
        self.pickUP=pickUP
        self.pickUpDetails=pickUpDetails
        return true
    }
    
    func setDropOffAndDropOffDetails(dropOff: String,dropOffDetails:String)-> Bool{
        self.dropOff=dropOff
        self.dropOffDetails=dropOffDetails
        return true

    }
    
    func setOrderDetails(orderDetails: String)-> Bool{
        self.orderDetails=orderDetails
        return true

    }
    
    func addOrder() -> Bool {
        var flag = true
        //need to change the id
        let doc = db.collection("Order").document("5fj6srOHetO5QJLjZcEG")
        
        if pickUP.isEmpty{
            flag =  false
        }else if pickUpDetails.isEmpty{
            flag =  false
        }else if dropOff.isEmpty{
            flag =  false
        }else if dropOffDetails.isEmpty{
            flag =  false
        }else if orderDetails.isEmpty{
            flag =  false
        }
        
        doc.setData(["PickUp":self.pickUP, "PickUpDetails":self.pickUpDetails, "DropOff":self.dropOff, "DropOffDetails": self.dropOffDetails, "OrderDetails": self.orderDetails]) { (error) in
            
            if error != nil {
                flag = false
            }
        }
        
        return flag
    }

}
