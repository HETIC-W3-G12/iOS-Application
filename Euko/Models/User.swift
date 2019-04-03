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

class User: NSObject, NSCoding {
    
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
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(postCode, forKey: "postCode")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(birthDate, forKey: "birthDate")
        aCoder.encode(birthPlace, forKey: "birthPlace")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.token = aDecoder.decodeObject(forKey: "token") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        self.password = aDecoder.decodeObject(forKey: "password") as! String
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as! String
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as! String
        self.address = aDecoder.decodeObject(forKey: "address") as! String
        self.postCode = Int(aDecoder.decodeInteger(forKey: "postCode"))
        self.city = aDecoder.decodeObject(forKey: "city") as! String
        self.birthDate = aDecoder.decodeObject(forKey: "birthDate") as! Date
        self.birthPlace = aDecoder.decodeObject(forKey: "birthPlace") as! String
    }
    
}
