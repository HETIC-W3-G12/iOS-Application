//
//  Offer.swift
//  Euko
//
//  Created by Victor Lucas on 24/05/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

enum OfferState:String {
    case waiting = "waiting"
    case refused = "refused"
    case accepted = "accepted"
}

class Offer {
    var id:String?
    var state:OfferState?
    var createdDate:Date?
    var investorSignature:UIImage?
    var ownerSignature:UIImage?
    var project:Project?
    
    var deadlines:[Deadline] = []
    
    init(id:String? = "", state:OfferState? = OfferState.waiting, createdDate:Date? = Date(), investorSignature:UIImage? = nil, ownerSignature:UIImage? = nil, project:Project? = nil){
        self.id = id
        self.state = state
        self.createdDate = createdDate
        self.investorSignature = investorSignature
        self.ownerSignature = ownerSignature
    }
    
    func fillDeadlines() {
        
    }
}
