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
    var email:String?
    
    init(email:String?) {
        self.email = email
    }
}
