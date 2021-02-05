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
    
    //retrieve from database
    /*func getMember(id: String) -> Member {
        var member : Member = Member()
        let doc = db.collection("Member").document(id).getDocument { (doc, error) in
            if error == nil {
                if doc != nil && doc!.exists {
                    member = doc!.data()
                }
            }
        }
        return member
    }*/
    
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
