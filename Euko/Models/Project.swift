//
//  Project.swift
//  Euko
//
//  Created by Victor Lucas on 14/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import Foundation

class Project {
    var id:String?
    var title:String
    var description:String
    var state:String
    var price:Int
    var timeLaps:Int!
    var interests:Float!
    var finalPrice:Float!
    var date:Date
    
    init(id:String = "", title:String = "", description:String = "", state:String = "",
         price:Int = 0, timeLaps:Int = 0, interests:Float = 0.0, finalPrice:Float = 0.0, date:Date = Date()) {
        self.id = id
        self.title = title
        self.description = description
        self.state = state
        self.price = price
        self.timeLaps = timeLaps
        self.interests = interests
        self.finalPrice = finalPrice
        self.date = date
    }
}
