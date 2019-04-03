//
//  User.swift
//  Euko
//
//  Created by Victor Lucas on 06/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import Foundation

enum Type {
    case investisseur
    case emprunteur
}

class User {
    var id:String
    var token:String
    var email:String
    var password:String
    var firstName:String
    var lastName:String
    var birthDate:Date
    var birthPlace:String
    var address:String
    var postCode:Int
    var city:String

    init(id:String = "", token:String = "", email:String = "", password:String = "", firstName:String = "", lastName:String = "",
         address:String = "", postCode:Int = 0, city:String = "", birthPlace:String = "") {
        self.id = id
        self.token = token
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.postCode = postCode
        self.city = city
        self.birthDate = Date()
        self.birthPlace = birthPlace
    }
    
    func setBirthDateFromString(dateString:String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: dateString)
        self.birthDate = date ?? Date()
    }
}
