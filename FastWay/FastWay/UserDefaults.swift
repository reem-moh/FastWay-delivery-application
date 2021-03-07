//
//  UserDefaults.swift
//  FastWay
//
//  Created by Reem on 07/02/2021.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
        case id
        case type
    }
    
    func setIsLoggedIn(value: Bool){
        // false when user press logout
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    func getUderId() -> String{
        //print("inside user defualts getUserId:" )
        //print(UserDefaults.standard.string(forKey: "id") ?? "")
        return UserDefaults.standard.string(forKey: "id") ?? ""
    }
    
    func setUserId(Id : String){
        set(Id, forKey: UserDefaultsKeys.id.rawValue)
        synchronize()
    }
    
    func getUderType() -> String{
        print("inside user defualts getUserType:" )
        print(UserDefaults.standard.string(forKey: "type") ?? "")
        return UserDefaults.standard.string(forKey: "type") ?? ""
    }
    
    func setUserType(Type : String){
        set(Type, forKey: UserDefaultsKeys.type.rawValue)
        synchronize()
    }
    
}
