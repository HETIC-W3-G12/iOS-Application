//
//  Dashboard.swift
//  Euko
//
//  Created by Victor Lucas on 11/05/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import Foundation

class Dashboard {
    var project:Project?
    var offers:[Project]
    
    init(project:Project? = nil, offers:[Project] = []) {
        self.project = project
        self.offers = offers
    }
    
    func setProject(proj:Project){
        self.project = proj
    }
    
    func getProject() -> Project? {
        return self.project
    }
    
    func setOffers(off:[Project]){
        self.offers = off
    }
    
    func getOffers() -> [Project] {
        return self.offers
    }
    
    func OrderOffersByDate() {
        self.offers.sort(by: {$0.date.compare($1.date) == .orderedDescending})
    }
}
