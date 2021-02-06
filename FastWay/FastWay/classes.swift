//
//  classes.swift
//  FastWay
//
//  Created by taif.m on 2/4/21.
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
    
    init() {
        self.id = ""
        self.name = ""
        self.email = ""
        self.password = ""
        self.phoneNo = ""
        self.gender = ""
    }
    
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
    
    //retrieve from database if no error return true and data will be assigned to variables
    func getMember(id: String) -> Bool {
        var  flag = true
        
        db.collection("Member").document(id).addSnapshotListener { (querySnapshot, error) in
            guard let doc = querySnapshot else{
                flag = false
                return
            }
            guard let data = doc.data() else {
                    flag = false
                    return
                  }
            //assign values from db to variables
            self.id = id
            self.name = data["Name"] as? String ?? ""
            self.email = data["Email"] as? String ?? ""
            self.password = data["Password"] as? String ?? ""
            self.phoneNo = data["PhoneNo"] as? String ?? ""
            self.gender = data["Gender"] as? String ?? ""
            
        } //listener
        return flag
    } //function
        
}


class Courier {
    var id: String
    var name: String
    var email: String
    var password: String
    var phoneNo: String
    var gender: String
    
    
    init() {
        self.id = ""
        self.name = ""
        self.email = ""
        self.password = ""
        self.phoneNo = ""
        self.gender = ""
    }
    
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
    
    //retrieve from database if no error return true and data will be assigned to variables
    func getCourier(id: String) -> Bool {
        var  flag = true
        
        db.collection("Courier").document(id).addSnapshotListener { (querySnapshot, error) in
            guard let doc = querySnapshot else{
                flag = false
                return
            }
            guard let data = doc.data() else {
                    flag = false
                    return
                  }
            //assign values from db to variables
            self.id = id
            self.name = data["Name"] as? String ?? ""
            self.email = data["Email"] as? String ?? ""
            self.password = data["Password"] as? String ?? ""
            self.phoneNo = data["PhoneNo"] as? String ?? ""
            self.gender = data["Gender"] as? String ?? ""
            
        } //listener
        return flag
    } //function
}
