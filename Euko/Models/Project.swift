//
//  Project.swift
//  Euko
//
//  Created by Victor Lucas on 14/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import Foundation

class Project {
    var uid:String!
    var user_uid:String!
    var title:String!
    var description:String!
    var price:Int!
    var timeLaps:Int!
    var interests:Float!
    var finalPrice:Float!
    
    init(uid:String!, user_uid:String!, title:String!, description:String!,
         price:Int!, timeLaps:Int!, interests:Float!, finalPrice:Float!) {
        self.uid = uid
        self.user_uid = user_uid
        self.title = title
        self.description = description
        self.price = price
        self.timeLaps = timeLaps
        self.interests = interests
        self.finalPrice = finalPrice
    }
}
