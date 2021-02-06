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


class SessionStore: ObservableObject{
    var didChange = PassthroughSubject<SessionStore ,Never>()
    @Published var session: User? {didSet {self.didChange.send(self)}}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen(){
        handle = Auth.auth().addStateDidChangeListener({(auth, user) in
            if let user = user {
                self.session = User(uid: user.uid)
            }else {
                self.session = nil
            }
            
        })
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
        
    }
    
    func logIn(email: String, password: String ,  handler: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.session = nil
        }catch{
            print("Error signing out")
        
        }
    }
    
    func unbind(){
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}

struct User {
    var uid: String
    
    init(uid: String){
        self.uid = uid
    }
}

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
