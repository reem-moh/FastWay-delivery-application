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

let db = Firestore.firestore()

class Member {
    var id: String
    var name: String
    var email: String
    var password: String
    var phoneNo: String
    //var gender: String
    
    init() {
        self.id = ""
        self.name = ""
        self.email = ""
        self.password = ""
        self.phoneNo = ""
        // self.gender = ""
    }
    
    init(id: String, name: String, email: String, pass: String, phN: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = pass
        self.phoneNo = phN
        // self.gender = gen
    }
    
    func addMember(member: Member) -> Bool {
        let doc = db.collection("Member").document(id)
        var flag = true
        doc.setData(["ID":self.id, "Name":self.name, "PhoneNo": self.phoneNo, "Email": self.email, "Password": self.password]) { (error) in
            
            if error != nil {
                flag = false
            }
        }
        
        return flag
    }
    
    //retrieve from database if no error return true and data will be assigned to variables
    func getMember(id: String) {
        
        
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
            self.id = id
            self.name = data["Name"] as? String ?? ""
            self.email = data["Email"] as? String ?? ""
            self.password = data["Password"] as? String ?? ""
            self.phoneNo = data["PhoneNo"] as? String ?? ""
            
        } //listener
    } //function
    
}


class Courier {
    var id: String
    var name: String
    var email: String
    var password: String
    var phoneNo: String
    // var gender: String
    
    
    init() {
        self.id = ""
        self.name = ""
        self.email = ""
        self.password = ""
        self.phoneNo = ""
        // self.gender = ""
    }
    
    init(id: String,name: String, email: String, pass: String, phN: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = pass
        self.phoneNo = phN
        // self.gender = gen
    }
    
    func addCourier(courier: Courier) -> Bool {
        let doc = db.collection("Courier").document(id)
        var flag = true
        doc.setData(["ID":self.id, "Name":self.name, "PhoneNo": self.phoneNo, "Email": self.email, "Password": self.password]) { (error) in
            
            if error != nil {
                flag = false
            }
        }
        
        return flag
    }
    
    //retrieve from database if no error return true and data will be assigned to variables
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
            self.id = id
            self.name = data["Name"] as? String ?? ""
            self.email = data["Email"] as? String ?? ""
            self.password = data["Password"] as? String ?? ""
            self.phoneNo = data["PhoneNo"] as? String ?? ""
            
            
        } //listener
    } //function
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
