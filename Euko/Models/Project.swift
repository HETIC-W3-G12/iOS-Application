//
//  Project.swift
//  Euko
//
//  Created by Victor Lucas on 14/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import Foundation

class Project {
    var id:Int!
    var title:String!
    var description:String!
    var state:Int!
    var price:Int!
    var timeLaps:Int!
    var interests:Float!
    var finalPrice:Float!
    var date:Date
    
    init(id:Int!, title:String!, description:String!, state:Int!,
         price:Int!, timeLaps:Int!, interests:Float!, finalPrice:Float!, date:Date) {
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
