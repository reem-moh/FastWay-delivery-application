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
        return UserDefaultsKeys.id.rawValue
    }
    
    func setUserId(Id : String){
        set(Id, forKey: UserDefaultsKeys.id.rawValue)
    }
    
    func getUderType() -> String{
        return UserDefaultsKeys.type.rawValue
    }
    
    func setUserType(Type : String){
        set(Type, forKey: UserDefaultsKeys.type.rawValue)
    }
    
}
