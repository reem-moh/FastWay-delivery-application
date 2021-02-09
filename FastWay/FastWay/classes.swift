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
    var phoneNo: String
    var password: String
    
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
            
            print("----------")
            print("inside class Member")
            print("got member data  \(self.name)")
            print("got member data  \(self.email)")
            print("got member data  \(self.phoneNo)")
            print("----------")
        } //listener
    } //function
    
}


class Courier {
    var id: String
    var name: String
    var email: String
    var phoneNo: String
    var password: String
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
            
            print("----------")
            print("inside class Courier")
            print("got Courier data  \(self.name)")
            print("got Courier data  \(self.email)")
            print("got Courier data  \(self.phoneNo)")
            print("----------")
            
        } //listener
    } //function
}




class Order{
    var pickUP: String
    var pickUpBulding: Int
    var pickUpFloor: Int
    var pickUpRoom: String
    var dropOff: String
    var dropOffBulding: Int
    var dropOffFloor: Int
    var dropOffRoom: String
    var orderDetails: String
    
    init(){
        self.pickUP =  ""
        self.pickUpBulding = 0
        self.pickUpFloor = 0
        self.pickUpRoom = ""
        self.dropOff =  ""
        self.dropOffBulding = 0
        self.dropOffFloor = 0
        self.dropOffRoom = ""
        self.orderDetails =  ""
    }
    
    func setpickUPAndpickUpDetails(pickUP: String,pickUpBulding: Int, pickUpFloor: Int, pickUpRoom: String   )-> Bool{
        self.pickUP = pickUP
        self.pickUpBulding = pickUpBulding
        self.pickUpFloor = pickUpFloor
        self.pickUpRoom = pickUpRoom
        var flag = false
        if pickUP != ""
        {
            if pickUpBulding != 0
            {
                if pickUpFloor != 0
                {
                    if pickUpRoom != ""
                    {
                        flag = true
                        
                    }
                }
            }
        }
        else {
            
            flag = false
        }
        
        return flag
    }
    
    func setDropOffAndDropOffDetails(dropOff: String, dropOffBulding: Int, dropOffFloor: Int, dropOffRoom: String   )-> Bool{
        self.dropOff = dropOff
        self.dropOffBulding = dropOffBulding
        self.dropOffFloor = dropOffFloor
        self.dropOffRoom = dropOffRoom
        var flag = false
        if pickUP != ""
        {
            if pickUpBulding != 0
            {
                if pickUpFloor != 0
                {
                    if pickUpRoom != ""
                    {
                        flag = true

                    }
                }
            }
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
        let doc = db.collection("Order").document(id)
        
        doc.setData(["PickUp":self.pickUP, "pickUpBulding":self.pickUpBulding, "pickUpFloor": self.pickUpFloor, "pickUpRoom": self.pickUpRoom, "DropOff":self.dropOff, "dropOffBulding": self.dropOffBulding, "dropOffFloor": self.dropOffFloor, "dropOffRoom": self.dropOffRoom,"orderDetails": self.orderDetails ]) { (error) in
            
            if error != nil {
                flag = false
            }
        }
        
        return flag
    }
    
}
