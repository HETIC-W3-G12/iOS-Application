//
//  ExtUserDefaults.swift
//  Euko
//
//  Created by Victor Lucas on 11/05/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import Foundation

extension UserDefaults {
    static let TOKEN_FLAG = "tokenFlag"
    static let LOAN_FLAG = "loanFlag"
    static let USER_FLAG = "userflag"
    static let OPEN_FLAG = "openFlag"
    
    static func setLoan(bool:Bool){
        UserDefaults.standard.set(bool, forKey:"hasloan")
    }
    
    static func hasLoan() -> Bool {
        let bool = self.standard.bool(forKey: "hasloan")
        return bool
    }
    
    static func setUser(user:User) {
        let userData:Data = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.set(userData, forKey:USER_FLAG)
    }
    
    static func deleteUser(){
        UserDefaults.standard.set(nil, forKey:USER_FLAG)
    }
    
    static func getUser() -> User? {
        let userData = self.standard.data(forKey: USER_FLAG)
        if (userData != nil){
            let decodeData:User? = NSKeyedUnarchiver.unarchiveObject(with: userData!) as? User
            return decodeData
        }
        else {
            return nil
        }
    }
    
    static func setToken(token:String){
        self.standard.set(token, forKey:TOKEN_FLAG)
    }
    
    static func getToken() -> String? {
        return self.standard.value(forKey: TOKEN_FLAG) as? String
    }
    
    static func setLoan(loan:Bool){
        self.standard.set(loan, forKey:LOAN_FLAG)
    }
    
    static func getLoan() -> Bool! {
        return (UserDefaults.standard.value(forKey: LOAN_FLAG) as! Bool)
    }
    
    static func isFirstOppening() -> Bool {
        let openned:Bool = self.standard.bool(forKey: OPEN_FLAG)
        if (openned){
            return true
        } else {
            self.standard.set(true, forKey: OPEN_FLAG)
            return false
        }
    }
}
