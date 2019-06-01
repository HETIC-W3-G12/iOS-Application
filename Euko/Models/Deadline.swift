//
//  Deadline.swift
//  Euko
//
//  Created by Victor Lucas on 24/05/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import Foundation

enum DeadlineState:String {
    case waiting = "waiting"
    case done = "done"
    case late = "late"
}

class Deadline {
    var id:String?
    var amout:Double?
    var state:DeadlineState?
    var createdDate:Date?
    var dueDate:Date?
    
    init (id:String = "", amount:Double = 0, state:DeadlineState? = DeadlineState.waiting,
          createdDate:Date? = Date(), dueDate:Date? = Date()) {
        self.id = id
        self.amout = amount
        self.state = state
        self.createdDate = createdDate
        self.dueDate = dueDate
    }
}
